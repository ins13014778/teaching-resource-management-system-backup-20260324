<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="所属课程">
        <el-input v-model="queryParams.courseName" placeholder="请输入课程名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="公告标题">
        <el-input v-model="queryParams.noticeTitle" placeholder="请输入公告标题" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态">
        <el-select v-model="queryParams.status" clearable placeholder="全部状态">
          <el-option label="启用" value="0" />
          <el-option label="停用" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['edu:notice:add']">新增公告</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="noticeList">
      <el-table-column label="公告ID" prop="noticeId" width="90" align="center" />
      <el-table-column label="所属课程" prop="courseName" min-width="140" show-overflow-tooltip />
      <el-table-column label="公告标题" prop="noticeTitle" min-width="220" show-overflow-tooltip />
      <el-table-column label="发布人" prop="publisherName" width="120" />
      <el-table-column label="状态" width="100" align="center">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '启用' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="发布时间" width="160">
        <template slot-scope="scope">{{ parseTime(scope.row.createTime) }}</template>
      </el-table-column>
      <el-table-column label="操作" width="240" align="center">
        <template slot-scope="scope">
          <el-button size="mini" type="text" @click="handleUpdate(scope.row)" v-hasPermi="['edu:notice:edit']">修改</el-button>
          <el-button size="mini" type="text" @click="handleView(scope.row)">查看</el-button>
          <el-button size="mini" type="text" @click="handleDelete(scope.row)" v-hasPermi="['edu:notice:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="720px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="所属课程" prop="courseId">
          <el-select v-model="form.courseId" placeholder="请选择课程" style="width: 100%" filterable>
            <el-option v-for="item in courseOptions" :key="item.courseId" :label="item.courseName" :value="item.courseId" />
          </el-select>
        </el-form-item>
        <el-form-item label="公告标题" prop="noticeTitle">
          <el-input v-model="form.noticeTitle" placeholder="请输入公告标题" />
        </el-form-item>
        <el-form-item label="公告内容" prop="noticeContent">
          <el-input v-model="form.noticeContent" type="textarea" :rows="6" placeholder="请输入公告内容" />
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio label="0">启用</el-radio>
            <el-radio label="1">停用</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="open = false">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="公告详情" :visible.sync="viewOpen" width="700px" append-to-body>
      <div v-if="viewData">
        <h3>{{ viewData.noticeTitle }}</h3>
        <p>课程：{{ viewData.courseName }} ｜ 发布人：{{ viewData.publisherName }} ｜ 发布时间：{{ parseTime(viewData.createTime) }}</p>
        <div class="notice-content">{{ viewData.noticeContent }}</div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listNotice, getNotice, addNotice, updateNotice, delNotice } from '@/api/edu/notice'
import { getResourceFormOptions } from '@/api/edu/resource'

export default {
  name: 'EduNotice',
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      noticeList: [],
      courseOptions: [],
      open: false,
      viewOpen: false,
      title: '',
      viewData: null,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        courseName: undefined,
        noticeTitle: undefined,
        status: undefined
      },
      form: {},
      rules: {
        courseId: [{ required: true, message: '所属课程不能为空', trigger: 'change' }],
        noticeTitle: [{ required: true, message: '公告标题不能为空', trigger: 'blur' }],
        noticeContent: [{ required: true, message: '公告内容不能为空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
    this.loadCourses()
  },
  methods: {
    getList() {
      this.loading = true
      listNotice(this.queryParams).then(res => {
        this.noticeList = res.rows || []
        this.total = res.total || 0
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    loadCourses() {
      getResourceFormOptions().then(res => {
        this.courseOptions = (res.data && res.data.courses) || []
      })
    },
    reset() {
      this.form = {
        noticeId: undefined,
        courseId: undefined,
        noticeTitle: '',
        noticeContent: '',
        status: '0',
        remark: ''
      }
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
    handleAdd() {
      this.reset()
      this.open = true
      this.title = '新增课程公告'
    },
    handleUpdate(row) {
      this.reset()
      getNotice(row.noticeId).then(res => {
        this.form = res.data || {}
        this.open = true
        this.title = '修改课程公告'
      })
    },
    handleView(row) {
      getNotice(row.noticeId).then(res => {
        this.viewData = res.data
        this.viewOpen = true
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        const request = this.form.noticeId ? updateNotice(this.form) : addNotice(this.form)
        request.then(() => {
          this.$modal.msgSuccess(this.form.noticeId ? '修改成功' : '新增成功')
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      this.$modal.confirm('是否确认删除该条课程公告？').then(() => delNotice(row.noticeId)).then(() => {
        this.$modal.msgSuccess('删除成功')
        this.getList()
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.notice-content {
  white-space: pre-wrap;
  line-height: 1.8;
  color: #303133;
}
</style>
