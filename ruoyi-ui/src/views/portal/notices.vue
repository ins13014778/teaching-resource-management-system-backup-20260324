<template>
  <portal-shell>
    <div class="notice-page">
      <section class="notice-page__hero">
        <span>公告中心</span>
        <h1>平台通知与教学资源动态</h1>
        <p>这里展示所有公开公告，支持按标题搜索与详情查看，内容直接同步自后端公告管理模块。</p>
      </section>

      <section class="notice-page__filters">
        <el-input
          v-model="queryParams.noticeTitle"
          placeholder="请输入公告标题关键词"
          clearable
          @keyup.enter.native="handleQuery"
          @clear="handleQuery"
        >
          <el-button slot="append" icon="el-icon-search" @click="handleQuery">搜索</el-button>
        </el-input>
      </section>

      <section class="notice-page__list">
        <div v-if="noticeList.length" class="notice-list">
          <router-link
            v-for="item in noticeList"
            :key="item.noticeId"
            :to="`/announcements/${item.noticeId}`"
            class="notice-list__item"
          >
            <div class="notice-list__meta">
              <span>{{ item.noticeType === '1' ? '通知' : '公告' }}</span>
              <em>{{ formatDate(item.createTime) }}</em>
            </div>
            <h3>{{ item.noticeTitle }}</h3>
            <p>{{ extractSummary(item.noticeContent) }}</p>
            <strong>查看详情</strong>
          </router-link>
        </div>
        <div v-else class="notice-page__empty">
          当前没有匹配的公告内容。
        </div>

        <pagination
          v-show="total > 0"
          :total="total"
          :page.sync="queryParams.pageNum"
          :limit.sync="queryParams.pageSize"
          @pagination="getList"
        />
      </section>
    </div>
  </portal-shell>
</template>

<script>
import PortalShell from './components/PortalShell'
import { listPortalNotices } from '@/api/portal/site'
import Pagination from '@/components/Pagination'
import { parseTime } from '@/utils/ruoyi'

export default {
  name: 'PortalNotices',
  components: { PortalShell, Pagination },
  data() {
    return {
      loading: false,
      total: 0,
      noticeList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 9,
        noticeTitle: ''
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listPortalNotices(this.queryParams).then(res => {
        this.noticeList = res.rows || []
        this.total = res.total || 0
      }).finally(() => {
        this.loading = false
      })
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    formatDate(time) {
      return parseTime(time, '{y}-{m}-{d}')
    },
    extractSummary(content) {
      const text = (content || '').replace(/<[^>]+>/g, '').replace(/\s+/g, ' ').trim()
      return text ? text.slice(0, 110) + (text.length > 110 ? '...' : '') : '点击查看公告正文。'
    }
  }
}
</script>

<style lang="scss" scoped>
.notice-page {
  padding: 24px 32px 48px;
}

.notice-page__hero {
  padding: 42px 0 28px;
  color: #fff;

  span {
    display: inline-flex;
    color: #93c5fd;
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 0.12em;
  }

  h1 {
    margin: 12px 0 0;
    font-size: 46px;
    line-height: 1.18;
  }

  p {
    max-width: 760px;
    margin: 18px 0 0;
    color: rgba(226, 232, 240, 0.78);
    line-height: 1.9;
  }
}

.notice-page__filters,
.notice-page__list {
  padding: 28px 32px;
  border-radius: 24px;
  background: rgba(255, 255, 255, 0.96);
}

.notice-page__list {
  margin-top: 18px;
}

.notice-list {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 18px;
}

.notice-list__item {
  display: block;
  padding: 22px;
  border-radius: 22px;
  background: #f8fafc;
  border: 1px solid #e2e8f0;
  transition: transform .2s ease, box-shadow .2s ease, border-color .2s ease;

  &:hover {
    transform: translateY(-4px);
    border-color: rgba(37, 99, 235, 0.2);
    box-shadow: 0 18px 36px rgba(15, 23, 42, 0.08);
  }

  h3 {
    margin: 14px 0 10px;
    font-size: 21px;
    color: #0f172a;
    line-height: 1.55;
  }

  p {
    margin: 0;
    color: #64748b;
    line-height: 1.85;
  }

  strong {
    display: inline-flex;
    margin-top: 16px;
    color: #2563eb;
    font-size: 14px;
  }
}

.notice-list__meta {
  display: flex;
  justify-content: space-between;
  gap: 10px;
  font-size: 13px;

  span {
    color: #2563eb;
    font-weight: 700;
  }

  em {
    font-style: normal;
    color: #64748b;
  }
}

.notice-page__empty {
  color: #64748b;
  line-height: 1.8;
}

@media (max-width: 1100px) {
  .notice-list {
    grid-template-columns: repeat(2, 1fr);
  }
}

@media (max-width: 768px) {
  .notice-page {
    padding: 18px 16px 40px;
  }

  .notice-page__hero,
  .notice-page__filters,
  .notice-page__list {
    padding-left: 20px;
    padding-right: 20px;
  }

  .notice-page__hero h1 {
    font-size: 34px;
  }

  .notice-list {
    grid-template-columns: 1fr;
  }
}
</style>
