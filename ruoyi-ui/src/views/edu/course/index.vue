<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="课程名称" prop="courseName">
        <el-input v-model="queryParams.courseName" placeholder="请输入课程名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="课程编号" prop="courseCode">
        <el-input v-model="queryParams.courseCode" placeholder="请输入课程编号" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="教师姓名" prop="teacherName">
        <el-input v-model="queryParams.teacherName" placeholder="请输入教师姓名" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="状态" prop="status">
        <el-select v-model="queryParams.status" placeholder="请选择状态" clearable>
          <el-option v-for="item in statusOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['edu:course:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['edu:course:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['edu:course:remove']">删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="courseList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="课程ID" prop="courseId" width="90" align="center" />
      <el-table-column label="课程名称" prop="courseName" min-width="180" />
      <el-table-column label="课程编号" prop="courseCode" width="120" align="center" />
      <el-table-column label="教师ID" prop="teacherUserId" width="100" align="center" />
      <el-table-column label="教师姓名" prop="teacherName" width="120" align="center" />
      <el-table-column label="状态" width="100" align="center">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '启用' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="课程简介" prop="courseIntro" :show-overflow-tooltip="true" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="160">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['edu:course:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['edu:course:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total > 0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="课程名称" prop="courseName">
              <el-input v-model="form.courseName" placeholder="请输入课程名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="课程编号" prop="courseCode">
              <el-input v-model="form.courseCode" placeholder="请输入课程编号" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="教师ID" prop="teacherUserId">
              <el-input-number v-model="form.teacherUserId" controls-position="right" :min="1" style="width: 100%" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="教师姓名" prop="teacherName">
              <el-input v-model="form.teacherName" placeholder="请输入教师姓名" />
            </el-form-item>
          </el-col>
        </el-row>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio v-for="item in statusOptions" :key="item.value" :label="item.value">{{ item.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
        <el-form-item label="课程简介">
          <el-input v-model="form.courseIntro" type="textarea" :rows="4" placeholder="请输入课程简介" />
        </el-form-item>
        <el-form-item label="备注">
          <el-input v-model="form.remark" type="textarea" :rows="2" placeholder="请输入备注" />
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
import { listCourse, getCourse, addCourse, updateCourse, delCourse } from "@/api/edu/course"

export default {
  name: "EduCourse",
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      courseList: [],
      ids: [],
      single: true,
      multiple: true,
      open: false,
      title: "",
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        courseName: undefined,
        courseCode: undefined,
        teacherName: undefined,
        status: undefined
      },
      statusOptions: [
        { label: "启用", value: "0" },
        { label: "停用", value: "1" }
      ],
      form: {},
      rules: {
        courseName: [{ required: true, message: "课程名称不能为空", trigger: "blur" }]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listCourse(this.queryParams).then(response => {
        this.courseList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    reset() {
      this.form = {
        courseId: undefined,
        courseName: undefined,
        courseCode: undefined,
        teacherUserId: 1,
        teacherName: undefined,
        courseIntro: undefined,
        status: "0",
        remark: undefined
      }
      this.resetForm("form")
    },
    cancel() {
      this.open = false
      this.reset()
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.courseId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "新增课程"
    },
    handleUpdate(row) {
      const courseId = row.courseId || this.ids[0]
      this.reset()
      getCourse(courseId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改课程"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const request = this.form.courseId ? updateCourse : addCourse
        request(this.form).then(() => {
          this.$modal.msgSuccess(this.form.courseId ? "修改成功" : "新增成功")
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      const courseIds = row.courseId || this.ids.join(",")
      this.$modal.confirm('是否确认删除课程编号为“' + courseIds + '”的数据项？').then(() => {
        return delCourse(courseIds)
      }).then(() => {
        this.$modal.msgSuccess("删除成功")
        this.getList()
      }).catch(() => {})
    }
  }
}
</script>
