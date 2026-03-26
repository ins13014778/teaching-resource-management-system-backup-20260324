<template>
  <div class="app-container edu-space-page">
    <el-tabs v-model="activeTab">
      <el-tab-pane label="空间文件库" name="space">
        <el-card shadow="never" class="mb16">
          <div slot="header" class="clearfix">
            <span>空间文件库</span>
            <span class="header-tip">支持新建文件夹、上传文件、创建分享、下载与删除</span>
          </div>

          <el-form :inline="true" :model="spaceQuery" size="small" class="mb12">
            <el-form-item label="文件名">
              <el-input v-model="spaceQuery.fileName" placeholder="请输入文件名" clearable @keyup.enter.native="getSpaceList" />
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="el-icon-search" @click="handleSpaceQuery">搜索</el-button>
              <el-button icon="el-icon-refresh" @click="resetSpaceQuery">重置</el-button>
            </el-form-item>
          </el-form>

          <div class="toolbar-row mb12">
            <div>
              <el-button type="primary" plain icon="el-icon-folder-add" size="mini" @click="openFolderDialog" v-hasPermi="['edu:share:add']">新建文件夹</el-button>
              <el-upload
                class="inline-upload"
                :action="uploadUrl"
                :headers="uploadHeaders"
                :data="uploadData"
                :show-file-list="false"
                :before-upload="beforeSpaceUpload"
                :on-success="handleSpaceUploadSuccess"
                :on-error="handleSpaceUploadError"
                v-hasPermi="['edu:share:add']">
                <el-button type="success" plain icon="el-icon-upload2" size="mini">上传文件</el-button>
              </el-upload>
              <el-button type="warning" plain icon="el-icon-share" size="mini" :disabled="spaceSingle" @click="openShareFromSelection" v-hasPermi="['edu:share:add']">创建分享</el-button>
              <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="spaceMultiple" @click="handleDeleteSpace" v-hasPermi="['edu:share:remove']">删除</el-button>
            </div>
            <div class="toolbar-right">
              <span class="crumb-label">当前位置：</span>
              <el-breadcrumb separator="/">
                <el-breadcrumb-item>
                  <a href="javascript:;" @click="goRoot">根目录</a>
                </el-breadcrumb-item>
                <el-breadcrumb-item v-for="item in breadcrumbs" :key="item.fileId">
                  <a href="javascript:;" @click="goBreadcrumb(item)">{{ item.fileName }}</a>
                </el-breadcrumb-item>
              </el-breadcrumb>
            </div>
          </div>

          <el-table v-loading="spaceLoading" :data="spaceList" @selection-change="handleSpaceSelectionChange">
            <el-table-column type="selection" width="55" align="center" />
            <el-table-column label="名称" min-width="240">
              <template slot-scope="scope">
                <el-button v-if="scope.row.targetType === 'folder'" type="text" icon="el-icon-folder-opened" @click="openFolder(scope.row)">
                  {{ scope.row.fileName }}
                </el-button>
                <span v-else><i class="el-icon-document" /> {{ scope.row.fileName }}</span>
              </template>
            </el-table-column>
            <el-table-column label="类型" width="100" align="center">
              <template slot-scope="scope">
                {{ scope.row.targetType === 'folder' ? '文件夹' : '文件' }}
              </template>
            </el-table-column>
            <el-table-column label="原始文件名" prop="originalFileName" min-width="180" show-overflow-tooltip />
            <el-table-column label="大小(MB)" width="100" align="center">
              <template slot-scope="scope">
                {{ scope.row.targetType === 'folder' ? '-' : formatSize(scope.row.fileSizeMb) }}
              </template>
            </el-table-column>
            <el-table-column label="上传人" prop="ownerName" width="120" align="center" />
            <el-table-column label="创建时间" width="170" align="center">
              <template slot-scope="scope">{{ parseTime(scope.row.createTime) }}</template>
            </el-table-column>
            <el-table-column label="操作" width="320" align="center" fixed="right">
              <template slot-scope="scope">
                <el-button v-if="scope.row.targetType === 'folder'" type="text" size="mini" icon="el-icon-folder-opened" @click="openFolder(scope.row)">打开</el-button>
                <el-button v-else type="text" size="mini" icon="el-icon-view" @click="previewFile(scope.row)">预览</el-button>
                <el-button type="text" size="mini" icon="el-icon-edit" @click="openRenameDialog(scope.row)" v-hasPermi="['edu:share:edit']">重命名</el-button>
                <el-button type="text" size="mini" icon="el-icon-share" @click="openShareDialog(scope.row)" v-hasPermi="['edu:share:add']">分享</el-button>
                <el-button v-if="scope.row.targetType !== 'folder'" type="text" size="mini" icon="el-icon-download" @click="previewFile(scope.row)">打开文件</el-button>
                <el-button type="text" size="mini" icon="el-icon-delete" @click="handleDeleteSpace(scope.row)" v-hasPermi="['edu:share:remove']">删除</el-button>
              </template>
            </el-table-column>
          </el-table>

          <pagination
            v-show="spaceTotal > 0"
            :total="spaceTotal"
            :page.sync="spaceQuery.pageNum"
            :limit.sync="spaceQuery.pageSize"
            @pagination="getSpaceList" />
        </el-card>
      </el-tab-pane>

      <el-tab-pane label="分享记录" name="share">
        <el-card shadow="never">
          <div slot="header" class="clearfix">
            <span>分享记录</span>
            <span class="header-tip">支持公开分享、密码分享、失效时间与下载次数限制</span>
          </div>

          <el-form :inline="true" :model="shareQuery" size="small" class="mb12">
            <el-form-item label="分享标题">
              <el-input v-model="shareQuery.shareName" placeholder="请输入分享标题" clearable @keyup.enter.native="getShareList" />
            </el-form-item>
            <el-form-item label="分享方式">
              <el-select v-model="shareQuery.shareMode" placeholder="请选择分享方式" clearable>
                <el-option label="公开链接" value="public" />
                <el-option label="密码分享" value="password" />
                <el-option label="站内授权" value="internal" />
              </el-select>
            </el-form-item>
            <el-form-item label="状态">
              <el-select v-model="shareQuery.status" placeholder="请选择状态" clearable>
                <el-option label="正常" value="0" />
                <el-option label="停用" value="1" />
              </el-select>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="el-icon-search" @click="handleShareQuery">搜索</el-button>
              <el-button icon="el-icon-refresh" @click="resetShareQuery">重置</el-button>
            </el-form-item>
          </el-form>

          <el-table v-loading="shareLoading" :data="shareList">
            <el-table-column label="分享标题" prop="shareName" min-width="180" show-overflow-tooltip />
            <el-table-column label="资源名称" prop="targetName" min-width="180" show-overflow-tooltip />
            <el-table-column label="类型" width="90" align="center">
              <template slot-scope="scope">{{ scope.row.targetType === 'folder' ? '文件夹' : '文件' }}</template>
            </el-table-column>
            <el-table-column label="分享方式" width="100" align="center">
              <template slot-scope="scope">{{ formatShareMode(scope.row.shareMode) }}</template>
            </el-table-column>
            <el-table-column label="提取码" prop="sharePassword" width="100" align="center" />
            <el-table-column label="浏览次数" prop="viewCount" width="90" align="center" />
            <el-table-column label="下载次数" prop="downloadCount" width="90" align="center" />
            <el-table-column label="失效时间" width="170" align="center">
              <template slot-scope="scope">{{ parseTime(scope.row.expireTime) }}</template>
            </el-table-column>
            <el-table-column label="状态" width="90" align="center">
              <template slot-scope="scope">
                <el-tag size="mini" :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag>
              </template>
            </el-table-column>
            <el-table-column label="操作" width="180" align="center" fixed="right">
              <template slot-scope="scope">
                <el-button type="text" size="mini" icon="el-icon-edit" @click="editShare(scope.row)" v-hasPermi="['edu:share:edit']">编辑</el-button>
                <el-button type="text" size="mini" icon="el-icon-delete" @click="deleteShareRecord(scope.row)" v-hasPermi="['edu:share:remove']">删除</el-button>
              </template>
            </el-table-column>
          </el-table>

          <pagination
            v-show="shareTotal > 0"
            :total="shareTotal"
            :page.sync="shareQuery.pageNum"
            :limit.sync="shareQuery.pageSize"
            @pagination="getShareList" />
        </el-card>
      </el-tab-pane>
    </el-tabs>

    <el-dialog title="新建文件夹" :visible.sync="folderDialogVisible" width="420px" append-to-body>
      <el-form ref="folderFormRef" :model="folderForm" :rules="folderRules" label-width="90px">
        <el-form-item label="文件夹名称" prop="fileName">
          <el-input v-model="folderForm.fileName" maxlength="100" placeholder="请输入文件夹名称" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="folderForm.remark" type="textarea" :rows="3" placeholder="可选" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitFolder">确定</el-button>
        <el-button @click="folderDialogVisible = false">取消</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="renameForm.fileId ? '重命名' : '编辑'" :visible.sync="renameDialogVisible" width="420px" append-to-body>
      <el-form ref="renameFormRef" :model="renameForm" :rules="renameRules" label-width="90px">
        <el-form-item label="名称" prop="fileName">
          <el-input v-model="renameForm.fileName" maxlength="100" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="renameForm.remark" type="textarea" :rows="3" placeholder="可选" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitRename">确定</el-button>
        <el-button @click="renameDialogVisible = false">取消</el-button>
      </div>
    </el-dialog>

    <el-dialog :title="shareForm.shareId ? '编辑分享' : '创建分享'" :visible.sync="shareDialogVisible" width="620px" append-to-body>
      <el-form ref="shareFormRef" :model="shareForm" :rules="shareRules" label-width="100px">
        <el-form-item label="分享标题" prop="shareName">
          <el-input v-model="shareForm.shareName" maxlength="100" placeholder="请输入分享标题" />
        </el-form-item>
        <el-form-item label="资源名称">
          <el-input v-model="shareForm.targetName" disabled />
        </el-form-item>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="分享方式" prop="shareMode">
              <el-select v-model="shareForm.shareMode" placeholder="请选择分享方式" style="width: 100%">
                <el-option label="公开链接" value="public" />
                <el-option label="密码分享" value="password" />
                <el-option label="站内授权" value="internal" />
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态">
              <el-radio-group v-model="shareForm.status">
                <el-radio label="0">正常</el-radio>
                <el-radio label="1">停用</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="16">
          <el-col :span="12">
            <el-form-item label="提取码" prop="sharePassword">
              <el-input v-model="shareForm.sharePassword" maxlength="20" placeholder="密码分享时必填" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="下载上限">
              <el-input-number v-model="shareForm.downloadLimit" :min="0" controls-position="right" style="width: 100%" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="失效时间" prop="expireTime">
          <el-date-picker v-model="shareForm.expireTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择失效时间" style="width: 100%" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="shareForm.remark" type="textarea" :rows="3" placeholder="可选" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitShare">确定</el-button>
        <el-button @click="shareDialogVisible = false">取消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { getToken } from '@/utils/auth'
