<template>
  <portal-shell>
    <div class="portal-home">
      <section class="hero">
        <div class="hero__content">
          <div class="hero__eyebrow">{{ config.heroBadge }}</div>
          <h1>{{ config.heroTitle }}</h1>
          <p>{{ config.heroSubtitle }}</p>
          <div class="hero__actions">
            <el-button type="primary" size="medium" @click="navigate(config.heroPrimaryLink)">{{ config.heroPrimaryText }}</el-button>
            <el-button plain size="medium" @click="navigate(config.heroSecondaryLink)">{{ config.heroSecondaryText }}</el-button>
          </div>
        </div>

        <div class="hero__right">
          <div class="hero__carousel-card">
            <el-carousel v-if="banners.length" height="300px" indicator-position="outside">
              <el-carousel-item v-for="item in banners" :key="item.bannerId">
                <div class="hero__carousel-item" @click="openBanner(item)">
                  <img v-if="item.imageUrl" :src="resolveAssetUrl(item.imageUrl)" :alt="item.bannerTitle">
                  <div class="hero__carousel-overlay"></div>
                  <div class="hero__carousel-copy">
                    <span>重要资讯</span>
                    <h3>{{ item.bannerTitle }}</h3>
                    <p>{{ item.bannerSubtitle }}</p>
                    <el-button v-if="item.buttonText || item.targetUrl" type="primary" size="mini" plain>{{ item.buttonText || '查看详情' }}</el-button>
                  </div>
                </div>
              </el-carousel-item>
            </el-carousel>
            <div v-else class="hero__banner-empty">
              <strong>重要资讯展示位</strong>
              <p>管理员可在后台“教学资源 / 官网轮播图”中上传首页轮播图和资讯卡片内容，官网将实时展示。</p>
            </div>
          </div>

          <div class="hero__aside">
            <div class="hero__aside-title">
              <span>{{ config.noticePanelTitle }}</span>
              <router-link to="/announcements">{{ config.noticePanelMoreText }}</router-link>
            </div>
            <div v-if="latestNotices.length" class="hero__notice-list">
              <router-link v-for="item in latestNotices" :key="item.noticeId" :to="`/announcements/${item.noticeId}`" class="hero__notice-item">
                <strong>{{ item.noticeTitle }}</strong>
                <span>{{ formatDate(item.createTime) }}</span>
              </router-link>
            </div>
            <div v-else class="hero__empty">当前暂无公开公告，管理员可在后台“系统管理 / 通知公告”中发布。</div>
          </div>
        </div>
      </section>

      <section class="stats">
        <div class="stats__item">
          <strong>{{ stats.courseCount }}</strong>
          <span>课程专题</span>
        </div>
        <div class="stats__item">
          <strong>{{ stats.resourceCount }}</strong>
          <span>资源条目</span>
        </div>
        <div class="stats__item">
          <strong>{{ stats.teacherCount }}</strong>
          <span>教师账号</span>
        </div>
        <div class="stats__item">
          <strong>{{ stats.studentCount }}</strong>
          <span>学生账号</span>
        </div>
      </section>

      <section id="capability" class="section section--light">
        <div class="section__head">
          <span>平台能力</span>
          <h2>官网重点用于展示通知公告、重要资讯与教学资源动态</h2>
        </div>
        <div class="capability-grid">
          <article class="capability">
            <i class="el-icon-bell"></i>
            <h3>公告实时同步</h3>
            <p>官网公告中心直接读取后台公告数据，管理端发布或修改后，首页与公告详情页会同步更新。</p>
          </article>
          <article class="capability">
            <i class="el-icon-picture-outline"></i>
            <h3>首页轮播后台可配</h3>
            <p>支持上传轮播图、设置标题副标题、排序和跳转链接，用于突出校园重要资讯和专题活动。</p>
          </article>
          <article class="capability">
            <i class="el-icon-edit-outline"></i>
            <h3>官网内容可控</h3>
            <p>站点 Logo、中文英文标题、首页主视觉文案、页脚说明等均可在后台统一维护并即时生效。</p>
          </article>
          <article class="capability">
            <i class="el-icon-data-analysis"></i>
            <h3>资源动态统一展示</h3>
            <p>课程数、资源数、教师数、学生数等基础数据在官网汇总展示，便于学校统一对外呈现平台建设成果。</p>
          </article>
        </div>
      </section>

      <section class="section section--dark workflow">
        <div class="section__head section__head--light">
          <span>内容运营流程</span>
          <h2>从后台发布到官网展示，形成统一的信息发布窗口</h2>
        </div>
        <div class="workflow__line">
          <div class="workflow__node">
            <em>01</em>
            <strong>后台编辑官网内容</strong>
            <p>管理员在后台修改站点 Logo、标题、首页文案、轮播图和公告展示文案。</p>
          </div>
          <div class="workflow__node">
            <em>02</em>
            <strong>发布公告与资讯</strong>
            <p>在系统公告中发布重要通知，在官网轮播图中维护专题活动、重点资源和最新资讯。</p>
          </div>
          <div class="workflow__node">
            <em>03</em>
            <strong>官网实时展示</strong>
            <p>首页和公告中心面向访客公开展示，形成统一、专业的教学资源门户首页。</p>
          </div>
        </div>
      </section>

      <section class="section section--light announce-preview">
        <div class="section__head">
          <span>公告预览</span>
          <h2>首页同步展示最新通知与平台动态</h2>
        </div>
        <div v-if="latestNotices.length" class="announce-preview__list">
          <router-link v-for="item in latestNotices" :key="item.noticeId" :to="`/announcements/${item.noticeId}`" class="announce-preview__item">
            <div class="announce-preview__meta">
              <span>{{ noticeTypeLabel(item.noticeType) }}</span>
              <em>{{ formatDate(item.createTime) }}</em>
            </div>
            <h3>{{ item.noticeTitle }}</h3>
            <p>{{ extractSummary(item.noticeContent) }}</p>
          </router-link>
        </div>
        <div v-else class="announce-preview__empty">
          暂无公告内容。你可以先在管理端“系统管理 / 通知公告”里发布一批官网公告。
        </div>
      </section>

      <section class="section section--cta">
        <div>
          <span>公告中心</span>
          <h2>官网首页只做公开展示，重点承载公告发布、重要资讯和教学资源动态展示</h2>
        </div>
        <div class="section--cta__actions">
          <router-link to="/announcements" class="cta-link">查看全部公告</router-link>
          <a href="#capability" class="cta-link cta-link--ghost" @click.prevent="navigate('#capability')">了解官网能力</a>
        </div>
      </section>
    </div>
  </portal-shell>
