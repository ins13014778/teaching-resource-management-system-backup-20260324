<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="资源标题" prop="resourceTitle">
        <el-input v-model="queryParams.resourceTitle" placeholder="请输入资源标题" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="资源类型" prop="resourceType">
        <el-select v-model="queryParams.resourceType" placeholder="请选择资源类型" clearable>
          <el-option v-for="item in resourceTypeOptions" :key="item" :label="item" :value="item" />
        </el-select>
      </el-form-item>
      <el-form-item label="审核状态" prop="auditStatus">
        <el-select v-model="queryParams.auditStatus" placeholder="请选择审核状态" clearable>
          <el-option v-for="item in auditStatusOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="发布状态" prop="publishStatus">
        <el-select v-model="queryParams.publishStatus" placeholder="请选择发布状态" clearable>
          <el-option v-for="item in publishStatusOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5"><el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['edu:resource:add']">新增</el-button></el-col>
      <el-col :span="1.5"><el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['edu:resource:edit']">修改</el-button></el-col>
      <el-col :span="1.5"><el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['edu:resource:remove']">删除</el-button></el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="resourceList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="资源ID" prop="resourceId" width="90" align="center" />
      <el-table-column label="资源标题" prop="resourceTitle" min-width="220" show-overflow-tooltip />
      <el-table-column label="类型" prop="resourceType" width="100" align="center" />
      <el-table-column label="分类" prop="categoryName" width="120" align="center" />
      <el-table-column label="课程" prop="courseName" width="140" align="center" show-overflow-tooltip />
      <el-table-column label="标签" prop="tagNames" min-width="160" show-overflow-tooltip />
      <el-table-column label="原始文件名" prop="originalFileName" min-width="180" show-overflow-tooltip />
      <el-table-column label="审核状态" width="100" align="center"><template slot-scope="scope"><el-tag size="mini" :type="statusType(scope.row.auditStatus, 'audit')">{{ statusLabel(scope.row.auditStatus, auditStatusOptions) }}</el-tag></template></el-table-column>
      <el-table-column label="发布状态" width="100" align="center"><template slot-scope="scope"><el-tag size="mini" :type="statusType(scope.row.publishStatus, 'publish')">{{ statusLabel(scope.row.publishStatus, publishStatusOptions) }}</el-tag></template></el-table-column>
      <el-table-column label="推荐" width="90" align="center"><template slot-scope="scope"><el-tag size="mini" :type="scope.row.recommendFlag === '1' ? 'warning' : 'info'">{{ scope.row.recommendFlag === '1' ? '已推荐' : '未推荐' }}</el-tag></template></el-table-column>
      <el-table-column label="下载" prop="downloadCount" width="80" align="center" />
      <el-table-column label="收藏" prop="favoriteCount" width="80" align="center" />
      <el-table-column label="点赞" prop="likeCount" width="80" align="center" />
      <el-table-column label="上传人" prop="uploaderName" width="110" align="center" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="620">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-view" @click="handlePreview(scope.row)">预览</el-button>
          <el-button size="mini" type="text" icon="el-icon-star-off" @click="handleFavorite(scope.row)">收藏</el-button>
          <el-button size="mini" type="text" icon="el-icon-thumb" @click="handleLike(scope.row)">点赞</el-button>
          <el-button size="mini" type="text" icon="el-icon-chat-line-round" @click="handleComment(scope.row)">评论</el-button>
          <el-button size="mini" type="text" icon="el-icon-warning-outline" @click="handleReport(scope.row)">举报</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['edu:resource:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-upload" @click="handleSubmit(scope.row)" v-hasPermi="['edu:resource:audit']">提交审核</el-button>
          <el-button size="mini" type="text" icon="el-icon-star-on" @click="handleRecommend(scope.row)" v-hasPermi="['edu:resource:recommend']">{{ scope.row.recommendFlag === '1' ? '取消推荐' : '设为推荐' }}</el-button>
          <el-button size="mini" type="text" icon="el-icon-download" @click="handleDownload(scope.row)">下载</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['edu:resource:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="760px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row>
          <el-col :span="12"><el-form-item label="资源标题" prop="resourceTitle"><el-input v-model="form.resourceTitle" placeholder="请输入资源标题" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="资源类型" prop="resourceType"><el-select v-model="form.resourceType" placeholder="请选择资源类型" style="width: 100%"><el-option v-for="item in resourceTypeOptions" :key="item" :label="item" :value="item" /></el-select></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12"><el-form-item label="资源分类" prop="categoryName"><treeselect v-model="form.categoryName" :options="categoryOptions" :normalizer="categoryNormalizer" placeholder="请选择资源分类" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="所属课程" prop="courseName"><el-select v-model="form.courseName" placeholder="请选择所属课程" style="width: 100%" filterable clearable><el-option v-for="item in courseOptions" :key="item.courseId" :label="item.courseName" :value="item.courseName" /></el-select></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12"><el-form-item label="资源标签"><el-select v-model="form.tagNameList" multiple collapse-tags placeholder="请选择标签" style="width: 100%"><el-option v-for="item in tagOptions" :key="item.tagId" :label="item.tagName" :value="item.tagName" /></el-select></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="版本号"><el-input v-model="form.resourceVersion" placeholder="如 v1.0" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="资源文件" prop="fileUrl">
              <FileUpload v-model="form.fileUrl" :limit="1" :file-size="200" :file-type="resourceFileTypes" :data="{ bizType: 'resource' }" @upload-success="handleResourceFileUploadSuccess" />
              <div v-if="form.originalFileName" class="upload-meta">
                <div>原始文件名：{{ form.originalFileName }}</div>
                <div>存储类型：{{ form.storageType || 'local' }}</div>
                <div>存储路径：{{ form.storagePath || '-' }}</div>
              </div>
            </el-form-item>
          </el-col>
          <el-col :span="12"><el-form-item label="资源封面"><ImageUpload v-model="form.coverUrl" :limit="1" :file-size="10" :data="{ bizType: 'image' }" @upload-success="handleCoverUploadSuccess" /></el-form-item></el-col>
        </el-row>
        <el-row>
          <el-col :span="12"><el-form-item label="文件大小(MB)"><el-input-number v-model="form.fileSizeMb" :precision="2" :step="0.1" :min="0" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="推荐设置"><el-radio-group v-model="form.recommendFlag"><el-radio label="0">否</el-radio><el-radio label="1">是</el-radio></el-radio-group></el-form-item></el-col>
        </el-row>
        <el-form-item label="资源简介"><el-input v-model="form.resourceDesc" type="textarea" :rows="4" placeholder="请输入资源简介" /></el-form-item>
        <el-form-item label="备注说明"><el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" /></el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer"><el-button type="primary" @click="submitForm">确 定</el-button><el-button @click="cancel">取 消</el-button></div>
    </el-dialog>

    <el-dialog title="资源评论" :visible.sync="commentOpen" width="760px" append-to-body>
      <div v-if="currentResource" class="mb12"><el-alert :title="'当前资源：' + currentResource.resourceTitle" type="info" :closable="false" show-icon /></div>
      <div v-if="replyTarget" class="reply-banner"><span>正在回复：{{ replyTarget.userName }} - {{ replyTarget.content }}</span><el-button type="text" @click="cancelReply">取消回复</el-button></div>
      <el-form ref="commentForm" :model="commentForm" :rules="commentRules" label-width="80px"><el-form-item label="评论内容" prop="content"><el-input v-model="commentForm.content" type="textarea" :rows="3" maxlength="500" show-word-limit placeholder="请输入评论内容" /></el-form-item></el-form>
      <div class="comment-tip">普通用户评论默认进入待审核状态，管理员发布评论将直接展示。</div>
      <el-divider content-position="left">评论列表</el-divider>
      <div v-loading="commentLoading" class="comment-box">
        <el-empty v-if="!commentList.length" description="暂无评论" />
        <div v-for="item in commentList" :key="item.commentId" class="comment-item">
          <div class="comment-header"><div><span class="comment-user">{{ item.userName || '匿名用户' }}</span><span class="comment-time">{{ parseTime(item.createTime) }}</span></div><div class="comment-actions"><el-button type="text" size="mini" @click="handleReply(item)">回复</el-button><el-button type="text" size="mini" @click="handleCommentReport(item)">举报评论</el-button></div></div>
          <div class="comment-content">{{ item.content }}</div>
          <div v-if="item.children && item.children.length" class="comment-children">
            <div v-for="child in item.children" :key="child.commentId" class="comment-child-item">
              <div class="comment-header"><div><span class="comment-user">{{ child.userName || '匿名用户' }}</span><span class="comment-time">{{ parseTime(child.createTime) }}</span></div><div class="comment-actions"><el-button type="text" size="mini" @click="handleReply(child)">回复</el-button><el-button type="text" size="mini" @click="handleCommentReport(child)">举报评论</el-button></div></div>
              <div class="comment-content"><span v-if="child.parentUserName" class="reply-user">回复 {{ child.parentUserName }}：</span>{{ child.content }}</div>
            </div>
          </div>
        </div>
      </div>
      <div slot="footer" class="dialog-footer"><el-button type="primary" @click="submitComment">发布评论</el-button><el-button @click="commentOpen = false">关 闭</el-button></div>
    </el-dialog>

    <el-dialog :title="reportDialogTitle" :visible.sync="reportOpen" width="520px" append-to-body>
      <el-form ref="reportForm" :model="reportForm" :rules="reportRules" label-width="90px">
        <el-form-item label="举报对象"><el-input :value="reportForm.targetTitle" disabled /></el-form-item>
        <el-form-item label="举报类型" prop="reasonType"><el-select v-model="reportForm.reasonType" placeholder="请选择举报类型" style="width: 100%"><el-option v-for="item in reportReasonOptions" :key="item.value" :label="item.label" :value="item.value" /></el-select></el-form-item>
        <el-form-item label="举报说明" prop="reportContent"><el-input v-model="reportForm.reportContent" type="textarea" :rows="4" maxlength="500" show-word-limit placeholder="请输入举报说明" /></el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer"><el-button type="primary" @click="submitReport">提 交</el-button><el-button @click="reportOpen = false">取 消</el-button></div>
    </el-dialog>
  </div>
</template>

<script>
import FileUpload from '@/components/FileUpload'
import ImageUpload from '@/components/ImageUpload'
import { listResource, getResource, addResource, updateResource, delResource, submitResource, recommendResource, downloadResource, getResourceFormOptions } from '@/api/edu/resource'
import { toggleFavorite } from '@/api/edu/favorite'
import { toggleLike } from '@/api/edu/like'
import { listResourceComments, addComment } from '@/api/edu/comment'
import { addReport } from '@/api/edu/report'
import Treeselect from '@riophae/vue-treeselect'
import '@riophae/vue-treeselect/dist/vue-treeselect.css'

export default {
  name: 'EduResource',
  components: { Treeselect, FileUpload, ImageUpload },
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      resourceList: [],
      ids: [],
      single: true,
      multiple: true,
      submitLoading: false,
      open: false,
      commentOpen: false,
      reportOpen: false,
      commentLoading: false,
      title: '',
      currentResource: null,
      replyTarget: null,
      categoryOptions: [],
      courseOptions: [],
      tagOptions: [],
      commentList: [],
      queryParams: { pageNum: 1, pageSize: 10, resourceTitle: undefined, resourceType: undefined, auditStatus: undefined, publishStatus: undefined },
      resourceTypeOptions: ['PDF', 'Word', 'Excel', 'PPT', '图片', '视频', '音频', '压缩包', '外部链接', '题库文件', '教案', '教学大纲', '实验指导书'],
      resourceFileTypes: ['doc', 'docx', 'xls', 'xlsx', 'ppt', 'pptx', 'txt', 'pdf', 'png', 'jpg', 'jpeg', 'gif', 'zip', 'rar', '7z', 'mp4', 'mp3'],
      auditStatusOptions: [{ label: '草稿', value: 'draft' }, { label: '待审核', value: 'pending' }, { label: '已通过', value: 'approved' }, { label: '已驳回', value: 'rejected' }, { label: '已下线', value: 'offline' }],
      publishStatusOptions: [{ label: '草稿', value: 'draft' }, { label: '审核中', value: 'review' }, { label: '已发布', value: 'published' }, { label: '已驳回', value: 'rejected' }, { label: '已下线', value: 'offline' }],
      reportReasonOptions: [{ label: '内容有误', value: 'content_error' }, { label: '版权问题', value: 'copyright' }, { label: '违规违法', value: 'illegal' }, { label: '重复上传', value: 'duplicate' }, { label: '其他', value: 'other' }],
      form: {},
      commentForm: { resourceId: undefined, content: '', parentId: 0 },
      reportForm: { reportType: 'resource', targetId: undefined, targetTitle: '', reasonType: undefined, reportContent: '' },
      rules: {
        resourceTitle: [{ required: true, message: '资源标题不能为空', trigger: 'blur' }],
        resourceType: [{ required: true, message: '资源类型不能为空', trigger: 'change' }],
        categoryName: [{ required: true, message: '资源分类不能为空', trigger: 'change' }],
        fileUrl: [{ required: true, message: '请上传资源文件', trigger: 'blur' }]
      },
      commentRules: { content: [{ required: true, message: '评论内容不能为空', trigger: 'blur' }] },
      reportRules: { reasonType: [{ required: true, message: '举报类型不能为空', trigger: 'change' }], reportContent: [{ required: true, message: '举报说明不能为空', trigger: 'blur' }] }
    }
  },
  computed: {
    reportDialogTitle() { return this.reportForm.reportType === 'comment' ? '举报评论' : '举报资源' }
  },
  created() { this.getList(); this.loadOptions() },
  methods: {
    getList() {
      this.loading = true
      listResource(this.queryParams).then(response => { this.resourceList = response.rows || []; this.total = response.total || 0; this.loading = false }).catch(() => { this.loading = false })
    },
    loadOptions() {
      getResourceFormOptions().then(response => {
        const data = response.data || {}
        this.categoryOptions = data.categories || []
        this.courseOptions = data.courses || []
        this.tagOptions = data.tags || []
      })
    },
    categoryNormalizer(node) {
      if (node.children && !node.children.length) delete node.children
      return { id: node.categoryName, label: node.categoryName, children: node.children }
    },
    statusLabel(value, list) { const target = list.find(item => item.value === value); return target ? target.label : value },
    statusType(value, type) { return type === 'audit' ? ({ draft: 'info', pending: 'warning', approved: 'success', rejected: 'danger', offline: '' }[value] || 'info') : ({ draft: 'info', review: 'warning', published: 'success', rejected: 'danger', offline: '' }[value] || 'info') },
    reset() {
      this.form = { resourceId: undefined, resourceTitle: undefined, resourceType: 'PDF', categoryName: undefined, courseName: undefined, tagNameList: [], tagNames: undefined, fileUrl: undefined, originalFileName: undefined, coverUrl: undefined, resourceVersion: 'v1.0', fileSizeMb: 0, storageType: 'local', storagePath: undefined, previewUrl: undefined, recommendFlag: '0', resourceDesc: undefined, auditStatus: 'draft', publishStatus: 'draft', remark: undefined }
      this.resetForm('form')
    },
    resetCommentForm() { this.commentForm = { resourceId: this.currentResource ? this.currentResource.resourceId : undefined, content: '', parentId: 0 }; this.replyTarget = null; this.resetForm('commentForm') },
    resetReportForm() { this.reportForm = { reportType: 'resource', targetId: this.currentResource ? this.currentResource.resourceId : undefined, targetTitle: this.currentResource ? this.currentResource.resourceTitle : '', reasonType: undefined, reportContent: '' }; this.resetForm('reportForm') },
    cancel() { if (this.submitLoading) return; this.open = false; this.reset() },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.resourceId); this.single = selection.length !== 1; this.multiple = !selection.length },
    handleAdd() { this.reset(); this.open = true; this.title = '新增资源' },
    handleUpdate(row) {
      const resourceId = row.resourceId || this.ids[0]
      this.reset()
      getResource(resourceId).then(response => { this.form = response.data || {}; this.form.tagNameList = this.form.tagNames ? this.form.tagNames.split(',').filter(Boolean) : []; this.open = true; this.title = '修改资源' })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        this.form.tagNames = (this.form.tagNameList || []).join(',')
        const request = this.form.resourceId ? updateResource(this.form) : addResource(this.form)
        request.then(() => { this.$modal.msgSuccess(this.form.resourceId ? '修改成功' : '新增成功'); this.open = false; this.getList() })
      })
    },
    handleResourceFileUploadSuccess(res) {
      this.form.originalFileName = res.originalFilename
      this.form.storageType = res.storageType
      this.form.storagePath = res.storagePath
      this.form.previewUrl = res.url
      if (res && res.size) this.form.fileSizeMb = Number((res.size / 1024 / 1024).toFixed(2))
    },
    handleCoverUploadSuccess() {},
    handleDelete(row) {
      const resourceIds = row.resourceId ? [row.resourceId] : this.ids
      if (!resourceIds.length) return
      this.$confirm('是否确认删除选中的资源？', '提示', { type: 'warning' }).then(() => Promise.all(resourceIds.map(id => delResource(id)))).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {})
    },
    handlePreview(row) {
      const targetUrl = row.previewUrl || row.fileUrl
      if (!targetUrl) { this.$modal.msgError('当前资源未配置文件地址'); return }
      window.open(targetUrl, '_blank')
    },
    handleSubmit(row) { submitResource(row.resourceId).then(() => { this.$modal.msgSuccess('已提交审核'); this.getList() }) },
    handleRecommend(row) {
      const recommendFlag = row.recommendFlag === '1' ? '0' : '1'
      recommendResource(row.resourceId, recommendFlag).then(() => { this.$modal.msgSuccess(recommendFlag === '1' ? '已设为推荐' : '已取消推荐'); this.getList() })
    },
    handleDownload(row) {
      downloadResource(row.resourceId).then(() => { this.$modal.msgSuccess('下载记录已登记'); if (row.fileUrl) window.open(row.fileUrl, '_blank'); this.getList() })
    },
    handleFavorite(row) { toggleFavorite(row.resourceId).then(response => { this.$modal.msgSuccess((response.data && response.data.message) || '操作成功'); this.getList() }) },
    handleLike(row) { toggleLike(row.resourceId).then(response => { this.$modal.msgSuccess((response.data && response.data.message) || '操作成功'); this.getList() }) },
    handleComment(row) { this.currentResource = row; this.commentOpen = true; this.resetCommentForm(); this.loadComments(row.resourceId) },
    loadComments(resourceId) { this.commentLoading = true; listResourceComments(resourceId).then(response => { this.commentList = response.data || []; this.commentLoading = false }).catch(() => { this.commentLoading = false }) },
    handleReply(comment) { this.replyTarget = comment; this.commentForm.parentId = comment.commentId },
    cancelReply() { this.replyTarget = null; this.commentForm.parentId = 0 },
    submitComment() {
      this.$refs.commentForm.validate(valid => {
        if (!valid) return
        addComment(this.commentForm).then(() => { this.$modal.msgSuccess(this.replyTarget ? '回复已提交，等待审核' : '评论已提交，等待审核'); const resourceId = this.commentForm.resourceId; this.resetCommentForm(); this.loadComments(resourceId) })
      })
    },
    handleReport(row) { this.currentResource = row; this.reportOpen = true; this.resetReportForm() },
    handleCommentReport(comment) { this.reportOpen = true; this.reportForm = { reportType: 'comment', targetId: comment.commentId, targetTitle: `评论：${comment.userName || '匿名用户'} - ${comment.content}`, reasonType: undefined, reportContent: '' }; this.resetForm('reportForm') },
    submitReport() {
      this.$refs.reportForm.validate(valid => { if (!valid) return; addReport(this.reportForm).then(() => { this.$modal.msgSuccess('举报已提交'); this.reportOpen = false; this.resetReportForm() }) })
    }
  }
}
</script>

<style scoped>
.comment-tip { margin-bottom: 12px; color: #909399; font-size: 13px; }
.reply-banner { margin-bottom: 12px; padding: 10px 14px; border-radius: 8px; background: #f4f8ff; color: #3a4a63; display: flex; align-items: center; justify-content: space-between; }
.comment-box { max-height: 420px; overflow-y: auto; }
.comment-item, .comment-child-item { padding: 14px; border-radius: 8px; background: #f8fafc; border: 1px solid #ebeef5; }
.comment-item + .comment-item { margin-top: 12px; }
.comment-header { display: flex; justify-content: space-between; align-items: center; gap: 12px; }
.comment-user { font-weight: 600; color: #303133; }
.comment-time { margin-left: 10px; font-size: 12px; color: #909399; }
.comment-content { margin-top: 8px; line-height: 1.75; color: #606266; word-break: break-all; }
.comment-actions { flex-shrink: 0; }
.comment-children { margin-top: 12px; padding-left: 18px; border-left: 2px solid #e4e7ed; }
.comment-child-item + .comment-child-item { margin-top: 10px; }
.reply-user { color: #409EFF; font-weight: 600; }
.upload-meta { margin-top: 8px; font-size: 12px; color: #606266; line-height: 1.8; }
</style>