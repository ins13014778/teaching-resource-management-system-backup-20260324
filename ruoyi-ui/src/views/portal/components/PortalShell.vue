<template>
  <div class="portal-shell">
    <header class="portal-header">
      <router-link to="/" class="portal-brand">
        <span v-if="!config.logoUrl" class="portal-brand__mark">{{ brandMark }}</span>
        <img v-else class="portal-brand__logo" :src="resolveAssetUrl(config.logoUrl)" :alt="config.siteName">
        <div class="portal-brand__text">
          <strong>{{ config.siteName }}</strong>
          <span>{{ config.siteEnName }}</span>
        </div>
      </router-link>

      <nav class="portal-nav">
        <router-link to="/" class="portal-nav__link">{{ config.homeNavText }}</router-link>
        <router-link to="/announcements" class="portal-nav__link">{{ config.noticeNavText }}</router-link>
      </nav>
    </header>

    <main class="portal-main">
      <slot />
    </main>

    <footer class="portal-footer">
      <div>
        <strong>{{ config.footerName }}</strong>
        <p>{{ config.footerDesc }}</p>
        <em v-if="config.footerCopyright">{{ config.footerCopyright }}</em>
      </div>
      <div class="portal-footer__links">
        <router-link to="/">{{ config.homeNavText }}</router-link>
        <router-link to="/announcements">{{ config.noticeNavText }}</router-link>
      </div>
    </footer>
  </div>
</template>

<script>
import { isExternal } from '@/utils/validate'
import { getPortalHomeConfig } from '@/api/portal/site'

const createDefaultConfig = () => ({
  siteName: '教学资源管理系统',
  siteEnName: 'Teaching Resource Management System',
  logoUrl: '',
  homeNavText: '首页',
  noticeNavText: '公告中心',
  footerName: '教学资源管理系统',
  footerDesc: '统一发布学校通知、教学公告、资源动态与重要资讯。',
  footerCopyright: '© 2026 教学资源管理系统'
})

export default {
  name: 'PortalShell',
  data() {
    return {
      config: createDefaultConfig(),
      baseUrl: process.env.VUE_APP_BASE_API
    }
  },
  computed: {
    brandMark() {
      return (this.config.siteName || 'TRMS').slice(0, 2)
    }
  },
  created() {
    this.loadConfig()
  },
  methods: {
    loadConfig() {
      getPortalHomeConfig().then(res => {
        this.config = { ...createDefaultConfig(), ...(res.data || {}) }
      }).catch(() => {})
    },
    resolveAssetUrl(url) {
      if (!url) return ''
      if (isExternal(url) || url.indexOf(this.baseUrl) === 0) {
        return url
      }
      return this.baseUrl + url
    }
  }
}
</script>

<style lang="scss" scoped>
.portal-shell {
  min-height: 100vh;
  background:
    radial-gradient(circle at top left, rgba(56, 189, 248, 0.16), transparent 32%),
    radial-gradient(circle at top right, rgba(59, 130, 246, 0.14), transparent 26%),
    linear-gradient(180deg, #050b16 0%, #0b1325 46%, #f5f7fb 46%, #f5f7fb 100%);
}

.portal-header {
  position: sticky;
  top: 0;
  z-index: 20;
  display: flex;
  align-items: center;
  justify-content: space-between;
  gap: 20px;
  padding: 18px 32px;
  backdrop-filter: blur(16px);
  background: rgba(5, 11, 22, 0.68);
  border-bottom: 1px solid rgba(148, 163, 184, 0.16);
}

.portal-brand {
  display: flex;
  align-items: center;
  gap: 14px;
  color: #fff;

  &:hover {
    color: #fff;
  }
}

.portal-brand__mark,
.portal-brand__logo {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: 46px;
  height: 46px;
  border-radius: 14px;
}

.portal-brand__mark {
  background: linear-gradient(135deg, #2563eb, #38bdf8);
  font-size: 14px;
  font-weight: 800;
  letter-spacing: 0.08em;
}

.portal-brand__logo {
  object-fit: cover;
  background: #ffffff;
  padding: 4px;
}

.portal-brand__text {
  display: flex;
  flex-direction: column;

  strong {
    font-size: 16px;
    font-weight: 700;
  }

  span {
    margin-top: 3px;
    color: rgba(226, 232, 240, 0.7);
    font-size: 12px;
    letter-spacing: 0.04em;
  }
}

.portal-nav {
  display: flex;
  align-items: center;
  gap: 22px;
}

.portal-nav__link {
  color: rgba(226, 232, 240, 0.82);
  font-size: 14px;
  transition: color .2s ease;

  &:hover,
  &.router-link-exact-active {
    color: #fff;
  }
}

.portal-main {
  min-height: calc(100vh - 178px);
}

.portal-footer {
  display: flex;
  justify-content: space-between;
  gap: 24px;
  padding: 28px 32px 40px;
  background: #0b1325;
  color: #cbd5e1;

  strong {
    color: #fff;
    font-size: 16px;
  }

  p {
    margin: 8px 0 8px;
    max-width: 520px;
    line-height: 1.8;
  }

  em {
    display: inline-block;
    color: rgba(203, 213, 225, 0.72);
    font-style: normal;
  }
}

.portal-footer__links {
  display: flex;
  align-items: center;
  gap: 18px;
  flex-wrap: wrap;

  a {
    color: #cbd5e1;
  }
}

@media (max-width: 960px) {
  .portal-header,
  .portal-footer {
    padding-left: 18px;
    padding-right: 18px;
  }

  .portal-header {
    flex-wrap: wrap;
  }

  .portal-nav {
    order: 3;
    width: 100%;
    justify-content: space-between;
  }

  .portal-footer {
    flex-direction: column;
  }
}
</style>