</template>

<script>
import { isExternal } from '@/utils/validate'
import PortalShell from './components/PortalShell'
import { getPortalOverview } from '@/api/portal/site'
import { parseTime } from '@/utils/ruoyi'

const createDefaultConfig = () => ({
  heroBadge: '统一教学资源门户',
  heroTitle: '面向学校与院系的教学资源官网',
  heroSubtitle: '统一展示公告、重要资讯与教学资源动态，让学校和访客可以在官网首页快速获取核心信息。',
  heroPrimaryText: '查看公告中心',
  heroPrimaryLink: '/announcements',
  heroSecondaryText: '了解官网能力',
  heroSecondaryLink: '#capability',
  noticePanelTitle: '最新公告',
  noticePanelMoreText: '全部公告'
})

export default {
  name: 'PortalHome',
  components: { PortalShell },
  data() {
    return {
      baseUrl: process.env.VUE_APP_BASE_API,
      config: createDefaultConfig(),
      stats: {
        courseCount: 0,
        resourceCount: 0,
        teacherCount: 0,
        studentCount: 0,
        noticeCount: 0
      },
      latestNotices: [],
      banners: []
    }
  },
  created() {
    this.loadOverview()
  },
  methods: {
    loadOverview() {
      getPortalOverview().then(res => {
        const data = res.data || {}
        this.stats = data.stats || this.stats
        this.latestNotices = data.latestNotices || []
        this.banners = data.banners || []
        this.config = { ...createDefaultConfig(), ...(data.config || {}) }
      })
    },
    resolveAssetUrl(url) {
      if (!url) return ''
      if (isExternal(url) || url.indexOf(this.baseUrl) === 0) {
        return url
      }
      return this.baseUrl + url
    },
    navigate(url) {
      if (!url) return
      if (url.startsWith('#')) {
        const target = document.getElementById(url.slice(1))
        if (target) {
          target.scrollIntoView({ behavior: 'smooth', block: 'start' })
        }
        return
      }
      if (isExternal(url)) {
        window.open(url, '_blank')
        return
      }
      this.$router.push(url)
    },
    openBanner(item) {
      if (!item || !item.targetUrl) return
      this.navigate(item.targetUrl)
    },
    formatDate(time) {
      return parseTime(time, '{y}-{m}-{d}')
    },
    noticeTypeLabel(type) {
      return type === '1' ? '通知' : '公告'
    },
    extractSummary(content) {
      const text = (content || '').replace(/<[^>]+>/g, '').replace(/\s+/g, ' ').trim()
      return text ? text.slice(0, 72) + (text.length > 72 ? '...' : '') : '点击查看公告详情与完整正文。'
    }
  }
}
</script>

