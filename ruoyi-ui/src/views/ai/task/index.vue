<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true">
      <el-form-item label="任务类型">
        <el-input v-model="queryParams.taskType" clearable placeholder="请输入任务类型，如 summary / tags / audit" />
      </el-form-item>
      <el-form-item label="资源标题">
        <el-input v-model="queryParams.resourceTitle" clearable placeholder="请输入资源标题" />
      </el-form-item>
      <el-form-item label="任务状态">
        <el-select v-model="queryParams.taskStatus" clearable placeholder="请选择任务状态">
          <el-option label="成功" value="success" />
          <el-option label="失败" value="failed" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" size="mini" @click="getList">搜索</el-button>
        <el-button size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-card class="mb8">
      <div slot="header">手动执行 AI 任务</div>
      <el-input-number v-model="runResourceId" :min="1" />
      <el-button type="primary" size="mini" style="margin-left:10px" @click="handleRun" v-hasPermi="['ai:task:run']">立即执行</el-button>
    </el-card>

    <el-table v-loading="loading" :data="taskList">
      <el-table-column label="任务ID" prop="taskId" width="90" align="center" />
      <el-table-column label="任务类型" prop="taskType" width="120" />
      <el-table-column label="资源ID" prop="resourceId" width="90" align="center" />
      <el-table-column label="资源标题" prop="resourceTitle" min-width="180" show-overflow-tooltip />
      <el-table-column label="触发场景" prop="triggerScene" width="120" />
      <el-table-column label="任务状态" prop="taskStatus" width="100" />
      <el-table-column label="完成时间" prop="finishTime" width="160">
        <template slot-scope="scope">{{ parseTime(scope.row.finishTime) }}</template>
      </el-table-column>
      <el-table-column label="操作" width="180" align="center">
        <template slot-scope="scope">
          <el-button size="mini" type="text" @click="handleView(scope.row)">查看结果</el-button>
          <el-button size="mini" type="text" @click="handleDelete(scope.row)" v-hasPermi="['ai:task:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList"/>
    <el-dialog title="任务结果详情" :visible.sync="open" width="760px" append-to-body><pre class="pre-block">{{ currentResult }}</pre></el-dialog>
  </div>
</template>
<script>
import { listAiTask, getAiTask, runAiTask, delAiTask } from '@/api/ai/task'
export default {
  name: 'AiTask',
  data() {
    return {
      loading: false,
      total: 0,
      taskList: [],
      open: false,
      currentResult: '',
      runResourceId: 1,
      queryParams: { pageNum: 1, pageSize: 10, taskType: undefined, resourceTitle: undefined, taskStatus: undefined }
    }
  },
  created() { this.getList() },
  methods: {
    getList() { this.loading = true; listAiTask(this.queryParams).then(res => { this.taskList = res.rows || []; this.total = res.total || 0; this.loading = false }).catch(() => { this.loading = false }) },
    resetQuery() { this.resetForm('queryForm'); this.getList() },
    handleRun() { runAiTask(this.runResourceId).then(() => { this.$modal.msgSuccess('AI 任务执行成功'); this.getList() }) },
    handleView(row) { getAiTask(row.taskId).then(res => { this.currentResult = res.data.resultJson || ''; this.open = true }) },
    handleDelete(row) { this.$modal.confirm('确认删除该 AI 任务记录吗？').then(() => delAiTask(row.taskId)).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {}) }
  }
}
</script>
<style scoped>.pre-block{white-space:pre-wrap;word-break:break-all;max-height:500px;overflow:auto;}</style>
