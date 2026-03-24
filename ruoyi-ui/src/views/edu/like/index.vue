<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="资源标题"><el-input v-model="queryParams.resourceTitle" clearable placeholder="请输入资源标题" /></el-form-item>
      <el-form-item label="点赞用户"><el-input v-model="queryParams.userName" clearable placeholder="请输入用户名称" /></el-form-item>
      <el-form-item><el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button><el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button></el-form-item>
    </el-form>
    <el-table v-loading="loading" :data="likeList">
      <el-table-column label="点赞ID" prop="likeId" width="90" align="center" />
      <el-table-column label="资源标题" prop="resourceTitle" min-width="220" show-overflow-tooltip />
      <el-table-column label="用户名称" prop="userName" width="120" />
      <el-table-column label="点赞时间" prop="createTime" width="160"><template slot-scope="scope">{{ parseTime(scope.row.createTime) }}</template></el-table-column>
      <el-table-column label="操作" width="120" align="center"><template slot-scope="scope"><el-button size="mini" type="text" @click="handleDelete(scope.row)" v-hasPermi="['edu:like:remove']">删除</el-button></template></el-table-column>
    </el-table>
    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList"/>
  </div>
</template>
<script>
import { listLike, delLike } from '@/api/edu/like'
export default {
  name: 'EduLike',
  data() { return { loading: false, showSearch: true, total: 0, likeList: [], queryParams: { pageNum: 1, pageSize: 10, resourceTitle: undefined, userName: undefined } } },
  created() { this.getList() },
  methods: {
    getList() { this.loading = true; listLike(this.queryParams).then(res => { this.likeList = res.rows || []; this.total = res.total || 0; this.loading = false }).catch(() => { this.loading = false }) },
    handleQuery() { this.queryParams.pageNum = 1; this.getList() },
    resetQuery() { this.resetForm('queryForm'); this.handleQuery() },
    handleDelete(row) { this.$modal.confirm('确认删除这条点赞记录吗？').then(() => delLike(row.likeId)).then(() => { this.$modal.msgSuccess('删除成功'); this.getList() }).catch(() => {}) }
  }
}
</script>
