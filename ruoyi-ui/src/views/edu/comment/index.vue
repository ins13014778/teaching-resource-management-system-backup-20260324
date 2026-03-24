<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="资源标题"><el-input v-model="queryParams.resourceTitle" clearable placeholder="请输入资源标题" @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="评论人"><el-input v-model="queryParams.userName" clearable placeholder="请输入评论人" @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="审核状态"><el-select v-model="queryParams.auditStatus" clearable placeholder="请选择"><el-option label="待审核" value="pending" /><el-option label="已通过" value="approved" /><el-option label="已驳回" value="rejected" /></el-select></el-form-item>
      <el-form-item><el-button type="primary" size="mini" icon="el-icon-search" @click="handleQuery">搜索</el-button><el-button size="mini" icon="el-icon-refresh" @click="resetQuery">重置</el-button></el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8"><el-col :span="1.5"><el-button v-hasPermi="['edu:comment:remove']" type="danger" plain size="mini" icon="el-icon-delete" :disabled="multiple" @click="handleDelete">删除</el-button></el-col><right-toolbar :showSearch.sync="showSearch" @queryTable="getList" /></el-row>
    <el-table v-loading="loading" :data="commentList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" />
      <el-table-column label="评论ID" prop="commentId" width="90" />
      <el-table-column label="资源标题" prop="resourceTitle" min-width="180" />
      <el-table-column label="评论人" prop="userName" width="100" />
      <el-table-column label="内容" prop="content" min-width="240" :show-overflow-tooltip="true" />
      <el-table-column label="审核状态" width="100"><template slot-scope="scope"><el-tag size="mini" :type="scope.row.auditStatus === 'approved' ? 'success' : (scope.row.auditStatus === 'rejected' ? 'danger' : 'warning')">{{ auditText(scope.row.auditStatus) }}</el-tag></template></el-table-column>
      <el-table-column label="评论时间" prop="createTime" width="180" />
      <el-table-column label="操作" width="180"><template slot-scope="scope"><el-button v-hasPermi="['edu:comment:audit']" size="mini" type="text" @click="handleAudit(scope.row, 'approved')">通过</el-button><el-button v-hasPermi="['edu:comment:audit']" size="mini" type="text" @click="handleAudit(scope.row, 'rejected')">驳回</el-button><el-button v-hasPermi="['edu:comment:remove']" size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script>
import { listComment, delComment, auditComment } from '@/api/edu/comment'
export default {
  name: 'EduComment',
  data() { return { loading: false, showSearch: true, total: 0, commentList: [], ids: [], multiple: true, queryParams: { pageNum: 1, pageSize: 10, resourceTitle: undefined, userName: undefined, auditStatus: undefined } } },
  created() { this.getList() },
  methods: {
    auditText(v) { return { pending: '待审核', approved: '已通过', rejected: '已驳回' }[v] || v },
    getList() { this.loading = true; listComment(this.queryParams).then(res => { this.commentList = res.rows; this.total = res.total; this.loading = false }) },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.commentId); this.multiple = !selection.length },
    handleAudit(row, status) { auditComment(row.commentId, status).then(() => { this.$modal.msgSuccess(status === 'approved' ? '审核通过' : '审核驳回'); this.getList() }) },
    handleDelete(row) { const ids = row.commentId || this.ids.join(','); this.$modal.confirm('是否确认删除评论“' + ids + '”？').then(() => delComment(ids)).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {}) }
  }
}
</script>
