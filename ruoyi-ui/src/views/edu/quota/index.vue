<template>
  <div class="app-container">
    <el-alert title="账号封禁沿用用户状态开关；此页补充控制上传大小、分享权限、密码分享与最大分享天数。" type="info" :closable="false" show-icon class="mb8" />
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="账号" prop="userName"><el-input v-model="queryParams.userName" placeholder="请输入账号" clearable @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="昵称" prop="nickName"><el-input v-model="queryParams.nickName" placeholder="请输入昵称" clearable @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="空间状态" prop="status"><el-select v-model="queryParams.status" placeholder="请选择空间状态" clearable><el-option label="正常" value="0" /><el-option label="停用" value="1" /></el-select></el-form-item>
      <el-form-item label="账号状态" prop="userStatus"><el-select v-model="queryParams.userStatus" placeholder="请选择账号状态" clearable><el-option label="正常" value="0" /><el-option label="封禁" value="1" /></el-select></el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5"><el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['edu:quota:edit']">修改</el-button></el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>
    <el-table v-loading="loading" :data="quotaList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="账号" prop="userName" align="center" />
      <el-table-column label="昵称" prop="nickName" align="center" />
      <el-table-column label="部门" prop="deptName" align="center" />
      <el-table-column label="角色" prop="roleNames" align="center" :show-overflow-tooltip="true" />
      <el-table-column label="总空间(GB)" prop="storageGb" align="center" width="100" />
      <el-table-column label="已用(MB)" prop="usedStorageMb" align="center" width="100" />
      <el-table-column label="上传限制(MB)" prop="uploadMb" align="center" width="110" />
      <el-table-column label="允许分享" align="center" width="90"><template slot-scope="scope"><el-tag size="mini" :type="scope.row.allowShare === '0' ? 'success' : 'info'">{{ scope.row.allowShare === '0' ? '允许' : '禁止' }}</el-tag></template></el-table-column>
      <el-table-column label="密码分享" align="center" width="90"><template slot-scope="scope"><el-tag size="mini" :type="scope.row.allowPasswordShare === '0' ? 'success' : 'info'">{{ scope.row.allowPasswordShare === '0' ? '允许' : '禁止' }}</el-tag></template></el-table-column>
      <el-table-column label="分享天数" prop="maxShareDays" align="center" width="90" />
      <el-table-column label="账号状态" align="center" width="90"><template slot-scope="scope"><el-tag size="mini" :type="scope.row.userStatus === '0' ? 'success' : 'danger'">{{ scope.row.userStatus === '0' ? '正常' : '封禁' }}</el-tag></template></el-table-column>
      <el-table-column label="封禁原因" prop="banReason" align="center" :show-overflow-tooltip="true" />
      <el-table-column label="操作" align="center" width="100"><template slot-scope="scope"><el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['edu:quota:edit']">修改</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="680px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="110px">
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="账号"><el-input v-model="form.userName" disabled /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="昵称"><el-input v-model="form.nickName" disabled /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="总空间(GB)" prop="storageGb"><el-input-number v-model="form.storageGb" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="已用空间(MB)" prop="usedStorageMb"><el-input-number v-model="form.usedStorageMb" :min="0" :precision="2" controls-position="right" style="width:100%" /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="上传限制(MB)" prop="uploadMb"><el-input-number v-model="form.uploadMb" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="最大分享天数" prop="maxShareDays"><el-input-number v-model="form.maxShareDays" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="允许分享"><el-radio-group v-model="form.allowShare"><el-radio label="0">允许</el-radio><el-radio label="1">禁止</el-radio></el-radio-group></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="密码分享"><el-radio-group v-model="form.allowPasswordShare"><el-radio label="0">允许</el-radio><el-radio label="1">禁止</el-radio></el-radio-group></el-form-item></el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="空间状态"><el-radio-group v-model="form.status"><el-radio label="0">正常</el-radio><el-radio label="1">停用</el-radio></el-radio-group></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="账号状态"><el-radio-group v-model="form.userStatus"><el-radio label="0">正常</el-radio><el-radio label="1">封禁</el-radio></el-radio-group></el-form-item></el-col>
        </el-row>
        <el-form-item label="封禁原因"><el-input v-model="form.banReason" placeholder="如封禁账号，请填写原因" /></el-form-item>
        <el-form-item label="备注"><el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注" /></el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listQuota, getQuota, updateQuota } from '@/api/edu/quota'

export default {
  name: 'EduQuota',
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      quotaList: [],
      single: true,
      ids: [],
      open: false,
      title: '',
      queryParams: { pageNum: 1, pageSize: 10, userName: undefined, nickName: undefined, status: undefined, userStatus: undefined },
      form: {},
      rules: {
        storageGb: [{ required: true, message: '总空间不能为空', trigger: 'blur' }],
        uploadMb: [{ required: true, message: '上传限制不能为空', trigger: 'blur' }],
        maxShareDays: [{ required: true, message: '最大分享天数不能为空', trigger: 'blur' }]
      }
    }
  },
  created() { this.getList() },
  methods: {
    getList() {
      this.loading = true
      listQuota(this.queryParams).then(response => {
        this.quotaList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    reset() {
      this.form = { quotaId: undefined, userId: undefined, userName: undefined, nickName: undefined, storageGb: 5, uploadMb: 100, usedStorageMb: 0, allowShare: '0', allowPasswordShare: '0', maxShareDays: 7, status: '0', userStatus: '0', banReason: undefined, remark: undefined }
      this.resetForm('form')
    },
    cancel() { this.open = false; this.reset() },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.quotaId); this.single = selection.length !== 1 },
    handleUpdate(row) {
      const quotaId = row.quotaId || this.ids[0]
      this.reset()
      getQuota(quotaId).then(response => { this.form = response.data; this.open = true; this.title = '修改空间配额' })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        updateQuota(this.form).then(() => { this.$modal.msgSuccess('修改成功'); this.open = false; this.getList() })
      })
    }
  }
}
</script>
