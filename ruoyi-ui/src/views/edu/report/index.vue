<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="举报类型"><el-select v-model="queryParams.reportType" clearable placeholder="请选择"><el-option label="资源" value="resource" /><el-option label="评论" value="comment" /></el-select></el-form-item>
      <el-form-item label="举报人"><el-input v-model="queryParams.reporterName" clearable placeholder="请输入举报人" @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="状态"><el-select v-model="queryParams.status" clearable placeholder="请选择"><el-option label="待处理" value="pending" /><el-option label="已处理" value="processed" /><el-option label="已驳回" value="rejected" /></el-select></el-form-item>
      <el-form-item><el-button type="primary" size="mini" icon="el-icon-search" @click="handleQuery">搜索</el-button><el-button size="mini" icon="el-icon-refresh" @click="resetQuery">重置</el-button></el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8"><el-col :span="1.5"><el-button v-hasPermi="['edu:report:remove']" type="danger" plain size="mini" icon="el-icon-delete" :disabled="multiple" @click="handleDelete">删除</el-button></el-col><right-toolbar :showSearch.sync="showSearch" @queryTable="getList" /></el-row>
    <el-table v-loading="loading" :data="reportList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" />
      <el-table-column label="举报ID" prop="reportId" width="90" />
      <el-table-column label="举报类型" prop="reportType" width="100" />
      <el-table-column label="目标标题" prop="targetTitle" min-width="180" />
      <el-table-column label="举报人" prop="reporterName" width="100" />
      <el-table-column label="原因" prop="reasonType" width="120" />
      <el-table-column label="状态" width="100"><template slot-scope="scope"><el-tag size="mini" :type="scope.row.status === 'processed' ? 'success' : (scope.row.status === 'rejected' ? 'danger' : 'warning')">{{ statusText(scope.row.status) }}</el-tag></template></el-table-column>
      <el-table-column label="举报时间" prop="createTime" width="180" />
      <el-table-column label="操作" width="180"><template slot-scope="scope"><el-button v-hasPermi="['edu:report:handle']" size="mini" type="text" @click="handleProcess(scope.row, 'processed')">处理</el-button><el-button v-hasPermi="['edu:report:handle']" size="mini" type="text" @click="handleProcess(scope.row, 'rejected')">驳回</el-button><el-button v-hasPermi="['edu:report:remove']" size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script>
import { listReport, handleReport, delReport } from '@/api/edu/report'
export default {
  name: 'EduReport',
  data() { return { loading: false, showSearch: true, total: 0, reportList: [], ids: [], multiple: true, queryParams: { pageNum: 1, pageSize: 10, reportType: undefined, reporterName: undefined, status: undefined } } },
  created() { this.getList() },
  methods: {
    statusText(v) { return { pending: '待处理', processed: '已处理', rejected: '已驳回' }[v] || v },
    getList() { this.loading = true; listReport(this.queryParams).then(res => { this.reportList = res.rows; this.total = res.total; this.loading = false }) },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.reportId); this.multiple = !selection.length },
    handleProcess(row, status) { this.$modal.prompt('请输入处理结果', '处理举报').then(({ value }) => handleReport({ reportId: row.reportId, status, handleResult: value })).then(() => { this.$modal.msgSuccess('处理成功'); this.getList() }).catch(() => {}) },
    handleDelete(row) { const ids = row.reportId || this.ids.join(','); this.$modal.confirm('是否确认删除举报记录“' + ids + '”？').then(() => delReport(ids)).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {}) }
  }
}
</script>
