<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true">
      <el-form-item label="模板KEY"><el-input v-model="queryParams.templateKey" clearable placeholder="请输入模板KEY" /></el-form-item>
      <el-form-item label="模板名称"><el-input v-model="queryParams.templateName" clearable placeholder="请输入模板名称" /></el-form-item>
      <el-form-item><el-button type="primary" size="mini" @click="getList">搜索</el-button><el-button size="mini" @click="resetQuery">重置</el-button></el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8"><el-col :span="1.5"><el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['ai:prompt:add']">新增</el-button></el-col></el-row>
    <el-table v-loading="loading" :data="promptList">
      <el-table-column label="ID" prop="templateId" width="90" />
      <el-table-column label="模板KEY" prop="templateKey" width="180" />
      <el-table-column label="模板名称" prop="templateName" width="180" />
      <el-table-column label="状态" prop="status" width="100"><template slot-scope="scope">{{ scope.row.status === '0' ? '启用' : '停用' }}</template></el-table-column>
      <el-table-column label="提示词内容" prop="promptContent" min-width="260" show-overflow-tooltip />
      <el-table-column label="操作" width="180"><template slot-scope="scope"><el-button size="mini" type="text" @click="handleUpdate(scope.row)" v-hasPermi="['ai:prompt:edit']">修改</el-button><el-button size="mini" type="text" @click="handleDelete(scope.row)" v-hasPermi="['ai:prompt:remove']">删除</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList"/>
    <el-dialog :title="title" :visible.sync="open" width="680px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="模板KEY" prop="templateKey"><el-input v-model="form.templateKey" /></el-form-item>
        <el-form-item label="模板名称" prop="templateName"><el-input v-model="form.templateName" /></el-form-item>
        <el-form-item label="提示词内容" prop="promptContent"><el-input v-model="form.promptContent" type="textarea" :rows="6" /></el-form-item>
        <el-form-item label="状态"><el-radio-group v-model="form.status"><el-radio label="0">启用</el-radio><el-radio label="1">停用</el-radio></el-radio-group></el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer"><el-button type="primary" @click="submitForm">确 定</el-button><el-button @click="open=false">取 消</el-button></div>
    </el-dialog>
  </div>
</template>
<script>
import { listAiPrompt, getAiPrompt, addAiPrompt, updateAiPrompt, delAiPrompt } from '@/api/ai/prompt'
export default {
  name: 'AiPrompt',
  data() { return { loading: false, total: 0, promptList: [], open: false, title: '', queryParams: { pageNum: 1, pageSize: 10, templateKey: undefined, templateName: undefined }, form: {}, rules: { templateKey: [{ required: true, message: '模板KEY不能为空', trigger: 'blur' }], templateName: [{ required: true, message: '模板名称不能为空', trigger: 'blur' }], promptContent: [{ required: true, message: '提示词内容不能为空', trigger: 'blur' }] } } },
  created() { this.getList() },
  methods: {
    getList() { this.loading = true; listAiPrompt(this.queryParams).then(res => { this.promptList = res.rows || []; this.total = res.total || 0; this.loading = false }).catch(() => { this.loading = false }) },
    reset() { this.form = { templateId: undefined, templateKey: '', templateName: '', promptContent: '', status: '0' }; this.resetForm('form') },
    resetQuery() { this.resetForm('queryForm'); this.getList() },
    handleAdd() { this.reset(); this.title = '新增 AI 提示词'; this.open = true },
    handleUpdate(row) { this.reset(); getAiPrompt(row.templateId).then(res => { this.form = res.data; this.title = '修改 AI 提示词'; this.open = true }) },
    submitForm() { this.$refs.form.validate(valid => { if (!valid) return; const req = this.form.templateId ? updateAiPrompt : addAiPrompt; req(this.form).then(() => { this.$modal.msgSuccess(this.form.templateId ? '修改成功' : '新增成功'); this.open = false; this.getList() }) }) },
    handleDelete(row) { this.$modal.confirm('确认删除该提示词模板吗？').then(() => delAiPrompt(row.templateId)).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {}) }
  }
}
</script>
