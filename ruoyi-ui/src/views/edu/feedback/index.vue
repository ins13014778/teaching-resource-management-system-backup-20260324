<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="反馈标题"><el-input v-model="queryParams.title" clearable placeholder="请输入反馈标题" @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="反馈人"><el-input v-model="queryParams.userName" clearable placeholder="请输入反馈人" @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="状态"><el-select v-model="queryParams.status" clearable placeholder="请选择"><el-option label="待处理" value="pending" /><el-option label="已回复" value="replied" /></el-select></el-form-item>
      <el-form-item><el-button type="primary" size="mini" icon="el-icon-search" @click="handleQuery">搜索</el-button><el-button size="mini" icon="el-icon-refresh" @click="resetQuery">重置</el-button></el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8"><el-col :span="1.5"><el-button v-hasPermi="['edu:feedback:remove']" type="danger" plain size="mini" icon="el-icon-delete" :disabled="multiple" @click="handleDelete">删除</el-button></el-col><right-toolbar :showSearch.sync="showSearch" @queryTable="getList" /></el-row>
    <el-table v-loading="loading" :data="feedbackList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" />
      <el-table-column label="反馈ID" prop="feedbackId" width="90" />
      <el-table-column label="反馈标题" prop="title" min-width="180" />
      <el-table-column label="反馈人" prop="userName" width="100" />
      <el-table-column label="联系方式" prop="contact" width="140" />
      <el-table-column label="状态" width="100"><template slot-scope="scope"><el-tag size="mini" :type="scope.row.status === 'replied' ? 'success' : 'warning'">{{ scope.row.status === 'replied' ? '已回复' : '待处理' }}</el-tag></template></el-table-column>
      <el-table-column label="创建时间" prop="createTime" width="180" />
      <el-table-column label="操作" width="180"><template slot-scope="scope"><el-button v-hasPermi="['edu:feedback:reply']" size="mini" type="text" @click="handleReply(scope.row)">回复</el-button><el-button v-hasPermi="['edu:feedback:remove']" size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script>
import { listFeedback, replyFeedback, delFeedback } from '@/api/edu/feedback'
export default {
  name: 'EduFeedback',
  data() { return { loading: false, showSearch: true, total: 0, feedbackList: [], ids: [], multiple: true, queryParams: { pageNum: 1, pageSize: 10, title: undefined, userName: undefined, status: undefined } } },
  created() { this.getList() },
  methods: {
    getList() { this.loading = true; listFeedback(this.queryParams).then(res => { this.feedbackList = res.rows; this.total = res.total; this.loading = false }) },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.feedbackId); this.multiple = !selection.length },
    handleReply(row) { this.$modal.prompt('请输入回复内容', '回复反馈').then(({ value }) => replyFeedback({ feedbackId: row.feedbackId, replyContent: value, status: 'replied' })).then(() => { this.$modal.msgSuccess('回复成功'); this.getList() }).catch(() => {}) },
    handleDelete(row) { const ids = row.feedbackId || this.ids.join(','); this.$modal.confirm('是否确认删除反馈“' + ids + '”？').then(() => delFeedback(ids)).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {}) }
  }
}
</script>