import { addSpace, delSpace, listSpace, updateSpace } from '@/api/edu/space'
import { addShare, delShare, getShare, listShare, updateShare } from '@/api/edu/share'

export default {
  name: 'EduShare',
  data() {
    const createEmptyShareForm = () => ({
      shareId: undefined,
      fileId: undefined,
      shareName: '',
      targetType: 'file',
      targetName: '',
      targetPath: '',
      shareMode: 'public',
      sharePassword: '',
      expireTime: '',
      downloadLimit: 0,
      status: '0',
      downloadCount: 0,
      viewCount: 0,
      remark: ''
    })
    const validatePassword = (rule, value, callback) => {
      if (this.shareForm.shareMode === 'password' && !value) {
        callback(new Error('密码分享时必须填写提取码'))
        return
      }
      callback()
    }
    return {
      activeTab: 'space',
      uploadUrl: process.env.VUE_APP_BASE_API + '/common/upload',
      uploadHeaders: { Authorization: 'Bearer ' + getToken() },
      uploadData: { bizType: 'space' },
      spaceLoading: false,
      shareLoading: false,
      spaceTotal: 0,
      shareTotal: 0,
      spaceList: [],
      shareList: [],
      selectedSpaceRows: [],
      spaceSingle: true,
      spaceMultiple: true,
      currentParentId: 0,
      breadcrumbs: [],
      folderDialogVisible: false,
      renameDialogVisible: false,
      shareDialogVisible: false,
      spaceQuery: {
        pageNum: 1,
        pageSize: 10,
        parentId: 0,
        fileName: undefined
      },
      shareQuery: {
        pageNum: 1,
        pageSize: 10,
        shareName: undefined,
        shareMode: undefined,
        status: undefined
      },
      folderForm: {
        fileName: '',
        remark: ''
      },
      renameForm: {
        fileId: undefined,
        fileName: '',
        remark: ''
      },
      shareForm: createEmptyShareForm(),
      createEmptyShareFormFn: createEmptyShareForm,
      folderRules: {
        fileName: [{ required: true, message: '请输入文件夹名称', trigger: 'blur' }]
      },
      renameRules: {
        fileName: [{ required: true, message: '请输入名称', trigger: 'blur' }]
      },
      shareRules: {
        shareName: [{ required: true, message: '请输入分享标题', trigger: 'blur' }],
        shareMode: [{ required: true, message: '请选择分享方式', trigger: 'change' }],
        sharePassword: [{ validator: validatePassword, trigger: 'blur' }],
        expireTime: [{ required: true, message: '请选择失效时间', trigger: 'change' }]
      }
    }
  },
  created() {
    this.getSpaceList()
    this.getShareList()
  },
  methods: {
    createEmptyShareForm() {
      return this.createEmptyShareFormFn()
    },
    formatSize(size) {
      if (size === undefined || size === null || size === '') return '0.00'
      return Number(size).toFixed(2)
    },
    formatShareMode(mode) {
      return { public: '公开链接', password: '密码分享', internal: '站内授权' }[mode] || mode
    },
    handleSpaceQuery() {
      this.spaceQuery.pageNum = 1
      this.getSpaceList()
    },
    resetSpaceQuery() {
      this.spaceQuery.fileName = undefined
      this.handleSpaceQuery()
    },
    getSpaceList() {
      this.spaceLoading = true
      this.spaceQuery.parentId = this.currentParentId
      listSpace(this.spaceQuery).then(response => {
        this.spaceList = response.rows || []
        this.spaceTotal = response.total || 0
        this.spaceLoading = false
      }).catch(() => {
        this.spaceLoading = false
      })
    },
    handleSpaceSelectionChange(selection) {
      this.selectedSpaceRows = selection
      this.spaceSingle = selection.length !== 1
      this.spaceMultiple = selection.length === 0
    },
    openFolder(row) {
      this.currentParentId = row.fileId
      this.breadcrumbs.push({ fileId: row.fileId, fileName: row.fileName })
      this.spaceQuery.pageNum = 1
      this.getSpaceList()
    },
    goRoot() {
      this.currentParentId = 0
      this.breadcrumbs = []
      this.spaceQuery.pageNum = 1
      this.getSpaceList()
    },
    goBreadcrumb(item) {
      const index = this.breadcrumbs.findIndex(b => b.fileId === item.fileId)
      if (index === -1) return
      this.breadcrumbs = this.breadcrumbs.slice(0, index + 1)
      this.currentParentId = item.fileId
      this.spaceQuery.pageNum = 1
      this.getSpaceList()
    },
    openFolderDialog() {
      this.folderForm = { fileName: '', remark: '' }
      this.folderDialogVisible = true
      this.$nextTick(() => this.resetForm('folderFormRef'))
    },
    submitFolder() {
      this.$refs.folderFormRef.validate(valid => {
        if (!valid) return
        addSpace({
          parentId: this.currentParentId,
          fileName: this.folderForm.fileName,
          targetType: 'folder',
          remark: this.folderForm.remark,
          status: '0'
        }).then(() => {
          this.$modal.msgSuccess('新建文件夹成功')
          this.folderDialogVisible = false
          this.getSpaceList()
        })
      })
    },
    openRenameDialog(row) {
      this.renameForm = {
        fileId: row.fileId,
        fileName: row.fileName,
        remark: row.remark || ''
      }
      this.renameDialogVisible = true
      this.$nextTick(() => this.resetForm('renameFormRef'))
    },
    submitRename() {
      this.$refs.renameFormRef.validate(valid => {
        if (!valid) return
        updateSpace(this.renameForm).then(() => {
          this.$modal.msgSuccess('重命名成功')
          this.renameDialogVisible = false
          this.getSpaceList()
        })
      })
    },
    beforeSpaceUpload(file) {
      const isLt = file.size / 1024 / 1024 <= 500
      if (!isLt) {
        this.$modal.msgError('单次上传文件不能超过 500MB')
      }
      return isLt
    },
    handleSpaceUploadSuccess(res) {
      if (res.code !== 200) {
        this.$modal.msgError(res.msg || '上传失败')
        return
      }
      const originalName = res.originalFilename || res.newFileName || res.fileName || ''
      const fileExt = originalName.includes('.') ? originalName.substring(originalName.lastIndexOf('.') + 1) : ''
      const payload = {
        parentId: this.currentParentId,
        fileName: originalName,
        originalFileName: originalName,
        targetType: 'file',
        fileExt,
        fileSizeMb: Number(((res.size || 0) / 1024 / 1024).toFixed(2)),
        storageType: res.storageType || 'local',
        storagePath: res.storagePath,
        fileUrl: res.url,
        previewUrl: res.url,
        status: '0'
      }
      addSpace(payload).then(() => {
        this.$modal.msgSuccess('文件上传成功')
        this.getSpaceList()
      })
    },
    handleSpaceUploadError() {
      this.$modal.msgError('上传失败，请重试')
    },
    previewFile(row) {
      const url = row.previewUrl || row.fileUrl
      if (!url) {
        this.$modal.msgError('当前文件没有可访问地址')
        return
      }
      window.open(url, '_blank')
    },
    openShareFromSelection() {
      if (this.selectedSpaceRows.length !== 1) {
        this.$modal.msgWarning('请选择一条文件或文件夹再创建分享')
        return
      }
      this.openShareDialog(this.selectedSpaceRows[0])
    },
    openShareDialog(row) {
      const expireTime = this.defaultExpireTime()
      this.shareForm = {
        ...this.createEmptyShareForm(),
        fileId: row.fileId,
        shareName: row.fileName + ' 分享',
        targetType: row.targetType,
        targetName: row.fileName,
        targetPath: row.storagePath || row.fileUrl || row.fileName,
        expireTime
      }
      this.shareDialogVisible = true
      this.$nextTick(() => this.resetForm('shareFormRef'))
    },
    editShare(row) {
      getShare(row.shareId).then(response => {
        this.shareForm = Object.assign(this.createEmptyShareForm(), response.data || {})
        this.shareDialogVisible = true
        this.$nextTick(() => this.resetForm('shareFormRef'))
      })
    },
    submitShare() {
      this.$refs.shareFormRef.validate(valid => {
        if (!valid) return
        const request = this.shareForm.shareId ? updateShare(this.shareForm) : addShare(this.shareForm)
        request.then(() => {
          this.$modal.msgSuccess(this.shareForm.shareId ? '分享修改成功' : '分享创建成功')
          this.shareDialogVisible = false
          this.getShareList()
          this.activeTab = 'share'
        })
      })
    },
    handleDeleteSpace(row) {
      const ids = row ? String(row.fileId) : this.selectedSpaceRows.map(item => item.fileId).join(',')
      if (!ids) return
      this.$modal.confirm('确认删除选中的空间文件吗？').then(() => {
        return delSpace(ids)
      }).then(() => {
        this.$modal.msgSuccess('删除成功')
        this.getSpaceList()
      }).catch(() => {})
    },
    handleShareQuery() {
      this.shareQuery.pageNum = 1
      this.getShareList()
    },
    resetShareQuery() {
      this.shareQuery.shareName = undefined
      this.shareQuery.shareMode = undefined
      this.shareQuery.status = undefined
      this.handleShareQuery()
    },
    getShareList() {
      this.shareLoading = true
      listShare(this.shareQuery).then(response => {
        this.shareList = response.rows || []
        this.shareTotal = response.total || 0
        this.shareLoading = false
      }).catch(() => {
        this.shareLoading = false
      })
    },
    deleteShareRecord(row) {
      this.$modal.confirm('确认删除该分享记录吗？').then(() => {
        return delShare(row.shareId)
      }).then(() => {
        this.$modal.msgSuccess('删除成功')
        this.getShareList()
      }).catch(() => {})
    },
    defaultExpireTime() {
      const date = new Date()
      date.setDate(date.getDate() + 7)
      const pad = v => String(v).padStart(2, '0')
      return `${date.getFullYear()}-${pad(date.getMonth() + 1)}-${pad(date.getDate())} ${pad(date.getHours())}:${pad(date.getMinutes())}:${pad(date.getSeconds())}`
    }
  }
}
</script>

<style scoped>
.edu-space-page .mb12 {
  margin-bottom: 12px;
}
.edu-space-page .mb16 {
  margin-bottom: 16px;
}
.header-tip {
  margin-left: 12px;
  color: #909399;
  font-size: 13px;
}
.toolbar-row {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 16px;
  flex-wrap: wrap;
}
.inline-upload {
  display: inline-block;
  margin: 0 8px;
}
.toolbar-right {
  display: flex;
  align-items: center;
  gap: 8px;
  color: #606266;
}
.crumb-label {
  color: #909399;
}
</style>
