<template>
  <div class="dashboard-home">
    <section class="hero">
      <div class="hero__content">
        <div class="hero__eyebrow">教学资源管理系统</div>
        <h1>{{ welcomeTitle }}</h1>
        <p>{{ welcomeDesc }}</p>
        <div class="hero__actions">
          <el-button type="primary" @click="goFirstQuickLink">进入常用模块</el-button>
          <el-button plain @click="$router.push('/user/profile')">查看个人中心</el-button>
        </div>
      </div>
      <div class="hero__panel">
        <div class="hero__card">
          <span>当前登录角色</span>
          <strong>{{ roleLabel }}</strong>
          <small>账号：{{ name }} ｜ 昵称：{{ nickName }}</small>
        </div>
        <div class="hero__card">
          <span>系统定位</span>
          <strong>资源、课程、空间、AI 一体化</strong>
          <small>面向教师、学生、审核员与管理员，统一管理课程资料、资源共享、审核流程、消息通知和学习互动。</small>
        </div>
      </div>
    </section>

    <section class="section">
      <div class="section__header">
        <h2>快捷入口</h2>
        <p>根据当前账号角色，展示最常用的业务模块，便于快速开展教学与学习工作。</p>
      </div>
      <div class="quick-grid">
        <div
          v-for="item in quickLinks"
          :key="item.title"
          class="quick-card"
          @click="$router.push(item.path)"
        >
          <div class="quick-card__icon">
            <i :class="item.icon"></i>
          </div>
          <div class="quick-card__body">
            <h3>{{ item.title }}</h3>
            <p>{{ item.desc }}</p>
          </div>
        </div>
      </div>
    </section>

    <section class="section two-columns">
      <div class="panel">
        <div class="section__header">
          <h2>账号与权限机制</h2>
          <p>平台采用“用户 → 角色 → 菜单/按钮权限”的标准授权模式，保障教师、学生、审核员各司其职。</p>
        </div>
        <ol class="steps">
          <li>管理员在“系统管理 / 用户管理”中创建账号，并维护基础资料。</li>
          <li>通过“分配角色”为账号绑定教师、学生、审核员等角色。</li>
          <li>不同入口登录后系统自动校验角色匹配，避免串权访问。</li>
          <li>菜单权限、按钮权限、数据范围由角色统一控制，账号只会看到自己有权使用的功能。</li>
        </ol>
      </div>

      <div class="panel">
        <div class="section__header">
          <h2>角色入口说明</h2>
          <p>系统已提供管理端、教师端、学生端三个入口，可按业务场景分别登录。</p>
        </div>
        <div class="portal-list">
          <div class="portal-list__item">
            <strong>管理端</strong>
            <span>/login</span>
            <p>负责平台用户、角色权限、课程资源、审核中心和系统设置。</p>
          </div>
          <div class="portal-list__item">
            <strong>教师端</strong>
            <span>/teacher-login</span>
            <p>上传教学资源、维护课程资料、发布课程公告、查看统计数据。</p>
          </div>
          <div class="portal-list__item">
            <strong>学生端</strong>
            <span>/student-login</span>
            <p>浏览资源、搜索课程、下载收藏、提交反馈并查看个人学习消息。</p>
          </div>
        </div>
      </div>
    </section>
  </div>
</template>

<script>
import { mapGetters } from 'vuex'

