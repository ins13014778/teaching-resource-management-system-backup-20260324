<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="教师姓名" prop="teacherName"><el-input v-model="queryParams.teacherName" placeholder="请输入教师姓名" clearable @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="学生姓名" prop="studentName"><el-input v-model="queryParams.studentName" placeholder="请输入学生姓名" clearable @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="课程名称" prop="courseName"><el-input v-model="queryParams.courseName" placeholder="请输入课程名称" clearable @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="授权模板" prop="grantPreset"><el-select v-model="queryParams.grantPreset" placeholder="请选择授权模板" clearable><el-option label="只读" value="read" /><el-option label="下载" value="download" /><el-option label="协作" value="collab" /></el-select></el-form-item>
      <el-form-item label="状态" prop="status"><el-select v-model="queryParams.status" placeholder="请选择状态" clearable><el-option label="启用" value="0" /><el-option label="停用" value="1" /></el-select></el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5"><el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['edu:grant:add']">新增</el-button></el-col>
      <el-col :span="1.5"><el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['edu:grant:edit']">修改</el-button></el-col>
      <el-col :span="1.5"><el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['edu:grant:remove']">删除</el-button></el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>
    <el-table v-loading="loading" :data="grantList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="授权ID" prop="grantId" width="90" align="center" />
      <el-table-column label="教师" prop="teacherName" align="center" />
      <el-table-column label="学生" prop="studentName" align="center" />
      <el-table-column label="课程名称" prop="courseName" align="center" />
      <el-table-column label="授权模板" prop="grantPreset" align="center" />
      <el-table-column label="授权内容" prop="grantPerms" align="center" :show-overflow-tooltip="true" />
      <el-table-column label="到期时间" align="center" width="160"><template slot-scope="scope"><span>{{ parseTime(scope.row.expiresAt) }}</span></template></el-table-column>
      <el-table-column label="状态" align="center" width="90"><template slot-scope="scope"><el-tag size="mini" :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '启用' : '停用' }}</el-tag></template></el-table-column>
      <el-table-column label="备注" prop="remark" align="center" :show-overflow-tooltip="true" />
      <el-table-column label="操作" align="center" width="160"><template slot-scope="scope"><el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['edu:grant:edit']">修改</el-button><el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['edu:grant:remove']">删除</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
    <el-dialog :title="title" :visible.sync="open" width="640px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="教师ID" prop="teacherUserId"><el-input-number v-model="form.teacherUserId" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="教师姓名" prop="teacherName"><el-input v-model="form.teacherName" placeholder="请输入教师姓名" /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="20">
          <el-col :span="12"><el-form-item label="学生ID" prop="studentUserId"><el-input-number v-model="form.studentUserId" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="学生姓名" prop="studentName"><el-input v-model="form.studentName" placeholder="请输入学生姓名" /></el-form-item></el-col>
        </el-row>
        <el-form-item label="课程名称" prop="courseName"><el-input v-model="form.courseName" placeholder="请输入课程名称" /></el-form-item>
        <el-form-item label="授权模板" prop="grantPreset"><el-select v-model="form.grantPreset" style="width:100%"><el-option label="只读" value="read" /><el-option label="下载" value="download" /><el-option label="协作" value="collab" /></el-select></el-form-item>
        <el-form-item label="授权内容"><el-input v-model="form.grantPerms" placeholder="如：资源浏览,资料下载,评论互动" /></el-form-item>
        <el-form-item label="到期时间"><el-date-picker v-model="form.expiresAt" type="datetime" value-format="yyyy-MM-dd HH:mm:ss" placeholder="请选择到期时间" style="width:100%" /></el-form-item>
        <el-form-item label="状态"><el-radio-group v-model="form.status"><el-radio label="0">启用</el-radio><el-radio label="1">停用</el-radio></el-radio-group></el-form-item>
        <el-form-item label="备注"><el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注" /></el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer"><el-button type="primary" @click="submitForm">确 定</el-button><el-button @click="cancel">取 消</el-button></div>
    </el-dialog>
  </div>
</template>

<script>
import { listGrant, getGrant, addGrant, updateGrant, delGrant } from '@/api/edu/grant'

export default {
  name: 'EduGrant',
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      grantList: [],
      single: true,
      multiple: true,
      ids: [],
      open: false,
      title: '',
      queryParams: { pageNum: 1, pageSize: 10, teacherName: undefined, studentName: undefined, courseName: undefined, grantPreset: undefined, status: undefined },
      form: {},
      rules: {
        teacherUserId: [{ required: true, message: '教师ID不能为空', trigger: 'blur' }],
        teacherName: [{ required: true, message: '教师姓名不能为空', trigger: 'blur' }],
        studentUserId: [{ required: true, message: '学生ID不能为空', trigger: 'blur' }],
        studentName: [{ required: true, message: '学生姓名不能为空', trigger: 'blur' }],
        courseName: [{ required: true, message: '课程名称不能为空', trigger: 'blur' }]
      }
    }
  },
  created() { this.getList() },
  methods: {
    getList() {
      this.loading = true
      listGrant(this.queryParams).then(response => { this.grantList = response.rows; this.total = response.total; this.loading = false })
    },
    reset() {
      this.form = { grantId: undefined, teacherUserId: undefined, teacherName: undefined, studentUserId: undefined, studentName: undefined, courseName: undefined, grantPreset: 'read', grantPerms: '资源浏览,资料下载', expiresAt: undefined, status: '0', remark: undefined }
      this.resetForm('form')
    },
    cancel() { this.open = false; this.reset() },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.grantId); this.single = selection.length !== 1; this.multiple = !selection.length },
    handleAdd() { this.reset(); this.open = true; this.title = '新增资源授权' },
    handleUpdate(row) {
      const grantId = row.grantId || this.ids[0]
      this.reset()
      getGrant(grantId).then(response => { this.form = response.data; this.open = true; this.title = '修改资源授权' })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        const request = this.form.grantId ? updateGrant : addGrant
        request(this.form).then(() => { this.$modal.msgSuccess(this.form.grantId ? '修改成功' : '新增成功'); this.open = false; this.getList() })
      })
    },
    handleDelete(row) {
      const grantIds = row.grantId || this.ids.join(',')
      this.$modal.confirm('是否确认删除资源授权编号为“' + grantIds + '”的数据项？').then(() => delGrant(grantIds)).then(() => {
        this.$modal.msgSuccess('删除成功')
        this.getList()
      }).catch(() => {})
    }
  }
}
</script>
