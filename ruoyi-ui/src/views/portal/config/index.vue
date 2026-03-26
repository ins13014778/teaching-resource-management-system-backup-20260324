<template>
  <div class="app-container">
    <el-card shadow="never">
      <div slot="header"><span>官网配置</span></div>
      <el-form ref="form" :model="form" :rules="rules" label-width="140px" v-loading="loading">
        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="站点中文名" prop="siteName">
              <el-input v-model="form.siteName" placeholder="请输入站点中文名" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="站点英文名" prop="siteEnName">
              <el-input v-model="form.siteEnName" placeholder="请输入站点英文名" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="站点 Logo">
          <ImageUpload v-model="form.logoUrl" :limit="1" />
        </el-form-item>

        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="首页导航名称">
              <el-input v-model="form.homeNavText" placeholder="如：首页" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="公告导航名称">
              <el-input v-model="form.noticeNavText" placeholder="如：公告中心" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="首页角标">
          <el-input v-model="form.heroBadge" placeholder="如：统一教学资源门户" />
        </el-form-item>

        <el-form-item label="首页主标题" prop="heroTitle">
          <el-input v-model="form.heroTitle" placeholder="请输入首页主标题" />
        </el-form-item>

        <el-form-item label="首页副标题" prop="heroSubtitle">
          <el-input v-model="form.heroSubtitle" type="textarea" :rows="4" placeholder="请输入首页副标题" />
        </el-form-item>

        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="主按钮文案">
              <el-input v-model="form.heroPrimaryText" placeholder="如：查看公告中心" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="主按钮链接">
              <el-input v-model="form.heroPrimaryLink" placeholder="如：/announcements" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="次按钮文案">
              <el-input v-model="form.heroSecondaryText" placeholder="如：了解平台能力" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="次按钮链接">
              <el-input v-model="form.heroSecondaryLink" placeholder="如：#capability" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="公告面板标题">
              <el-input v-model="form.noticePanelTitle" placeholder="如：最新公告" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="公告更多文案">
              <el-input v-model="form.noticePanelMoreText" placeholder="如：全部公告" />
            </el-form-item>
          </el-col>
        </el-row>

        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="页脚名称">
              <el-input v-model="form.footerName" placeholder="请输入页脚名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="官网状态">
              <el-radio-group v-model="form.status">
                <el-radio label="0">启用</el-radio>
                <el-radio label="1">停用</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>

        <el-form-item label="页脚简介">
          <el-input v-model="form.footerDesc" type="textarea" :rows="3" placeholder="请输入页脚简介" />
        </el-form-item>

        <el-form-item label="版权信息">
          <el-input v-model="form.footerCopyright" placeholder="请输入版权信息" />
        </el-form-item>

        <el-form-item label="备注">
          <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注" />
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="submitForm" v-hasPermi="['portal:config:edit']">保存配置</el-button>
          <el-button @click="getInfo">重新加载</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { getCurrentPortalConfig, updatePortalConfig } from '@/api/portal/config'

const createDefaultForm = () => ({
  configId: undefined,
  siteName: '教学资源管理系统',
  siteEnName: 'Teaching Resource Management System',
  logoUrl: '',
  homeNavText: '首页',
  noticeNavText: '公告中心',
  heroBadge: '统一教学资源门户',
  heroTitle: '面向学校与院系的教学资源官网',
  heroSubtitle: '统一展示公告、重要资讯与教学资源动态，让学校和访客可以在官网首页快速获取核心信息。',
  heroPrimaryText: '查看公告中心',
  heroPrimaryLink: '/announcements',
  heroSecondaryText: '了解官网能力',
  heroSecondaryLink: '#capability',
  noticePanelTitle: '最新公告',
  noticePanelMoreText: '全部公告',
  footerName: '教学资源管理系统',
  footerDesc: '统一发布学校通知、教学公告、资源动态与重要资讯。',
  footerCopyright: '© 2026 教学资源管理系统',
  status: '0',
  remark: ''
})

export default {
  name: 'PortalConfigAdmin',
  data() {
    return {
      loading: false,
      form: createDefaultForm(),
      rules: {
        siteName: [{ required: true, message: '请输入站点中文名', trigger: 'blur' }],
        heroTitle: [{ required: true, message: '请输入首页主标题', trigger: 'blur' }],
        heroSubtitle: [{ required: true, message: '请输入首页副标题', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getInfo()
  },
  methods: {
    getInfo() {
      this.loading = true
      getCurrentPortalConfig().then(response => {
        this.form = { ...createDefaultForm(), ...(response.data || {}) }
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        updatePortalConfig(this.form).then(() => {
          this.$modal.msgSuccess('保存成功')
          this.getInfo()
        })
      })
    }
  }
}
</script>
