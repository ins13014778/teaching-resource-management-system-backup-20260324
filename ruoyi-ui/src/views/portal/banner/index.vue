<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="轮播标题" prop="bannerTitle">
        <el-input v-model="queryParams.bannerTitle" placeholder="请输入轮播标题" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.label" :value="dict.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['portal:banner:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['portal:banner:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['portal:banner:remove']">删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="bannerList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="编号" align="center" prop="bannerId" width="80" />
      <el-table-column label="轮播标题" align="center" prop="bannerTitle" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="轮播副标题" align="center" prop="bannerSubtitle" min-width="220" :show-overflow-tooltip="true" />
      <el-table-column label="图片" align="center" width="120">
        <template slot-scope="scope">
          <img v-if="scope.row.imageUrl" :src="previewUrl(scope.row.imageUrl)" class="banner-thumb" />
          <span v-else>未上传</span>
        </template>
      </el-table-column>
      <el-table-column label="跳转链接" align="center" prop="targetUrl" min-width="200" :show-overflow-tooltip="true" />
      <el-table-column label="排序" align="center" prop="sortNum" width="80" />
      <el-table-column label="状态" align="center" prop="status" width="90">
        <template slot-scope="scope">
          <dict-tag :options="dict.type.sys_normal_disable" :value="scope.row.status" />
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" prop="createTime" width="160">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="160">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['portal:banner:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['portal:banner:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="780px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="100px">
        <el-form-item label="轮播标题" prop="bannerTitle">
          <el-input v-model="form.bannerTitle" placeholder="请输入轮播标题" />
        </el-form-item>
        <el-form-item label="轮播副标题">
          <el-input v-model="form.bannerSubtitle" type="textarea" :rows="3" placeholder="请输入轮播副标题" />
        </el-form-item>
        <el-form-item label="轮播图片" prop="imageUrl">
          <ImageUpload v-model="form.imageUrl" :limit="1" />
        </el-form-item>
        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="按钮文案">
              <el-input v-model="form.buttonText" placeholder="如：立即查看" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="跳转链接">
              <el-input v-model="form.targetUrl" placeholder="如：https://example.com 或 /announcements" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row :gutter="24">
          <el-col :span="12">
            <el-form-item label="排序" prop="sortNum">
              <el-input-number v-model="form.sortNum" :min="0" controls-position="right" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="状态">
              <el-radio-group v-model="form.status">
                <el-radio v-for="dict in dict.type.sys_normal_disable" :key="dict.value" :label="dict.value">{{ dict.label }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="备注">
          <el-input v-model="form.remark" type="textarea" :rows="3" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { isExternal } from '@/utils/validate'
import { listPortalBanner, getPortalBanner, addPortalBanner, updatePortalBanner, delPortalBanner } from '@/api/portal/banner'

const createDefaultForm = () => ({
  bannerId: undefined,
  bannerTitle: '',
  bannerSubtitle: '',
  imageUrl: '',
  targetUrl: '',
  buttonText: '立即查看',
  sortNum: 10,
  status: '0',
  remark: ''
})

export default {
  name: 'PortalBannerAdmin',
  dicts: ['sys_normal_disable'],
  data() {
    return {
      loading: true,
      ids: [],
      single: true,
      multiple: true,
      showSearch: true,
      total: 0,
      title: '',
      open: false,
      bannerList: [],
      baseUrl: process.env.VUE_APP_BASE_API,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        bannerTitle: undefined,
        status: undefined
      },
      form: createDefaultForm(),
      rules: {
        bannerTitle: [{ required: true, message: '请输入轮播标题', trigger: 'blur' }],
        imageUrl: [{ required: true, message: '请上传轮播图片', trigger: 'change' }],
        sortNum: [{ required: true, message: '请输入排序号', trigger: 'change' }]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listPortalBanner(this.queryParams).then(response => {
        this.bannerList = response.rows
        this.total = response.total
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    previewUrl(url) {
      if (!url) return ''
      if (isExternal(url) || url.indexOf(this.baseUrl) === 0) {
        return url
      }
      return this.baseUrl + url
    },
    cancel() {
      this.open = false
      this.reset()
    },
    reset() {
      this.form = createDefaultForm()
      this.resetForm('form')
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm('queryForm')
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.bannerId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = '新增轮播图'
    },
    handleUpdate(row) {
      this.reset()
      const bannerId = row.bannerId || this.ids[0]
      getPortalBanner(bannerId).then(response => {
        this.form = { ...createDefaultForm(), ...(response.data || {}) }
        this.open = true
        this.title = '修改轮播图'
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        const request = this.form.bannerId ? updatePortalBanner : addPortalBanner
        request(this.form).then(() => {
          this.$modal.msgSuccess(this.form.bannerId ? '修改成功' : '新增成功')
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      const bannerIds = row.bannerId || this.ids
      this.$modal.confirm('是否确认删除轮播图编号为“' + bannerIds + '”的数据项？').then(() => {
        return delPortalBanner(bannerIds)
      }).then(() => {
        this.getList()
        this.$modal.msgSuccess('删除成功')
      }).catch(() => {})
    }
  }
}
</script>

<style lang="scss" scoped>
.banner-thumb {
  width: 68px;
  height: 44px;
  object-fit: cover;
  border-radius: 6px;
  box-shadow: 0 4px 12px rgba(15, 23, 42, 0.12);
}
</style>