export default {
  name: 'HomeIndex',
  computed: {
    ...mapGetters(['roles', 'name', 'nickName']),
    roleLabel() {
      if (this.roles.includes('admin')) return '超级管理员'
      if (this.roles.includes('teacher')) return '教师'
      if (this.roles.includes('student')) return '学生'
      if (this.roles.includes('auditor')) return '审核员'
      return '平台用户'
    },
    welcomeTitle() {
      if (this.roles.includes('teacher')) return '欢迎进入教师工作台'
      if (this.roles.includes('student')) return '欢迎进入学生资源中心'
      if (this.roles.includes('auditor')) return '欢迎进入资源审核中心'
      return '欢迎进入教学资源管理系统'
    },
    welcomeDesc() {
      if (this.roles.includes('teacher')) {
        return '在这里上传教学资料、维护课程内容、发布课程公告，并跟踪自己资源的审核状态和下载数据。'
      }
      if (this.roles.includes('student')) {
        return '在这里按课程、分类与标签浏览学习资料，搜索资源、收藏下载，并查看老师发布的课程公告。'
      }
      if (this.roles.includes('auditor')) {
        return '在这里处理资源审核、评论审核与举报工单，保障平台内容质量和教学秩序。'
      }
      return '平台已覆盖资源管理、课程管理、空间分享、互动反馈、消息公告和 AI 托管能力，可继续按学校业务扩展。'
    },
    quickLinks() {
      if (this.roles.includes('teacher')) {
        return [
          { title: '我的课程', desc: '维护自己负责的课程信息与课程简介。', path: '/edu/course', icon: 'el-icon-s-management' },
          { title: '我的资源', desc: '管理自己上传的教学资源与审核状态。', path: '/edu/resource', icon: 'el-icon-document' },
          { title: '课程公告', desc: '发布课程公告并通知已授权学生。', path: '/edu/notice', icon: 'el-icon-bell' },
          { title: '数据统计', desc: '查看上传量、下载量、通过率与活跃度。', path: '/edu/stats', icon: 'el-icon-data-analysis' },
          { title: '消息中心', desc: '集中查看审核通知、授权通知与反馈消息。', path: '/edu/message', icon: 'el-icon-message' }
        ]
      }
      if (this.roles.includes('student')) {
        return [
          { title: '资源列表', desc: '查看已发布教学资源并进行预览、点赞、收藏。', path: '/edu/resource', icon: 'el-icon-reading' },
          { title: '资源搜索', desc: '按关键词、热度和类型快速查找资源。', path: '/edu/search', icon: 'el-icon-search' },
          { title: '我的收藏', desc: '查看自己收藏的重点资料和精品资源。', path: '/edu/favorite', icon: 'el-icon-star-off' },
          { title: '我的下载', desc: '查看已下载资源记录，回溯学习过程。', path: '/edu/download', icon: 'el-icon-download' },
          { title: '课程专区', desc: '按课程维度查看学习资料与课程公告。', path: '/edu/course', icon: 'el-icon-notebook-2' },
          { title: '留言反馈', desc: '提交使用反馈、建议或问题工单。', path: '/edu/feedback', icon: 'el-icon-chat-dot-round' }
        ]
      }
      if (this.roles.includes('auditor')) {
        return [
          { title: '资源审核', desc: '处理待审核资源，给出通过、驳回、下线意见。', path: '/edu/audit', icon: 'el-icon-view' },
          { title: '举报处理', desc: '跟踪资源/评论举报并形成处理结果。', path: '/edu/report', icon: 'el-icon-warning-outline' },
          { title: '评论管理', desc: '审核评论内容，维护互动区秩序。', path: '/edu/comment', icon: 'el-icon-chat-line-round' },
          { title: '消息中心', desc: '查看系统通知和任务提醒。', path: '/edu/message', icon: 'el-icon-message' }
        ]
      }
      return [
        { title: '资源管理', desc: '统一管理教学资源、推荐位、上传信息和版本。', path: '/edu/resource', icon: 'el-icon-document' },
        { title: '资源审核', desc: '进入审核中心处理资源状态和风控建议。', path: '/edu/audit', icon: 'el-icon-view' },
        { title: '课程管理', desc: '维护课程、章节、教师绑定和课程专区。', path: '/edu/course', icon: 'el-icon-s-management' },
        { title: '课程公告', desc: '统一维护课程公告并推送给目标学生。', path: '/edu/notice', icon: 'el-icon-bell' },
        { title: '统计分析', desc: '查看热门资源、教师排行、活跃用户和趋势数据。', path: '/edu/stats', icon: 'el-icon-data-analysis' },
        { title: '空间管理', desc: '控制空间配额、上传限制、分享策略和封禁联动。', path: '/edu/quota', icon: 'el-icon-folder-opened' }
      ]
    }
  },
  methods: {
    goFirstQuickLink() {
      if (this.quickLinks.length) {
        this.$router.push(this.quickLinks[0].path)
      }
    }
  }
}
</script>

<style lang="scss" scoped>
.dashboard-home {
  padding: 24px;
  background: #f5f7fb;
  min-height: calc(100vh - 84px);
}

