<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="课程名称">
        <el-input v-model="queryParams.courseName" placeholder="请输入课程名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="章节标题">
        <el-input v-model="queryParams.chapterTitle" placeholder="请输入章节标题" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态">
        <el-select v-model="queryParams.status" clearable placeholder="请选择状态">
          <el-option label="正常" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" size="mini" icon="el-icon-search" @click="handleQuery">搜索</el-button>
        <el-button size="mini" icon="el-icon-refresh" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5"><el-button v-hasPermi="['edu:chapter:add']" type="primary" plain size="mini" icon="el-icon-plus" @click="handleAdd">新增</el-button></el-col>
      <el-col :span="1.5"><el-button v-hasPermi="['edu:chapter:edit']" type="success" plain size="mini" icon="el-icon-edit" :disabled="single" @click="handleUpdate">修改</el-button></el-col>
      <el-col :span="1.5"><el-button v-hasPermi="['edu:chapter:remove']" type="danger" plain size="mini" icon="el-icon-delete" :disabled="multiple" @click="handleDelete">删除</el-button></el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="chapterList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" />
      <el-table-column label="章节ID" prop="chapterId" width="90" />
      <el-table-column label="课程名称" prop="courseName" min-width="160" show-overflow-tooltip />
      <el-table-column label="章节标题" prop="chapterTitle" min-width="180" show-overflow-tooltip />
      <el-table-column label="章节附件" min-width="220">
        <template slot-scope="scope">
          <el-link v-if="scope.row.attachmentUrl" :href="scope.row.attachmentUrl" target="_blank" :underline="false">{{ scope.row.attachmentName || '查看附件' }}</el-link>
          <span v-else>未上传</span>
        </template>
      </el-table-column>
      <el-table-column label="附件大小(MB)" prop="attachmentSizeMb" width="110" />
      <el-table-column label="排序" prop="orderNum" width="80" />
      <el-table-column label="资源数" prop="resourceCount" width="90" />
      <el-table-column label="状态" width="90">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="操作" width="220">
        <template slot-scope="scope">
          <el-button size="mini" type="text" @click="handleAttachmentPreview(scope.row)">附件</el-button>
          <el-button v-hasPermi="['edu:chapter:edit']" size="mini" type="text" @click="handleUpdate(scope.row)">修改</el-button>
          <el-button v-hasPermi="['edu:chapter:remove']" size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="680px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="所属课程" prop="courseId">
          <el-select v-model="form.courseId" filterable style="width: 100%" placeholder="请选择课程">
            <el-option v-for="item in courseOptions" :key="item.courseId" :label="item.courseName" :value="item.courseId" />
          </el-select>
        </el-form-item>
        <el-form-item label="章节标题" prop="chapterTitle">
          <el-input v-model="form.chapterTitle" placeholder="请输入章节标题" />
        </el-form-item>
        <el-form-item label="章节简介">
          <el-input v-model="form.chapterIntro" type="textarea" :rows="4" placeholder="请输入章节简介" />
        </el-form-item>
        <el-form-item label="章节附件">
          <FileUpload v-model="form.attachmentUrl" :limit="1" :file-size="200" :data="{ bizType: 'course' }" @upload-success="handleAttachmentUploadSuccess" />
          <div v-if="form.attachmentName" class="attachment-tip">已上传：{{ form.attachmentName }}<span v-if="form.attachmentSizeMb">（{{ form.attachmentSizeMb }} MB）</span></div>
        </el-form-item>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="排序"><el-input-number v-model="form.orderNum" :min="1" style="width: 100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="资源数"><el-input-number v-model="form.resourceCount" :min="0" style="width: 100%" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio label="0">正常</el-radio>
            <el-radio label="1">停用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注"><el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" /></el-form-item>
      </el-form>
      <div slot="footer"><el-button type="primary" @click="submitForm">确 定</el-button><el-button @click="cancel">取 消</el-button></div>
    </el-dialog>
  </div>
</template>

<script>
import FileUpload from '@/components/FileUpload'
import { listChapter, getChapter, addChapter, updateChapter, delChapter } from '@/api/edu/chapter'
import { listCourse } from '@/api/edu/course'

export default {
  name: 'EduChapter',
  components: { FileUpload },
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      chapterList: [],
      courseOptions: [],
      ids: [],
      single: true,
      multiple: true,
      open: false,
      title: '',
      queryParams: { pageNum: 1, pageSize: 10, courseName: undefined, chapterTitle: undefined, status: undefined },
      form: {},
      rules: {
        courseId: [{ required: true, message: '请选择课程', trigger: 'change' }],
        chapterTitle: [{ required: true, message: '请输入章节标题', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
    this.loadCourses()
  },
  methods: {
    loadCourses() {
      listCourse({ pageNum: 1, pageSize: 1000 }).then(res => { this.courseOptions = res.rows || [] })
    },
    getList() {
      this.loading = true
      listChapter(this.queryParams).then(res => {
        this.chapterList = res.rows || []
        this.total = res.total || 0
        this.loading = false
      }).catch(() => { this.loading = false })
    },
    reset() {
      this.form = { chapterId: undefined, courseId: undefined, chapterTitle: undefined, chapterIntro: undefined, orderNum: 1, resourceCount: 0, attachmentUrl: undefined, attachmentName: undefined, attachmentSizeMb: 0, status: '0', remark: undefined }
      this.resetForm('form')
    },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.chapterId); this.single = selection.length !== 1; this.multiple = !selection.length },
    handleAdd() { this.reset(); this.open = true; this.title = '新增课程章节' },
    handleUpdate(row) {
      const id = row.chapterId || this.ids[0]
      this.reset()
      getChapter(id).then(res => { this.form = res.data || {}; this.open = true; this.title = '修改课程章节' })
    },
    cancel() { this.open = false; this.reset() },
    handleAttachmentUploadSuccess(res) {
      this.form.attachmentName = (res.originalFilename || '').split(/[\\/]/).pop()
      if (res.size) {
        this.form.attachmentSizeMb = Number((res.size / 1024 / 1024).toFixed(2))
      }
    },
    handleAttachmentPreview(row) {
      if (!row.attachmentUrl) {
        this.$modal.msgWarning('当前章节暂未上传附件')
        return
      }
      window.open(row.attachmentUrl, '_blank')
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        const request = this.form.chapterId ? updateChapter : addChapter
        request(this.form).then(() => {
          this.$modal.msgSuccess(this.form.chapterId ? '修改成功' : '新增成功')
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      const ids = row.chapterId || this.ids.join(',')
      this.$modal.confirm('是否确认删除章节编号“' + ids + '”的数据项？').then(() => delChapter(ids)).then(() => {
        this.$modal.msgSuccess('删除成功')
        this.getList()
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.attachment-tip {
  margin-top: 8px;
  color: #606266;
  font-size: 12px;
}
</style>