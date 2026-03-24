<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true">
      <el-form-item label="资源标题"><el-input v-model="queryParams.resourceTitle" clearable placeholder="请输入资源标题" /></el-form-item>
      <el-form-item label="合规等级"><el-select v-model="queryParams.complianceLevel" clearable placeholder="请选择合规等级"><el-option label="安全" value="safe" /><el-option label="预警" value="warning" /><el-option label="高风险" value="high_risk" /></el-select></el-form-item>
      <el-form-item><el-button type="primary" size="mini" @click="getList">搜索</el-button><el-button size="mini" @click="resetQuery">重置</el-button></el-form-item>
    </el-form>
    <el-card class="mb8"><div slot="header">手动执行 AI 审核</div><el-input-number v-model="runResourceId" :min="1" /><el-button type="primary" size="mini" style="margin-left:10px" @click="handleRun">立即审核</el-button></el-card>
    <el-table v-loading="loading" :data="auditList">
      <el-table-column label="结果ID" prop="resultId" width="90" />
      <el-table-column label="资源ID" prop="resourceId" width="90" />
      <el-table-column label="资源标题" prop="resourceTitle" min-width="200" show-overflow-tooltip />
      <el-table-column label="风险分" prop="riskScore" width="100" />
      <el-table-column label="重复分" prop="duplicateScore" width="100" />
      <el-table-column label="合规等级" prop="complianceLevel" width="120" />
      <el-table-column label="命中词" prop="hitWords" min-width="160" show-overflow-tooltip />
      <el-table-column label="审核建议" prop="suggestion" min-width="200" show-overflow-tooltip />
      <el-table-column label="操作" width="180"><template slot-scope="scope"><el-button size="mini" type="text" @click="handleView(scope.row)">查看详情</el-button><el-button size="mini" type="text" @click="handleDelete(scope.row)" v-hasPermi="['ai:audit:remove']">删除</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList"/>
    <el-dialog title="AI 审核详情" :visible.sync="open" width="760px" append-to-body><pre class="pre-block">{{ currentDetail }}</pre></el-dialog>
  </div>
</template>
<script>
import { listAiAudit, getAiAudit, delAiAudit, runAiResourceAudit } from '@/api/ai/audit'
export default {
  name: 'AiAudit',
  data() { return { loading: false, total: 0, auditList: [], open: false, currentDetail: '', runResourceId: 1, queryParams: { pageNum: 1, pageSize: 10, resourceTitle: undefined, complianceLevel: undefined } } },
  created() { this.getList() },
  methods: {
    getList() { this.loading = true; listAiAudit(this.queryParams).then(res => { this.auditList = res.rows || []; this.total = res.total || 0; this.loading = false }).catch(() => { this.loading = false }) },
    resetQuery() { this.resetForm('queryForm'); this.getList() },
    handleRun() { runAiResourceAudit(this.runResourceId).then(() => { this.$modal.msgSuccess('AI 审核执行成功'); this.getList() }) },
    handleView(row) { getAiAudit(row.resultId).then(res => { this.currentDetail = JSON.stringify(res.data, null, 2); this.open = true }) },
    handleDelete(row) { this.$modal.confirm('确认删除该 AI 审核记录吗？').then(() => delAiAudit(row.resultId)).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {}) }
  }
}
</script>
<style scoped>.pre-block{white-space:pre-wrap;word-break:break-all;max-height:500px;overflow:auto;}</style>
