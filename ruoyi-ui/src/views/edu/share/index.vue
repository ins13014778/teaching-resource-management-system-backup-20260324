<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="分享标题" prop="shareName"><el-input v-model="queryParams.shareName" placeholder="请输入分享标题" clearable @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="分享人" prop="ownerName"><el-input v-model="queryParams.ownerName" placeholder="请输入分享人姓名" clearable @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="目标类型" prop="targetType"><el-select v-model="queryParams.targetType" placeholder="请选择目标类型" clearable><el-option label="文件夹" value="folder" /><el-option label="文件" value="file" /></el-select></el-form-item>
      <el-form-item label="分享方式" prop="shareMode"><el-select v-model="queryParams.shareMode" placeholder="请选择分享方式" clearable><el-option label="公开链接" value="public" /><el-option label="密码分享" value="password" /><el-option label="指定授权" value="internal" /></el-select></el-form-item>
      <el-form-item label="状态" prop="status"><el-select v-model="queryParams.status" placeholder="请选择状态" clearable><el-option label="正常" value="0" /><el-option label="停用" value="1" /></el-select></el-form-item>
      <el-form-item><el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button><el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button></el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5"><el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['edu:share:add']">新增</el-button></el-col>
      <el-col :span="1.5"><el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['edu:share:edit']">修改</el-button></el-col>
      <el-col :span="1.5"><el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['edu:share:remove']">删除</el-button></el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>
    <el-table v-loading="loading" :data="shareList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="分享ID" prop="shareId" width="90" align="center" />
      <el-table-column label="分享标题" prop="shareName" align="center" :show-overflow-tooltip="true" />
      <el-table-column label="分享人" prop="ownerName" align="center" />
      <el-table-column label="类型" align="center" width="80"><template slot-scope="scope">{{ scope.row.targetType === 'folder' ? '文件夹' : '文件' }}</template></el-table-column>
      <el-table-column label="目标名称" prop="targetName" align="center" :show-overflow-tooltip="true" />
      <el-table-column label="分享方式" align="center" width="90"><template slot-scope="scope">{{ shareModeLabel(scope.row.shareMode) }}</template></el-table-column>
      <el-table-column label="密码" prop="sharePassword" align="center" width="90" />
      <el-table-column label="访问" prop="viewCount" align="center" width="70" />
      <el-table-column label="下载" prop="downloadCount" align="center" width="70" />
      <el-table-column label="到期时间" align="center" width="160"><template slot-scope="scope">{{ parseTime(scope.row.expireTime) }}</template></el-table-column>
      <el-table-column label="状态" align="center" width="90"><template slot-scope="scope"><el-tag size="mini" :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '正常' : '停用' }}</el-tag></template></el-table-column>
      <el-table-column label="操作" align="center" width="160"><template slot-scope="scope"><el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['edu:share:edit']">修改</el-button><el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['edu:share:remove']">删除</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
    <el-dialog :title="title" :visible.sync="open" width="700px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="分享人ID" prop="ownerUserId"><el-input-number v-model="form.ownerUserId" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="分享人姓名" prop="ownerName"><el-input v-model="form.ownerName" placeholder="请输入分享人姓名" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="分享标题" prop="shareName"><el-input v-model="form.shareName" placeholder="请输入分享标题" /></el-form-item>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="目标类型"><el-select v-model="form.targetType" style="width:100%"><el-option label="文件夹" value="folder" /><el-option label="文件" value="file" /></el-select></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="分享方式"><el-select v-model="form.shareMode" style="width:100%"><el-option label="公开链接" value="public" /><el-option label="密码分享" value="password" /><el-option label="指定授权" value="internal" /></el-select></el-form-item></el-col>
        </el-row>
        <el-form-item label="目标名称" prop="targetName"><el-input v-model="form.targetName" placeholder="请输入文件或文件夹名称" /></el-form-item>
        <el-form-item label="目标路径" prop="targetPath"><el-input v-model="form.targetPath" placeholder="请输入逻辑路径，如 /教学共享/数据结构/资料包" /></el-form-item>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="分享密码"><el-input v-model="form.sharePassword" placeholder="公开分享可留空" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="下载上限"><el-input-number v-model="form.downloadLimit" :min="0" controls-position="right" style="width:100%" /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="访问次数"><el-input-number v-model="form.viewCount" :min="0" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="下载次数"><el-input-number v-model="form.downloadCount" :min="0" controls-position="right" style="width:100%" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="到期时间"><el-date-picker v-model="form.expireTime" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择到期时间" style="width:100%" /></el-form-item>
        <el-form-item label="状态"><el-radio-group v-model="form.status"><el-radio label="0">正常</el-radio><el-radio label="1">停用</el-radio></el-radio-group></el-form-item>
        <el-form-item label="备注"><el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注" /></el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer"><el-button type="primary" @click="submitForm">确 定</el-button><el-button @click="cancel">取 消</el-button></div>
    </el-dialog>
  </div>
</template>

<script>
import { listShare, getShare, addShare, updateShare, delShare } from '@/api/edu/share'

export default {
  name: 'EduShare',
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      shareList: [],
      single: true,
      multiple: true,
      ids: [],
      open: false,
      title: '',
      queryParams: { pageNum: 1, pageSize: 10, shareName: undefined, ownerName: undefined, targetType: undefined, shareMode: undefined, status: undefined },
      form: {},
      rules: {
        ownerUserId: [{ required: true, message: '分享人ID不能为空', trigger: 'blur' }],
        ownerName: [{ required: true, message: '分享人姓名不能为空', trigger: 'blur' }],
        shareName: [{ required: true, message: '分享标题不能为空', trigger: 'blur' }],
        targetName: [{ required: true, message: '目标名称不能为空', trigger: 'blur' }],
        targetPath: [{ required: true, message: '目标路径不能为空', trigger: 'blur' }]
      }
    }
  },
  created() { this.getList() },
  methods: {
    shareModeLabel(mode) { return mode === 'public' ? '公开链接' : (mode === 'internal' ? '指定授权' : '密码分享') },
    getList() {
      this.loading = true
      listShare(this.queryParams).then(response => { this.shareList = response.rows; this.total = response.total; this.loading = false })
    },
    reset() {
      this.form = { shareId: undefined, ownerUserId: undefined, ownerName: undefined, shareName: undefined, targetType: 'folder', targetName: undefined, targetPath: undefined, shareMode: 'password', sharePassword: undefined, expireTime: undefined, downloadLimit: 0, downloadCount: 0, viewCount: 0, status: '0', remark: undefined }
      this.resetForm('form')
    },
    cancel() { this.open = false; this.reset() },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.shareId); this.single = selection.length !== 1; this.multiple = !selection.length },
    handleAdd() { this.reset(); this.open = true; this.title = '新增空间分享' },
    handleUpdate(row) {
      const shareId = row.shareId || this.ids[0]
      this.reset()
      getShare(shareId).then(response => { this.form = response.data; this.open = true; this.title = '修改空间分享' })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        const request = this.form.shareId ? updateShare : addShare
        request(this.form).then(() => { this.$modal.msgSuccess(this.form.shareId ? '修改成功' : '新增成功'); this.open = false; this.getList() })
      })
    },
    handleDelete(row) {
      const shareIds = row.shareId || this.ids.join(',')
      this.$modal.confirm('是否确认删除空间分享编号为“' + shareIds + '”的数据项？').then(() => delShare(shareIds)).then(() => {
        this.$modal.msgSuccess('删除成功')
        this.getList()
      }).catch(() => {})
    }
  }
}
</script>
