<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="标签名称" prop="tagName">
        <el-input v-model="queryParams.tagName" placeholder="请输入标签名称" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="标签类型" prop="tagType">
        <el-input v-model="queryParams.tagType" placeholder="请输入标签类型" clearable @keyup.enter.native="handleQuery" />
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
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['edu:tag:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single" @click="handleUpdate" v-hasPermi="['edu:tag:edit']">修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple" @click="handleDelete" v-hasPermi="['edu:tag:remove']">删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="tagList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="ID" prop="tagId" width="80" align="center" />
      <el-table-column label="标签名称" prop="tagName" align="center" />
      <el-table-column label="标签类型" prop="tagType" align="center" />
      <el-table-column label="颜色" align="center" width="120">
        <template slot-scope="scope">
          <el-tag :style="{ backgroundColor: scope.row.color, color: '#fff', borderColor: scope.row.color }">{{ scope.row.color }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="状态" align="center" width="100">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '启用' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="备注" prop="remark" align="center" :show-overflow-tooltip="true" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="160">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['edu:tag:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['edu:tag:remove']">删除</el-button>
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

    <el-dialog :title="title" :visible.sync="open" width="520px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="标签名称" prop="tagName">
          <el-input v-model="form.tagName" placeholder="请输入标签名称" />
        </el-form-item>
        <el-form-item label="标签类型" prop="tagType">
          <el-input v-model="form.tagType" placeholder="如 quality / phase / topic" />
        </el-form-item>
        <el-form-item label="标签颜色" prop="color">
          <el-color-picker v-model="form.color" />
          <span style="margin-left: 10px">{{ form.color }}</span>
        </el-form-item>
        <el-form-item label="状态">
          <el-radio-group v-model="form.status">
            <el-radio v-for="item in statusOptions" :key="item.value" :label="item.value">{{ item.label }}</el-radio>
          </el-radio-group>
        </el-form-item>
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
import { listTag, getTag, addTag, updateTag, delTag } from "@/api/edu/tag"

export default {
  name: "EduTag",
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      tagList: [],
      ids: [],
      single: true,
      multiple: true,
      open: false,
      title: "",
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        tagName: undefined,
        tagType: undefined,
        status: undefined
      },
      statusOptions: [
        { label: "启用", value: "0" },
        { label: "停用", value: "1" }
      ],
      form: {},
      rules: {
        tagName: [{ required: true, message: "标签名称不能为空", trigger: "blur" }],
        tagType: [{ required: true, message: "标签类型不能为空", trigger: "blur" }]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listTag(this.queryParams).then(response => {
        this.tagList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    reset() {
      this.form = {
        tagId: undefined,
        tagName: undefined,
        tagType: "general",
        color: "#409EFF",
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
      this.ids = selection.map(item => item.tagId)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    handleAdd() {
      this.reset()
      this.open = true
      this.title = "新增标签"
    },
    handleUpdate(row) {
      const tagId = row.tagId || this.ids[0]
      this.reset()
      getTag(tagId).then(response => {
        this.form = response.data
        this.open = true
        this.title = "修改标签"
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const request = this.form.tagId ? updateTag : addTag
        request(this.form).then(() => {
          this.$modal.msgSuccess(this.form.tagId ? "修改成功" : "新增成功")
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      const tagIds = row.tagId || this.ids.join(",")
      this.$modal.confirm('是否确认删除标签编号为“' + tagIds + '”的数据项？').then(() => {
        return delTag(tagIds)
      }).then(() => {
        this.$modal.msgSuccess("删除成功")
        this.getList()
      }).catch(() => {})
    }
  }
}
</script>
