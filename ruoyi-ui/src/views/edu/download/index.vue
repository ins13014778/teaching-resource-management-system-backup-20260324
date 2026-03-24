<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="资源标题"><el-input v-model="queryParams.resourceTitle" clearable placeholder="请输入资源标题" @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item label="下载人"><el-input v-model="queryParams.userName" clearable placeholder="请输入下载人" @keyup.enter.native="handleQuery" /></el-form-item>
      <el-form-item><el-button type="primary" size="mini" icon="el-icon-search" @click="handleQuery">搜索</el-button><el-button size="mini" icon="el-icon-refresh" @click="resetQuery">重置</el-button></el-form-item>
    </el-form>
    <el-row :gutter="10" class="mb8"><el-col :span="1.5"><el-button v-hasPermi="['edu:download:remove']" type="danger" plain size="mini" icon="el-icon-delete" :disabled="multiple" @click="handleDelete">删除</el-button></el-col><right-toolbar :showSearch.sync="showSearch" @queryTable="getList" /></el-row>
    <el-table v-loading="loading" :data="downloadList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" />
      <el-table-column label="日志ID" prop="logId" width="90" />
      <el-table-column label="资源标题" prop="resourceTitle" min-width="220" />
      <el-table-column label="下载人" prop="userName" width="120" />
      <el-table-column label="文件地址" prop="fileUrl" min-width="240" :show-overflow-tooltip="true" />
      <el-table-column label="下载时间" prop="createTime" width="180" />
      <el-table-column label="操作" width="120"><template slot-scope="scope"><el-button v-hasPermi="['edu:download:remove']" size="mini" type="text" @click="handleDelete(scope.row)">删除</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />
  </div>
</template>

<script>
import { listDownload, delDownload } from '@/api/edu/download'
export default {
  name: 'EduDownload',
  data() { return { loading: false, showSearch: true, total: 0, downloadList: [], ids: [], multiple: true, queryParams: { pageNum: 1, pageSize: 10, resourceTitle: undefined, userName: undefined } } },
  created() { this.getList() },
  methods: {
    getList() { this.loading = true; listDownload(this.queryParams).then(res => { this.downloadList = res.rows; this.total = res.total; this.loading = false }) },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleSelectionChange(selection) { this.ids = selection.map(item => item.logId); this.multiple = !selection.length },
    handleDelete(row) { const ids = row.logId || this.ids.join(','); this.$modal.confirm('是否确认删除下载日志“' + ids + '”？').then(() => delDownload(ids)).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {}) }
  }
}
</script>