.hero {
  display: grid;
  grid-template-columns: 1.2fr 0.8fr;
  gap: 24px;
  padding: 36px;
  border-radius: 24px;
  background: linear-gradient(135deg, #0f172a 0%, #1d4ed8 62%, #38bdf8 100%);
  color: #fff;
  box-shadow: 0 24px 50px rgba(29, 78, 216, 0.18);
}

.hero__eyebrow {
  display: inline-block;
  margin-bottom: 14px;
  padding: 6px 12px;
  border-radius: 999px;
  background: rgba(255,255,255,0.14);
  font-size: 12px;
  letter-spacing: .12em;
  font-weight: 700;
}

.hero__content h1 {
  margin: 0;
  font-size: 40px;
  line-height: 1.2;
}

.hero__content p {
  margin: 16px 0 0;
  max-width: 620px;
  line-height: 1.9;
  color: rgba(255,255,255,0.86);
}

.hero__actions {
  margin-top: 28px;
  display: flex;
  gap: 12px;
}

.hero__actions ::v-deep .el-button--primary {
  background: #fff;
  color: #0f172a;
  border-color: #fff;
}

.hero__panel {
  display: grid;
  gap: 18px;
}

.hero__card {
  padding: 24px;
  border-radius: 20px;
  background: rgba(255,255,255,0.12);
  backdrop-filter: blur(10px);

  span {
    display: block;
    font-size: 13px;
    color: rgba(255,255,255,0.76);
  }

  strong {
    display: block;
    margin: 10px 0 6px;
    font-size: 24px;
    font-weight: 700;
  }

  small {
    display: block;
    color: rgba(255,255,255,0.78);
    line-height: 1.8;
  }
}

.section {
  margin-top: 24px;
  padding: 28px;
  border-radius: 20px;
  background: #fff;
  box-shadow: 0 10px 30px rgba(15, 23, 42, 0.04);
}

.section__header h2 {
  margin: 0;
  font-size: 22px;
  color: #111827;
}

.section__header p {
  margin: 10px 0 0;
  color: #6b7280;
}

.quick-grid {
  margin-top: 22px;
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
  gap: 18px;
}

.quick-card {
  display: flex;
  gap: 16px;
  padding: 22px;
  border-radius: 18px;
  border: 1px solid #e5e7eb;
  transition: all 0.2s ease;
  cursor: pointer;

  &:hover {
    transform: translateY(-4px);
    box-shadow: 0 16px 30px rgba(37, 99, 235, 0.12);
    border-color: rgba(37, 99, 235, 0.2);
  }
}

.quick-card__icon {
  width: 52px;
  height: 52px;
  border-radius: 16px;
  background: linear-gradient(135deg, #eff6ff, #dbeafe);
  color: #2563eb;
  display: flex;
  align-items: center;
  justify-content: center;
  font-size: 24px;
}

.quick-card__body {
  h3 {
    margin: 2px 0 8px;
    font-size: 18px;
    color: #111827;
  }

  p {
    margin: 0;
    color: #6b7280;
    line-height: 1.7;
  }
}

.two-columns {
  display: grid;
  grid-template-columns: 1fr 1fr;
  gap: 24px;
}

.panel {
  padding: 4px;
}

.steps {
  margin: 18px 0 0;
  padding-left: 20px;
  color: #374151;
  line-height: 1.95;
}

.portal-list {
  margin-top: 18px;
  display: grid;
  gap: 14px;
}

.portal-list__item {
  padding: 18px 20px;
  border-radius: 16px;
  background: #f8fafc;
  border: 1px solid #e5e7eb;

  strong {
    display: block;
    font-size: 16px;
    color: #111827;
  }

  span {
    display: inline-block;
    margin-top: 8px;
    font-size: 13px;
    color: #2563eb;
  }

  p {
    margin: 10px 0 0;
    color: #6b7280;
    line-height: 1.75;
  }
}

@media (max-width: 992px) {
  .hero,
  .two-columns {
    grid-template-columns: 1fr;
  }

  .hero__content h1 {
    font-size: 32px;
  }
}

@media (max-width: 768px) {
  .dashboard-home {
    padding: 16px;
  }

  .hero,
  .section {
    padding: 20px;
  }

  .hero__actions {
    flex-direction: column;
  }
}
</style>
