<template>
  <portal-shell>
    <div class="notice-detail">
      <section class="notice-detail__hero">
        <el-button plain size="mini" icon="el-icon-arrow-left" @click="$router.push('/announcements')">返回公告中心</el-button>
        <div class="notice-detail__meta">
          <span>{{ notice.noticeType === '1' ? '通知' : '公告' }}</span>
          <em>{{ formatDate(notice.createTime) }}</em>
        </div>
        <h1>{{ notice.noticeTitle }}</h1>
      </section>

      <section class="notice-detail__body">
        <article class="notice-content" v-loading="loading">
          <div v-if="notice.noticeContent" v-html="notice.noticeContent"></div>
          <div v-else class="notice-content__empty">该公告暂无正文内容。</div>
        </article>

        <aside class="notice-side">
          <h3>更多公告</h3>
          <div v-if="relatedNotices.length" class="notice-side__list">
            <router-link
              v-for="item in relatedNotices"
              :key="item.noticeId"
              :to="`/announcements/${item.noticeId}`"
              class="notice-side__item"
            >
              <strong>{{ item.noticeTitle }}</strong>
              <span>{{ formatDate(item.createTime) }}</span>
            </router-link>
          </div>
          <div v-else class="notice-side__empty">暂无更多公告</div>
        </aside>
      </section>
    </div>
  </portal-shell>
</template>

<script>
import PortalShell from './components/PortalShell'
import { getPortalNotice, listPortalNotices } from '@/api/portal/site'
import { parseTime } from '@/utils/ruoyi'

export default {
  name: 'PortalNoticeDetail',
  components: { PortalShell },
  data() {
    return {
      loading: false,
      notice: {},
      relatedNotices: []
    }
  },
  watch: {
    '$route.params.noticeId': {
      immediate: true,
      handler() {
        this.loadDetail()
      }
    }
  },
  methods: {
    loadDetail() {
      const noticeId = this.$route.params.noticeId
      if (!noticeId) return
      this.loading = true
      getPortalNotice(noticeId).then(res => {
        this.notice = res.data || {}
        document.title = `${this.notice.noticeTitle || '公告详情'} - 教学资源管理系统`
        this.loadRelated()
      }).finally(() => {
        this.loading = false
      })
    },
    loadRelated() {
      listPortalNotices({ pageNum: 1, pageSize: 5 }).then(res => {
        const currentId = Number(this.$route.params.noticeId)
        this.relatedNotices = (res.rows || []).filter(item => item.noticeId !== currentId).slice(0, 4)
      })
    },
    formatDate(time) {
      return parseTime(time, '{y}-{m}-{d}')
    }
  }
}
</script>

<style lang="scss" scoped>
.notice-detail {
  padding: 24px 32px 48px;
}

.notice-detail__hero {
  padding: 42px 0 28px;
  color: #fff;

  h1 {
    margin: 16px 0 0;
    max-width: 920px;
    font-size: 46px;
    line-height: 1.22;
  }
}

.notice-detail__meta {
  display: flex;
  align-items: center;
  gap: 14px;
  margin-top: 24px;
  font-size: 13px;

  span {
    color: #93c5fd;
    font-weight: 700;
    letter-spacing: 0.12em;
  }

  em {
    font-style: normal;
    color: rgba(226, 232, 240, 0.72);
  }
}

.notice-detail__body {
  display: grid;
  grid-template-columns: minmax(0, 1fr) 320px;
  gap: 18px;
}

.notice-content,
.notice-side {
  padding: 30px 32px;
  border-radius: 24px;
  background: rgba(255, 255, 255, 0.96);
}

.notice-content {
  line-height: 1.95;
  color: #334155;
  font-size: 15px;

  ::v-deep h1,
  ::v-deep h2,
  ::v-deep h3 {
    color: #0f172a;
    margin-top: 0;
  }

  ::v-deep img {
    max-width: 100%;
    border-radius: 16px;
  }
}

.notice-content__empty,
.notice-side__empty {
  color: #64748b;
}

.notice-side {
  h3 {
    margin: 0;
    font-size: 20px;
    color: #0f172a;
  }
}

.notice-side__list {
  display: grid;
  gap: 14px;
  margin-top: 18px;
}

.notice-side__item {
  display: block;
  padding-bottom: 14px;
  border-bottom: 1px solid #e2e8f0;

  strong {
    display: block;
    color: #0f172a;
    line-height: 1.7;
  }

  span {
    display: block;
    margin-top: 8px;
    color: #64748b;
    font-size: 13px;
  }
}

@media (max-width: 960px) {
  .notice-detail__body {
    grid-template-columns: 1fr;
  }
}

@media (max-width: 768px) {
  .notice-detail {
    padding: 18px 16px 40px;
  }

  .notice-detail__hero h1 {
    font-size: 34px;
  }

  .notice-content,
  .notice-side {
    padding: 22px 20px;
  }
}
</style>