<style lang="scss" scoped>
.portal-home {
  padding-bottom: 48px;
}

.hero {
  display: grid;
  grid-template-columns: 1.05fr 0.95fr;
  gap: 26px;
  padding: 42px 32px 28px;
  color: #fff;
}

.hero__content {
  padding: 46px 10px 30px 0;

  h1 {
    margin: 12px 0 0;
    font-size: 56px;
    line-height: 1.08;
    letter-spacing: -0.03em;
  }

  p {
    max-width: 720px;
    margin: 22px 0 0;
    color: rgba(226, 232, 240, 0.82);
    font-size: 17px;
    line-height: 1.9;
  }
}

.hero__eyebrow {
  display: inline-flex;
  align-items: center;
  padding: 7px 14px;
  border-radius: 999px;
  background: rgba(148, 163, 184, 0.14);
  border: 1px solid rgba(148, 163, 184, 0.18);
  color: #bfdbfe;
  font-size: 12px;
  letter-spacing: 0.12em;
  font-weight: 700;
}

.hero__actions {
  display: flex;
  gap: 12px;
  margin-top: 30px;
}

.hero__right {
  display: grid;
  gap: 18px;
}

.hero__carousel-card,
.hero__aside {
  border-radius: 28px;
  overflow: hidden;
  border: 1px solid rgba(148, 163, 184, 0.16);
  background: linear-gradient(180deg, rgba(15, 23, 42, 0.82), rgba(15, 23, 42, 0.55));
  backdrop-filter: blur(16px);
}

.hero__carousel-item {
  position: relative;
  height: 300px;
  cursor: pointer;
  background: linear-gradient(135deg, rgba(29, 78, 216, 0.65), rgba(14, 165, 233, 0.32));

  img {
    width: 100%;
    height: 100%;
    object-fit: cover;
    display: block;
  }
}

.hero__carousel-overlay {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, rgba(15, 23, 42, 0.14), rgba(15, 23, 42, 0.74));
}

.hero__carousel-copy {
  position: absolute;
  left: 24px;
  right: 24px;
  bottom: 22px;
  z-index: 2;

  span {
    display: inline-flex;
    margin-bottom: 12px;
    padding: 5px 12px;
    border-radius: 999px;
    background: rgba(15, 23, 42, 0.48);
    font-size: 12px;
    color: #bfdbfe;
  }

  h3 {
    margin: 0;
    font-size: 24px;
    line-height: 1.4;
  }

  p {
    margin: 12px 0 0;
    color: rgba(226, 232, 240, 0.88);
    line-height: 1.7;
  }

  .el-button {
    margin-top: 14px;
  }
}

.hero__banner-empty {
  min-height: 300px;
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  padding: 28px;
  color: #dbeafe;
  text-align: center;

  strong {
    font-size: 22px;
    color: #fff;
  }

  p {
    margin-top: 14px;
    max-width: 360px;
    line-height: 1.9;
    color: rgba(226, 232, 240, 0.82);
  }
}

.hero__aside {
  padding: 22px;
}

.hero__aside-title {
  display: flex;
  justify-content: space-between;
  align-items: center;
  gap: 14px;
  color: #e2e8f0;

  span {
    font-size: 14px;
    font-weight: 700;
    letter-spacing: 0.08em;
  }

  a {
    color: #93c5fd;
    font-size: 13px;
  }
}

.hero__notice-list {
  display: grid;
  gap: 12px;
  margin-top: 18px;
}

.hero__notice-item {
  display: block;
  padding: 16px 0;
  border-bottom: 1px solid rgba(148, 163, 184, 0.12);
  color: #fff;

  strong {
    display: block;
    font-size: 16px;
    line-height: 1.6;
  }

  span {
    display: block;
    margin-top: 8px;
    color: rgba(191, 219, 254, 0.78);
    font-size: 13px;
  }
}

.hero__empty {
  margin-top: 22px;
  color: rgba(226, 232, 240, 0.72);
  line-height: 1.9;
}

.stats {
  display: grid;
  grid-template-columns: repeat(4, 1fr);
  gap: 1px;
  margin: 6px 32px 0;
  border-radius: 22px;
  overflow: hidden;
  background: rgba(148, 163, 184, 0.18);
}

