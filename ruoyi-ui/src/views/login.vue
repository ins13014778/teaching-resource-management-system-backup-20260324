<template>
  <div class="portal-login" :class="portalType">
    <div class="portal-login__mask"></div>
    <div class="portal-login__content">
      <section class="portal-login__intro">
        <div class="portal-login__badge">{{ portal.badge }}</div>
        <h1>{{ systemTitle }}</h1>
        <h2>{{ portal.heading }}</h2>
        <p>{{ portal.description }}</p>
        <div class="portal-login__feature-list">
          <div v-for="item in portal.features" :key="item" class="portal-login__feature">
            <i class="el-icon-check"></i>
            <span>{{ item }}</span>
          </div>
        </div>
      </section>

      <section class="portal-login__panel">
        <div class="portal-switch">
          <router-link
            v-for="item in portalTabs"
            :key="item.type"
            :to="item.path"
            class="portal-switch__item"
            :class="{ active: portalType === item.type }"
          >
            {{ item.label }}
          </router-link>
        </div>

        <el-form ref="loginForm" :model="loginForm" :rules="loginRules" class="login-form">
          <div class="login-form__header">
            <h3>{{ portal.formTitle }}</h3>
            <span>{{ portal.formDesc }}</span>
          </div>

          <el-form-item prop="username">
            <el-input
              v-model="loginForm.username"
              type="text"
              auto-complete="off"
              placeholder="请输入账号"
            >
              <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>

          <el-form-item prop="password">
            <el-input
              v-model="loginForm.password"
              type="password"
              auto-complete="off"
              placeholder="请输入密码"
              @keyup.enter.native="handleLogin"
            >
              <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
            </el-input>
          </el-form-item>

          <el-form-item prop="code" v-if="captchaEnabled">
            <el-input
              v-model="loginForm.code"
              auto-complete="off"
              placeholder="请输入验证码"
              style="width: 63%"
              @keyup.enter.native="handleLogin"
            >
              <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
            </el-input>
            <div class="login-code">
              <img :src="codeUrl" @click="getCode" class="login-code-img" />
            </div>
          </el-form-item>

          <div class="login-form__options">
            <el-checkbox v-model="loginForm.rememberMe">记住密码</el-checkbox>
            <span class="login-form__tip">{{ portal.tip }}</span>
          </div>

          <el-form-item style="width: 100%;">
            <el-button
              :loading="loading"
              size="medium"
              type="primary"
              class="login-submit"
              :style="{ background: buttonBackground }"
              @click.native.prevent="handleLogin"
            >
              <span v-if="!loading">{{ portal.buttonText }}</span>
              <span v-else>登录中...</span>
            </el-button>
          </el-form-item>

          <div class="login-form__footer">
            <router-link v-if="showRegisterEntry" :to="registerRoute" class="login-form__link">
              {{ registerLinkText }}
            </router-link>
            <span v-else class="login-form__subtip">{{ registerHint }}</span>
          </div>
        </el-form>
      </section>
    </div>

    <div class="portal-login__footer">{{ footerContent }}</div>
  </div>
</template>

<script>
import { getCodeImg } from '@/api/login'
import Cookies from 'js-cookie'
import { encrypt, decrypt } from '@/utils/jsencrypt'
import defaultSettings from '@/settings'

const PORTAL_MAP = {
  admin: {
    badge: '管理门户',
    heading: '教学资源统一管理',
    description: '面向平台主管、教务与审核人员，集中处理资源审核、课程配置、空间权限和教学运营数据。',
    features: ['教学菜单与权限配置', '课程资源审核发布', '空间策略统一管控'],
    formTitle: '管理员登录',
    formDesc: '使用管理员账号进入教学资源管理后台。',
    buttonText: '进入管理后台',
    tip: '仅限已分配后台权限的账号使用。'
  },
  teacher: {
    badge: '教师门户',
    heading: '教师教学资源工作台',
    description: '教师可上传课件、整理课程资料、共享教学文件，并按课程对学生进行资源授权。',
    features: ['课程资料上传共享', '学生授权与作业下发', '个人空间文件管理'],
    formTitle: '教师登录',
    formDesc: '使用教师账号进入课程资源中心。',
    buttonText: '进入教师工作台',
    tip: '教师账号由平台管理员统一分配。'
  },
  student: {
    badge: '学生门户',
    heading: '学生学习资源入口',
    description: '学生可查看课程资料、访问共享文件夹、下载学习资源，并使用个人学习空间管理文件。',
    features: ['课程资料查看下载', '共享文件夹访问', '学习空间内容管理'],
    formTitle: '学生登录',
    formDesc: '使用学生账号进入学习资源空间。',
    buttonText: '进入学生空间',
    tip: '支持学生自助注册与资料访问。'
  }
}

