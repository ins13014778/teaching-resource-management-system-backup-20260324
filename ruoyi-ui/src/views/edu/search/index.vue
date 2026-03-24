<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true">
      <el-form-item label="搜索关键词">
        <el-input v-model="queryParams.keyword" placeholder="请输入标题、标签、课程或上传人" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="资源类型">
        <el-select v-model="queryParams.resourceType" clearable placeholder="全部类型">
          <el-option v-for="item in resourceTypes" :key="item" :label="item" :value="item" />
        </el-select>
      </el-form-item>
      <el-form-item label="分类">
        <el-input v-model="queryParams.categoryName" clearable placeholder="请输入分类名称" />
      </el-form-item>
      <el-form-item label="课程">
        <el-input v-model="queryParams.courseName" clearable placeholder="请输入课程名称" />
      </el-form-item>
      <el-form-item label="排序方式">
        <el-select v-model="queryParams.orderBy">
          <el-option label="最新上传" value="latest" />
          <el-option label="下载量优先" value="download" />
          <el-option label="收藏量优先" value="favorite" />
          <el-option label="点赞量优先" value="like" />
        </el-select>
      </el-form-item>
      <el-form-item label="搜索模式">
        <el-radio-group v-model="mode">
          <el-radio-button label="basic">基础搜索</el-radio-button>
          <el-radio-button label="semantic">语义搜索</el-radio-button>
        </el-radio-group>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-alert
      title="基础搜索按字段精确匹配；语义搜索会结合 AI 托管能力，返回更接近用户意图的资源结果。"
      type="info"
      :closable="false"
      show-icon
      class="mb8"
    />

    <el-table v-loading="loading" :data="resultList">
      <el-table-column label="资源ID" prop="resourceId" width="90" align="center" />
      <el-table-column label="资源标题" prop="resourceTitle" min-width="220" show-overflow-tooltip />
      <el-table-column label="课程" prop="courseName" width="140" show-overflow-tooltip />
      <el-table-column label="分类" prop="categoryName" width="120" />
      <el-table-column label="类型" prop="resourceType" width="100" />
      <el-table-column label="语义得分" min-width="100">
        <template slot-scope="scope">{{ scope.row.semanticScore || '-' }}</template>
      </el-table-column>
      <el-table-column label="下载" prop="downloadCount" width="80" align="center" />
      <el-table-column label="收藏" prop="favoriteCount" width="80" align="center" />
      <el-table-column label="点赞" prop="likeCount" width="80" align="center" />
      <el-table-column label="操作" width="120" align="center">
        <template slot-scope="scope">
          <el-button type="text" size="mini" @click="handlePreview(scope.row)">预览</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>
</template>

<script>
import { basicSearch, semanticSearch } from '@/api/edu/search'

export default {
  name: 'EduSearch',
  data() {
    return {
      loading: false,
      mode: 'basic',
      resultList: [],
      queryParams: {
        keyword: '',
        resourceType: undefined,
        categoryName: undefined,
        courseName: undefined,
        orderBy: 'latest'
      },
      resourceTypes: ['PDF', 'Word', 'Excel', 'PPT', '图片', '视频', '音频', '压缩包', '外部链接', '题库文件', '教案', '教学大纲', '实验指导书']
    }
  },
  methods: {
    handleQuery() {
      this.loading = true
      const api = this.mode === 'semantic' ? semanticSearch : basicSearch
      api(this.queryParams).then(res => {
        this.resultList = res.data || []
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    resetQuery() {
      this.resetForm('queryForm')
      this.queryParams.orderBy = 'latest'
      this.resultList = []
    },
    handlePreview(row) {
      if (!row.fileUrl) {
        this.$modal.msgError('当前资源未配置文件地址')
        return
      }
      window.open(row.fileUrl, '_blank')
    }
  }
}
</script>
