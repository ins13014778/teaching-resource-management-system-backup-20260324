<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="分类名称" prop="categoryName">
        <el-input v-model="queryParams.categoryName" placeholder="请输入分类名称" clearable @keyup.enter.native="handleQuery" />
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
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd()" v-hasPermi="['edu:category:add']">新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button type="info" plain icon="el-icon-sort" size="mini" @click="toggleExpandAll">展开/折叠</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table
      v-if="refreshTable"
      v-loading="loading"
      :data="categoryList"
      row-key="categoryId"
      :default-expand-all="isExpandAll"
      :tree-props="{ children: 'children', hasChildren: 'hasChildren' }"
    >
      <el-table-column prop="categoryName" label="分类名称" min-width="220" />
      <el-table-column prop="orderNum" label="排序" width="100" />
      <el-table-column label="状态" width="100">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.status === '0' ? 'success' : 'info'">{{ scope.row.status === '0' ? '启用' : '停用' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="创建时间" align="center" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="备注" prop="remark" :show-overflow-tooltip="true" />
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="220">
        <template slot-scope="scope">
          <el-button size="mini" type="text" icon="el-icon-plus" @click="handleAdd(scope.row)" v-hasPermi="['edu:category:add']">新增</el-button>
          <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)" v-hasPermi="['edu:category:edit']">修改</el-button>
          <el-button size="mini" type="text" icon="el-icon-delete" @click="handleDelete(scope.row)" v-hasPermi="['edu:category:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <el-dialog :title="title" :visible.sync="open" width="600px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="上级分类" prop="parentId">
          <treeselect v-model="form.parentId" :options="categoryOptions" :normalizer="normalizer" placeholder="请选择上级分类" />
        </el-form-item>
        <el-row>
          <el-col :span="12">
            <el-form-item label="分类名称" prop="categoryName">
              <el-input v-model="form.categoryName" placeholder="请输入分类名称" />
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="显示排序" prop="orderNum">
              <el-input-number v-model="form.orderNum" controls-position="right" :min="0" />
            </el-form-item>
          </el-col>
        </el-row>
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
import { listCategory, listCategoryExcludeChild, getCategory, addCategory, updateCategory, delCategory } from "@/api/edu/category"
import Treeselect from "@riophae/vue-treeselect"
import "@riophae/vue-treeselect/dist/vue-treeselect.css"

export default {
  name: "EduCategory",
  components: { Treeselect },
  data() {
    return {
      loading: false,
      showSearch: true,
      categoryList: [],
      categoryOptions: [],
      open: false,
      title: "",
      isExpandAll: true,
      refreshTable: true,
      queryParams: {
        categoryName: undefined,
        status: undefined
      },
      statusOptions: [
        { label: "启用", value: "0" },
        { label: "停用", value: "1" }
      ],
      form: {},
      rules: {
        parentId: [
          { required: true, message: "上级分类不能为空", trigger: "change" }
        ],
        categoryName: [
          { required: true, message: "分类名称不能为空", trigger: "blur" }
        ],
        orderNum: [
          { required: true, message: "显示排序不能为空", trigger: "blur" }
        ]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listCategory(this.queryParams).then(response => {
        this.categoryList = response.data || []
        this.loading = false
      })
    },
    normalizer(node) {
      if (node.children && !node.children.length) {
        delete node.children
      }
      return {
        id: node.categoryId,
        label: node.categoryName,
        children: node.children
      }
    },
    buildRootOption(data) {
      return [{
        categoryId: 0,
        categoryName: "顶级分类",
        children: data || []
      }]
    },
    reset() {
      this.form = {
        categoryId: undefined,
        parentId: 0,
        categoryName: undefined,
        orderNum: 0,
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
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleAdd(row) {
      this.reset()
      if (row) {
        this.form.parentId = row.categoryId
      }
      listCategory().then(response => {
        this.categoryOptions = this.buildRootOption(response.data)
        this.open = true
        this.title = "新增分类"
      })
    },
    handleUpdate(row) {
      this.reset()
      getCategory(row.categoryId).then(response => {
        this.form = response.data
        listCategoryExcludeChild(row.categoryId).then(res => {
          this.categoryOptions = this.buildRootOption(res.data)
          this.open = true
          this.title = "修改分类"
        })
      })
    },
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (!valid) return
        const request = this.form.categoryId ? updateCategory : addCategory
        request(this.form).then(() => {
          this.$modal.msgSuccess(this.form.categoryId ? "修改成功" : "新增成功")
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      this.$modal.confirm('是否确认删除分类“' + row.categoryName + '”？').then(() => {
        return delCategory(row.categoryId)
      }).then(() => {
        this.$modal.msgSuccess("删除成功")
        this.getList()
      }).catch(() => {})
    },
    toggleExpandAll() {
      this.refreshTable = false
      this.isExpandAll = !this.isExpandAll
      this.$nextTick(() => {
        this.refreshTable = true
      })
    }
  }
}
</script>