export default {
  name: 'Login',
  data() {
    return {
      systemTitle: process.env.VUE_APP_TITLE,
      footerContent: defaultSettings.footerContent,
      codeUrl: '',
      registerTeacherEnabled: false,
      registerStudentEnabled: false,
      loginForm: {
        username: '',
        password: '',
        rememberMe: false,
        code: '',
        uuid: ''
      },
      loginRules: {
        username: [{ required: true, trigger: 'blur', message: '请输入账号' }],
        password: [{ required: true, trigger: 'blur', message: '请输入密码' }],
        code: [{ required: true, trigger: 'change', message: '请输入验证码' }]
      },
      loading: false,
      captchaEnabled: true,
      redirect: undefined,
      portalTabs: [
        { type: 'admin', label: '管理端', path: '/login' },
        { type: 'teacher', label: '教师端', path: '/teacher-login' },
        { type: 'student', label: '学生端', path: '/student-login' }
      ]
    }
  },
  computed: {
    portalType() {
      if (this.$route.path === '/teacher-login') return 'teacher'
      if (this.$route.path === '/student-login') return 'student'
      return 'admin'
    },
    portal() {
      return PORTAL_MAP[this.portalType]
    },
    buttonBackground() {
      if (this.portalType === 'teacher') return 'linear-gradient(135deg, #2563eb, #38bdf8)'
      if (this.portalType === 'student') return 'linear-gradient(135deg, #f59e0b, #f97316)'
      return 'linear-gradient(135deg, #10b981, #34d399)'
    },
    showRegisterEntry() {
      return this.portalType === 'teacher' ? this.registerTeacherEnabled : this.portalType === 'student' ? this.registerStudentEnabled : false
    },
    registerRoute() {
      return this.portalType === 'teacher' ? '/teacher-register' : '/register'
    },
    registerLinkText() {
      return this.portalType === 'teacher' ? '教师注册' : '学生注册'
    },
    registerHint() {
      if (this.portalType === 'teacher') {
        return this.registerTeacherEnabled ? '首次使用可在线注册教师账号。' : '教师注册暂未开放，请联系管理员。'
      }
      if (this.portalType === 'student') {
        return this.registerStudentEnabled ? '首次使用可在线注册学生账号。' : '学生注册暂未开放，请联系管理员。'
      }
      return '教师和管理员账号由平台管理员统一分配。'
    }
  },
  watch: {
    $route: {
      handler(route) {
        this.redirect = route.query && route.query.redirect
        this.prefillDemoUser()
      },
      immediate: true
    }
  },
  created() {
    this.getCode()
    this.getCookie()
    this.prefillDemoUser()
  },
  methods: {
    prefillDemoUser() {
      if (this.portalType === 'admin') {
        this.loginForm.username = this.loginForm.username || 'admin'
      } else if (!Cookies.get('username')) {
        this.loginForm.username = ''
      }
    },
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled
        this.registerTeacherEnabled = res.registerTeacherEnabled === undefined ? false : res.registerTeacherEnabled
        this.registerStudentEnabled = res.registerStudentEnabled === undefined ? false : res.registerStudentEnabled
        if (this.captchaEnabled) {
          this.codeUrl = 'data:image/gif;base64,' + res.img
          this.loginForm.uuid = res.uuid
        }
      })
    },
    getCookie() {
      const username = Cookies.get('username')
      const password = Cookies.get('password')
      const rememberMe = Cookies.get('rememberMe')
      this.loginForm.username = username === undefined ? this.loginForm.username : username
      this.loginForm.password = password === undefined ? this.loginForm.password : decrypt(password)
      this.loginForm.rememberMe = rememberMe === undefined ? false : Boolean(rememberMe)
    },
    handleLogin() {
      this.$refs.loginForm.validate(valid => {
        if (!valid) return
        this.loading = true
        if (this.loginForm.rememberMe) {
          Cookies.set('username', this.loginForm.username, { expires: 30 })
          Cookies.set('password', encrypt(this.loginForm.password), { expires: 30 })
          Cookies.set('rememberMe', this.loginForm.rememberMe, { expires: 30 })
        } else {
          Cookies.remove('username')
          Cookies.remove('password')
          Cookies.remove('rememberMe')
        }
        this.$store.dispatch('Login', { ...this.loginForm, loginType: this.portalType }).then(() => {
          this.$router.push({ path: this.redirect || '/' }).catch(() => {})
        }).catch(() => {
          this.loading = false
          if (this.captchaEnabled) {
            this.getCode()
          }
        })
      })
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.portal-login {
  position: relative;
  min-height: 100vh;
  display: flex;
  align-items: center;
  justify-content: center;
  overflow: hidden;
  background:
    radial-gradient(circle at 20% 20%, rgba(16, 185, 129, 0.25), transparent 35%),
    radial-gradient(circle at 80% 15%, rgba(37, 99, 235, 0.18), transparent 30%),
    linear-gradient(135deg, #06131f 0%, #10243a 48%, #0f172a 100%);

  &.teacher {
    background:
      radial-gradient(circle at 20% 20%, rgba(37, 99, 235, 0.28), transparent 35%),
      radial-gradient(circle at 80% 15%, rgba(56, 189, 248, 0.18), transparent 30%),
      linear-gradient(135deg, #07111f 0%, #132b4e 55%, #0f172a 100%);
  }

  &.student {
    background:
      radial-gradient(circle at 20% 20%, rgba(245, 158, 11, 0.28), transparent 35%),
      radial-gradient(circle at 80% 15%, rgba(249, 115, 22, 0.18), transparent 30%),
      linear-gradient(135deg, #1c1204 0%, #35220c 55%, #111827 100%);
  }
}

.portal-login__mask {
  position: absolute;
  inset: 0;
  background: linear-gradient(180deg, rgba(255,255,255,0.03), rgba(255,255,255,0));
}

.portal-login__content {
  position: relative;
  z-index: 2;
  width: min(1180px, calc(100vw - 48px));
  min-height: 680px;
  display: grid;
  grid-template-columns: 1.15fr 0.85fr;
  border-radius: 28px;
  overflow: hidden;
  box-shadow: 0 30px 80px rgba(2, 6, 23, 0.45);
  background: rgba(255, 255, 255, 0.06);
  backdrop-filter: blur(12px);
}

.portal-login__intro {
  padding: 72px 68px;
  color: #fff;
  display: flex;
  flex-direction: column;
  justify-content: center;

  h1 {
    margin: 18px 0 12px;
    font-size: 18px;
    letter-spacing: 0.12em;
    font-weight: 600;
    color: rgba(255, 255, 255, 0.74);
  }

  h2 {
    margin: 0;
    font-size: 48px;
    line-height: 1.18;
    font-weight: 700;
  }

  p {
    max-width: 560px;
    margin: 20px 0 0;
    font-size: 16px;
    line-height: 1.9;
    color: rgba(255, 255, 255, 0.78);
  }
}

.portal-login__badge {
  display: inline-flex;
  align-items: center;
  justify-content: center;
  width: fit-content;
  padding: 8px 14px;
  border-radius: 999px;
  border: 1px solid rgba(255,255,255,0.2);
  background: rgba(255,255,255,0.08);
  font-size: 12px;
  letter-spacing: 0.08em;
  font-weight: 700;
}

.portal-login__feature-list {
  margin-top: 36px;
  display: grid;
  gap: 14px;
}

.portal-login__feature {
  display: flex;
  align-items: center;
  gap: 12px;
  font-size: 15px;
  color: rgba(255,255,255,0.88);

  i {
    width: 24px;
    height: 24px;
    display: inline-flex;
    align-items: center;
    justify-content: center;
    border-radius: 50%;
    background: rgba(255,255,255,0.12);
  }
}

.portal-login__panel {
  background: rgba(255, 255, 255, 0.94);
  padding: 36px 40px;
  display: flex;
  flex-direction: column;
  justify-content: center;
}

.portal-switch {
  display: grid;
  grid-template-columns: repeat(3, 1fr);
  gap: 10px;
  padding: 8px;
  border-radius: 16px;
  background: #eef2ff;
}

.portal-switch__item {
  text-align: center;
  padding: 12px 10px;
  border-radius: 12px;
  color: #475569;
  font-weight: 600;
  transition: all .2s ease;

  &.active {
    background: #fff;
    color: #111827;
    box-shadow: 0 8px 20px rgba(15, 23, 42, 0.08);
  }
}

.login-form {
  margin-top: 28px;
}

.login-form__header {
  margin-bottom: 24px;

  h3 {
    margin: 0;
    font-size: 28px;
    color: #111827;
  }

  span {
    display: block;
    margin-top: 10px;
    color: #64748b;
    line-height: 1.7;
  }
}

.login-form__options {
  display: flex;
  align-items: center;
  justify-content: space-between;
  margin-bottom: 20px;
  color: #64748b;
  gap: 12px;
}

.login-form__tip {
  font-size: 13px;
  text-align: right;
}

.login-submit {
  width: 100%;
  height: 46px;
  border-radius: 12px;
  border: none;
  font-size: 16px;
}

.login-form__footer {
  display: flex;
  justify-content: flex-end;
  margin-top: 4px;
}

.login-form__link,
.login-form__subtip {
  font-size: 13px;
}

.login-form__link {
  color: #2563eb;
  font-weight: 600;
}

.login-form__subtip {
  color: #64748b;
}

.login-code {
  width: 33%;
  height: 38px;
  float: right;

  img {
    cursor: pointer;
    vertical-align: middle;
  }
}

.login-code-img {
  height: 38px;
}

.portal-login__footer {
  position: absolute;
  left: 50%;
  bottom: 20px;
  transform: translateX(-50%);
  z-index: 2;
  color: rgba(255,255,255,0.68);
  font-size: 13px;
}

@media (max-width: 1024px) {
  .portal-login__content {
    grid-template-columns: 1fr;
    min-height: auto;
  }

  .portal-login__intro {
    padding: 42px 32px 28px;
  }

  .portal-login__panel {
    padding: 32px;
  }
}

@media (max-width: 768px) {
  .portal-login__content {
    width: min(100vw - 20px, 1180px);
  }

  .portal-login__intro h2 {
    font-size: 34px;
  }

  .portal-switch {
    grid-template-columns: 1fr;
  }

  .login-form__options,
  .login-form__footer {
    flex-direction: column;
    align-items: flex-start;
  }
}
</style>
