<template>
  <div class="app-container">
    <el-row :gutter="16" class="mb16">
      <el-col v-for="item in cards" :key="item.key" :span="6">
        <el-card shadow="hover" class="stats-card">
          <div class="stats-card__title">{{ item.label }}</div>
          <div class="stats-card__value">
            <template v-if="item.suffix">{{ formatValue(overview[item.key]) }}{{ item.suffix }}</template>
            <template v-else>{{ formatValue(overview[item.key]) }}</template>
          </div>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16">
      <el-col :span="12">
        <el-card>
          <div slot="header">热门资源 TOP10</div>
          <el-table :data="topResources" size="mini">
            <el-table-column label="资源标题" prop="name" min-width="220" />
            <el-table-column label="下载量" prop="value" width="100" />
          </el-table>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <div slot="header">教师上传排行 TOP10</div>
          <el-table :data="topTeachers" size="mini">
            <el-table-column label="教师" prop="name" min-width="180" />
            <el-table-column label="上传数" prop="value" width="100" />
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16" style="margin-top: 16px">
      <el-col :span="12">
        <el-card>
          <div slot="header">近 30 天活跃用户 TOP10</div>
          <el-table :data="activeUsers" size="mini">
            <el-table-column label="用户" prop="name" min-width="180" />
            <el-table-column label="活跃分" prop="value" width="100" />
          </el-table>
        </el-card>
      </el-col>
      <el-col :span="12">
        <el-card>
          <div slot="header">分类资源分布</div>
          <el-table :data="categoryDistribution" size="mini">
            <el-table-column label="分类" prop="name" min-width="180" />
            <el-table-column label="数量" prop="value" width="100" />
          </el-table>
        </el-card>
      </el-col>
    </el-row>

    <el-row :gutter="16" style="margin-top: 16px">
      <el-col :span="24">
        <el-card>
          <div slot="header">近 7 天上传 / 下载趋势</div>
          <el-table :data="trendTable" size="mini">
            <el-table-column label="日期" prop="day" width="140" />
            <el-table-column label="上传量" prop="uploadValue" width="120" />
            <el-table-column label="下载量" prop="downloadValue" width="120" />
          </el-table>
        </el-card>
      </el-col>
    </el-row>
  </div>
</template>

<script>
import { getStatsDashboard } from '@/api/edu/stats'

export default {
  name: 'EduStats',
  data() {
    return {
      overview: {},
      topResources: [],
      topTeachers: [],
      activeUsers: [],
      categoryDistribution: [],
      trendTable: [],
      cards: [
        { key: 'resourceCount', label: '资源总数' },
        { key: 'courseCount', label: '课程总数' },
        { key: 'commentCount', label: '评论总数' },
        { key: 'downloadCount', label: '下载总数' },
        { key: 'favoriteCount', label: '收藏总数' },
        { key: 'activeUserCount', label: '近 30 天活跃用户' },
        { key: 'pendingAuditCount', label: '待审资源' },
        { key: 'pendingReportCount', label: '待处理举报' },
        { key: 'auditPassRate', label: '审核通过率', suffix: '%' },
        { key: 'reportHandleRate', label: '举报处理率', suffix: '%' },
        { key: 'feedbackCount', label: '反馈总数' },
        { key: 'tagCount', label: '标签数' }
      ]
    }
  },
  created() {
    this.getData()
  },
  methods: {
    getData() {
      getStatsDashboard().then(res => {
        const data = res.data || {}
        this.overview = data.overview || {}
        this.topResources = data.topResources || []
        this.topTeachers = data.topTeachers || []
        this.activeUsers = data.activeUsers || []
        this.categoryDistribution = data.categoryDistribution || []
        const uploads = {}
        const downloads = {}
        ;(data.uploadTrend || []).forEach(item => { uploads[item.day] = item.value })
        ;(data.downloadTrend || []).forEach(item => { downloads[item.day] = item.value })
        const days = Array.from(new Set([...(data.uploadTrend || []).map(i => i.day), ...(data.downloadTrend || []).map(i => i.day)])).sort()
        this.trendTable = days.map(day => ({ day, uploadValue: uploads[day] || 0, downloadValue: downloads[day] || 0 }))
      })
    },
    formatValue(value) {
      if (value === undefined || value === null || value === '') {
        return 0
      }
      return value
    }
  }
}
</script>

<style scoped>
.mb16 {
  margin-bottom: 16px;
}

.stats-card {
  margin-bottom: 16px;
}

.stats-card__title {
  color: #909399;
  margin-bottom: 12px;
}

.stats-card__value {
  font-size: 28px;
  font-weight: 700;
  color: #303133;
}
</style>
