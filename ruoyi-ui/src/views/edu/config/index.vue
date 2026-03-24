<template>
  <div class="app-container">
    <el-card shadow="never">
      <div slot="header"><span>空间策略配置</span></div>
      <el-form ref="form" :model="form" :rules="rules" label-width="160px" v-loading="loading">
        <el-row :gutter="24">
          <el-col :span="12"><el-form-item label="全局上传限制(MB)" prop="globalUploadMb"><el-input-number v-model="form.globalUploadMb" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="视频上传限制(MB)" prop="videoUploadMb"><el-input-number v-model="form.videoUploadMb" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="24">
          <el-col :span="12"><el-form-item label="设计文件上传限制(MB)" prop="designUploadMb"><el-input-number v-model="form.designUploadMb" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="教师默认空间(GB)" prop="teacherDefaultStorageGb"><el-input-number v-model="form.teacherDefaultStorageGb" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="24">
          <el-col :span="12"><el-form-item label="教师默认上传限制(MB)" prop="teacherDefaultUploadMb"><el-input-number v-model="form.teacherDefaultUploadMb" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="学生默认空间(GB)" prop="studentDefaultStorageGb"><el-input-number v-model="form.studentDefaultStorageGb" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="24">
          <el-col :span="12"><el-form-item label="学生默认上传限制(MB)" prop="studentDefaultUploadMb"><el-input-number v-model="form.studentDefaultUploadMb" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="默认分享天数" prop="shareDefaultDays"><el-input-number v-model="form.shareDefaultDays" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="24">
          <el-col :span="12"><el-form-item label="最大分享天数" prop="shareMaxDays"><el-input-number v-model="form.shareMaxDays" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="回收站保留天数" prop="recycleKeepDays"><el-input-number v-model="form.recycleKeepDays" :min="1" controls-position="right" style="width:100%" /></el-form-item></el-col>
        </el-row>
        <el-row :gutter="24">
          <el-col :span="12"><el-form-item label="空间预警阈值(%)" prop="storageWarnPercent"><el-input-number v-model="form.storageWarnPercent" :min="1" :max="100" controls-position="right" style="width:100%" /></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="允许密码分享"><el-radio-group v-model="form.passwordShareEnable"><el-radio label="0">允许</el-radio><el-radio label="1">禁止</el-radio></el-radio-group></el-form-item></el-col>
        </el-row>
        <el-row :gutter="24">
          <el-col :span="12"><el-form-item label="教师分享开关"><el-radio-group v-model="form.teacherShareEnable"><el-radio label="0">开启</el-radio><el-radio label="1">关闭</el-radio></el-radio-group></el-form-item></el-col>
          <el-col :span="12"><el-form-item label="学生分享开关"><el-radio-group v-model="form.studentShareEnable"><el-radio label="0">开启</el-radio><el-radio label="1">关闭</el-radio></el-radio-group></el-form-item></el-col>
        </el-row>
        <el-form-item label="策略说明"><el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入策略说明" /></el-form-item>
        <el-form-item>
          <el-button type="primary" @click="submitForm" v-hasPermi="['edu:config:edit']">保存配置</el-button>
          <el-button @click="getInfo">重新加载</el-button>
        </el-form-item>
      </el-form>
    </el-card>
  </div>
</template>

<script>
import { getCurrentConfig, updateConfig } from '@/api/edu/config'

export default {
  name: 'EduConfig',
  data() {
    return {
      loading: false,
      form: {},
      rules: {
        globalUploadMb: [{ required: true, message: '请输入全局上传限制', trigger: 'blur' }],
        shareDefaultDays: [{ required: true, message: '请输入默认分享天数', trigger: 'blur' }],
        shareMaxDays: [{ required: true, message: '请输入最大分享天数', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getInfo()
  },
  methods: {
    getInfo() {
      this.loading = true
      getCurrentConfig().then(response => {
        this.form = response.data
        this.loading = false
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        updateConfig(this.form).then(() => {
          this.$modal.msgSuccess('保存成功')
          this.getInfo()
        })
      })
    }
  }
}
</script>
