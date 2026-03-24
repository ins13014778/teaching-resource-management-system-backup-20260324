<template>
  <div class="app-container">
    <el-card class="mb8">
      <div slot="header">AI 智能问答</div>
      <el-input v-model="question" type="textarea" :rows="3" placeholder="请输入你的问题，例如：哪里可以找到高等数学期末复习 PPT？" />
      <div style="margin-top:10px"><el-button type="primary" size="mini" @click="handleAsk" v-hasPermi="['ai:qa:ask']">立即提问</el-button></div>
      <div v-if="answer" class="answer-box">
        <h4>AI 回答</h4>
        <p>{{ answer }}</p>
        <div v-if="references.length">
          <h4>相关资源</h4>
          <ul><li v-for="item in references" :key="item.resourceId">{{ item.resourceTitle }}，相关度：{{ item.semanticScore }} 分</li></ul>
        </div>
      </div>
    </el-card>
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true"><el-form-item label="问题关键字"><el-input v-model="queryParams.question" clearable placeholder="请输入问题关键字" /></el-form-item><el-form-item><el-button type="primary" size="mini" @click="getList">查询记录</el-button><el-button size="mini" @click="resetQuery">重置</el-button></el-form-item></el-form>
    <el-table v-loading="loading" :data="logList"><el-table-column label="日志ID" prop="qaId" width="90" /><el-table-column label="提问人" prop="userName" width="120" /><el-table-column label="问题" prop="question" min-width="200" show-overflow-tooltip /><el-table-column label="回答" prop="answer" min-width="260" show-overflow-tooltip /><el-table-column label="模型" prop="modelName" width="150" /><el-table-column label="耗时(ms)" prop="costMillis" width="100" /><el-table-column label="创建时间" prop="createTime" width="160"><template slot-scope="scope">{{ parseTime(scope.row.createTime) }}</template></el-table-column><el-table-column label="操作" width="120"><template slot-scope="scope"><el-button size="mini" type="text" @click="handleDelete(scope.row)" v-hasPermi="['ai:qa:remove']">删除</el-button></template></el-table-column></el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList"/>
  </div>
</template>
<script>
import { listQaLog, askAiQuestion, delQaLog } from '@/api/ai/qa'
export default {
  name: 'AiQa',
  data() { return { loading: false, total: 0, logList: [], question: '', answer: '', references: [], queryParams: { pageNum: 1, pageSize: 10, question: undefined } } },
  created() { this.getList() },
  methods: {
    getList() { this.loading = true; listQaLog(this.queryParams).then(res => { this.logList = res.rows || []; this.total = res.total || 0; this.loading = false }).catch(() => { this.loading = false }) },
    resetQuery() { this.resetForm('queryForm'); this.getList() },
    handleAsk() { if (!this.question) { this.$modal.msgError('请输入要提问的内容'); return } askAiQuestion(this.question).then(res => { this.answer = res.data.answer; this.references = res.data.references || []; this.getList() }) },
    handleDelete(row) { this.$modal.confirm('确认删除这条问答记录吗？').then(() => delQaLog(row.qaId)).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {}) }
  }
}
</script>
<style scoped>.answer-box{margin-top:16px;padding:16px;border-radius:6px;background:#f5f7fa;line-height:1.8;}</style>
