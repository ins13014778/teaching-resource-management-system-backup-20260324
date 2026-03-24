<template>
  <div class="register">
    <el-form ref="registerForm" :model="registerForm" :rules="registerRules" class="register-form">
      <h3 class="title">{{ title }}</h3>
      <p class="subtitle">{{ subtitle }}</p>
      <el-form-item prop="username">
        <el-input v-model="registerForm.username" type="text" auto-complete="off" placeholder="账号">
          <svg-icon slot="prefix" icon-class="user" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="password">
        <el-input
          v-model="registerForm.password"
          type="password"
          auto-complete="off"
          placeholder="密码"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="confirmPassword">
        <el-input
          v-model="registerForm.confirmPassword"
          type="password"
          auto-complete="off"
          placeholder="确认密码"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="password" class="el-input__icon input-icon" />
        </el-input>
      </el-form-item>
      <el-form-item prop="code" v-if="captchaEnabled">
        <el-input
          v-model="registerForm.code"
          auto-complete="off"
          placeholder="验证码"
          style="width: 63%"
          @keyup.enter.native="handleRegister"
        >
          <svg-icon slot="prefix" icon-class="validCode" class="el-input__icon input-icon" />
        </el-input>
        <div class="register-code">
          <img :src="codeUrl" @click="getCode" class="register-code-img"/>
        </div>
      </el-form-item>
      <el-form-item style="width:100%;">
        <el-button
          :loading="loading"
          size="medium"
          type="primary"
          style="width:100%;"
          @click.native.prevent="handleRegister"
        >
          <span v-if="!loading">注 册</span>
          <span v-else>注 册 中...</span>
        </el-button>
        <div class="register-links">
          <router-link class="link-type" :to="loginRoute">返回{{ portalLabel }}登录</router-link>
        </div>
      </el-form-item>
    </el-form>
    <div class="el-register-footer">
      <span>{{ footerContent }}</span>
    </div>
  </div>
</template>

<script>
import { getCodeImg, register } from '@/api/login'
import defaultSettings from '@/settings'

export default {
  name: 'Register',
  data() {
    const equalToPassword = (rule, value, callback) => {
      if (this.registerForm.password !== value) {
        callback(new Error('两次输入的密码不一致'))
      } else {
        callback()
      }
    }
    return {
      footerContent: defaultSettings.footerContent,
      codeUrl: '',
      registerForm: {
        username: '',
        password: '',
        confirmPassword: '',
        code: '',
        uuid: '',
        loginType: 'student'
      },
      registerRules: {
        username: [
          { required: true, trigger: 'blur', message: '请输入您的账号' },
          { min: 2, max: 20, message: '用户账号长度必须介于 2 和 20 之间', trigger: 'blur' }
        ],
        password: [
          { required: true, trigger: 'blur', message: '请输入您的密码' },
          { min: 5, max: 20, message: '用户密码长度必须介于 5 和 20 之间', trigger: 'blur' },
          { pattern: /^[^<>"'|\\\\]+$/, message: '不能包含非法字符：< > " \' \\ |', trigger: 'blur' }
        ],
        confirmPassword: [
          { required: true, trigger: 'blur', message: '请再次输入您的密码' },
          { required: true, validator: equalToPassword, trigger: 'blur' }
        ],
        code: [{ required: true, trigger: 'change', message: '请输入验证码' }]
      },
      loading: false,
      captchaEnabled: true
    }
  },
  computed: {
    registerType() {
      return this.$route.path === '/teacher-register' ? 'teacher' : 'student'
    },
    portalLabel() {
      return this.registerType === 'teacher' ? '教师端' : '学生端'
    },
    loginRoute() {
      return this.registerType === 'teacher' ? '/teacher-login' : '/student-login'
    },
    title() {
      return `${process.env.VUE_APP_TITLE} - ${this.registerType === 'teacher' ? '教师注册' : '学生注册'}`
    },
    subtitle() {
      return this.registerType === 'teacher'
        ? '教师账号注册后可直接登录教师端，并使用课程资源上传、授权和空间管理功能。'
        : '学生账号注册后可直接登录学生端，并使用个人学习空间。'
    }
  },
  created() {
    this.registerForm.loginType = this.registerType
    this.getCode()
  },
  methods: {
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled
        const enabled = this.registerType === 'teacher' ? res.registerTeacherEnabled : res.registerStudentEnabled
        if (enabled === false) {
          this.$message.error(`当前系统暂未开放${this.portalLabel}注册，请联系管理员。`)
          this.$router.replace(this.loginRoute)
          return
        }
        if (this.captchaEnabled) {
          this.codeUrl = 'data:image/gif;base64,' + res.img
          this.registerForm.uuid = res.uuid
        }
      })
    },
    handleRegister() {
      this.$refs.registerForm.validate(valid => {
        if (valid) {
          this.loading = true
          this.registerForm.loginType = this.registerType
          register(this.registerForm).then(() => {
            const username = this.registerForm.username
            this.$alert(`<font color='red'>恭喜您，${this.portalLabel}账号 ${username} 注册成功，请使用${this.portalLabel}登录。</font>`, '系统提示', {
              dangerouslyUseHTMLString: true,
              type: 'success'
            }).then(() => {
              this.$router.push(this.loginRoute)
            }).catch(() => {})
          }).catch(() => {
            this.loading = false
            if (this.captchaEnabled) {
              this.getCode()
            }
          })
        }
      })
    }
  }
}
</script>

<style rel="stylesheet/scss" lang="scss" scoped>
.register {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100%;
  background-image: url('../assets/images/login-background.jpg');
  background-size: cover;
}

.title {
  margin: 0 auto 12px;
  text-align: center;
  color: #303133;
}

.subtitle {
  margin: 0 0 24px;
  text-align: center;
  color: #909399;
  line-height: 1.7;
}

.register-form {
  border-radius: 6px;
  background: #ffffff;
  width: 420px;
  padding: 25px 25px 5px 25px;

  .el-input {
    height: 38px;
    input {
      height: 38px;
    }
  }

  .input-icon {
    height: 39px;
    width: 14px;
    margin-left: 2px;
  }
}

.register-links {
  margin-top: 12px;
  text-align: right;
}

.register-code {
  width: 33%;
  height: 38px;
  float: right;

  img {
    cursor: pointer;
    vertical-align: middle;
  }
}

.el-register-footer {
  height: 40px;
  line-height: 40px;
  position: fixed;
  bottom: 0;
  width: 100%;
  text-align: center;
  color: #fff;
  font-family: Arial;
  font-size: 12px;
  letter-spacing: 1px;
}

.register-code-img {
  height: 38px;
}
</style>