.stats__item {
  padding: 24px;
  background: rgba(255, 255, 255, 0.95);

  strong {
    display: block;
    font-size: 34px;
    color: #0f172a;
  }

  span {
    display: block;
    margin-top: 10px;
    font-size: 14px;
    color: #475569;
  }
}

.section {
  margin: 24px 32px 0;
  padding: 36px 32px;
  border-radius: 28px;
}

.section--light {
  background: #fff;
}

.section--dark {
  background: linear-gradient(135deg, #0f172a, #172554);
  color: #fff;
}

.section__head {
  display: flex;
  flex-direction: column;
  gap: 10px;

  span {
    color: #2563eb;
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 0.08em;
  }

  h2 {
    margin: 0;
    font-size: 30px;
    line-height: 1.4;
    color: #0f172a;
  }
}

.section__head--light {
  span,
  h2 {
    color: #fff;
  }
}

.capability-grid {
  display: grid;
  grid-template-columns: repeat(4, minmax(0, 1fr));
  gap: 18px;
  margin-top: 26px;
}

.capability {
  padding: 24px;
  border-radius: 22px;
  background: #f8fafc;

  i {
    color: #2563eb;
    font-size: 28px;
  }

  h3 {
    margin: 16px 0 10px;
    color: #0f172a;
    font-size: 18px;
  }

  p {
    margin: 0;
    color: #475569;
    line-height: 1.8;
  }
}

.workflow__line {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 18px;
  margin-top: 26px;
}

.workflow__node {
  padding: 24px;
  border-radius: 24px;
  background: rgba(15, 23, 42, 0.35);
  border: 1px solid rgba(148, 163, 184, 0.18);

  em {
    display: inline-flex;
    margin-bottom: 16px;
    color: #93c5fd;
    font-style: normal;
    font-weight: 700;
  }

  strong {
    display: block;
    font-size: 20px;
  }

  p {
    margin: 14px 0 0;
    color: rgba(226, 232, 240, 0.85);
    line-height: 1.8;
  }
}

.announce-preview__list {
  display: grid;
  grid-template-columns: repeat(3, minmax(0, 1fr));
  gap: 18px;
  margin-top: 26px;
}

.announce-preview__item {
  display: block;
  padding: 24px;
  border-radius: 24px;
  background: #f8fafc;
  transition: transform .2s ease, box-shadow .2s ease;

  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 14px 36px rgba(15, 23, 42, 0.08);
  }

  h3 {
    margin: 16px 0 10px;
    color: #0f172a;
    font-size: 18px;
    line-height: 1.6;
  }

  p {
    margin: 0;
    color: #475569;
    line-height: 1.8;
  }
}

.announce-preview__meta {
  display: flex;
  justify-content: space-between;
  gap: 12px;
  font-size: 13px;

  span {
    color: #2563eb;
    font-weight: 700;
  }

  em {
    color: #64748b;
    font-style: normal;
  }
}

.announce-preview__empty {
  margin-top: 26px;
  padding: 30px;
  border-radius: 20px;
  background: #f8fafc;
  color: #475569;
  text-align: center;
}

.section--cta {
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 24px;
  background: linear-gradient(135deg, #1d4ed8, #2563eb);
  color: #fff;

  span {
    font-size: 13px;
    font-weight: 700;
    letter-spacing: 0.08em;
  }

  h2 {
    margin: 12px 0 0;
    max-width: 700px;
    font-size: 28px;
    line-height: 1.5;
  }
}

.section--cta__actions {
  display: flex;
  gap: 12px;
  flex-wrap: wrap;
}

.cta-link {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  min-width: 126px;
  padding: 12px 20px;
  border-radius: 999px;
  background: #fff;
  color: #1d4ed8;
  font-weight: 700;
}

.cta-link--ghost {
  background: rgba(255, 255, 255, 0.16);
  color: #fff;
}

::v-deep .hero__carousel-card .el-carousel__indicator button {
  background-color: rgba(255, 255, 255, 0.72);
}

@media (max-width: 1200px) {
  .hero,
  .capability-grid,
  .workflow__line,
  .announce-preview__list {
    grid-template-columns: 1fr;
  }

  .hero__content {
    padding-right: 0;
  }

  .section--cta {
    flex-direction: column;
    align-items: flex-start;
  }
}

@media (max-width: 768px) {
  .hero,
  .stats,
  .section {
    margin-left: 18px;
    margin-right: 18px;
  }

  .hero {
    padding-left: 0;
    padding-right: 0;
  }

  .hero__content h1 {
    font-size: 38px;
  }

  .stats {
    grid-template-columns: repeat(2, 1fr);
  }

  .section {
    padding: 28px 20px;
  }
}
</style>
