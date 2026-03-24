<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="资源标题" prop="resourceTitle">
        <el-input v-model="queryParams.resourceTitle" placeholder="请输入资源标题" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="审核状态" prop="auditStatus">
        <el-select v-model="queryParams.auditStatus" placeholder="请选择审核状态" clearable>
          <el-option v-for="item in auditStatusOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="发布状态" prop="publishStatus">
        <el-select v-model="queryParams.publishStatus" placeholder="请选择发布状态" clearable>
          <el-option v-for="item in publishStatusOptions" :key="item.value" :label="item.label" :value="item.value" />
        </el-select>
      </el-form-item>
      <el-form-item label="上传人" prop="uploaderName">
        <el-input v-model="queryParams.uploaderName" placeholder="请输入上传人" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>

    <el-table v-loading="loading" :data="auditList">
      <el-table-column label="审核ID" prop="auditId" width="90" align="center" />
      <el-table-column label="资源标题" prop="resourceTitle" min-width="180" :show-overflow-tooltip="true" />
      <el-table-column label="资源类型" prop="resourceType" width="100" align="center" />
      <el-table-column label="分类" prop="categoryName" width="120" align="center" />
      <el-table-column label="课程" prop="courseName" width="140" align="center" />
      <el-table-column label="上传人" prop="uploaderName" width="100" align="center" />
      <el-table-column label="审核状态" width="100" align="center">
        <template slot-scope="scope">
          <el-tag size="mini" :type="statusType(scope.row.auditStatus, 'audit')">{{ statusLabel(scope.row.auditStatus, auditStatusOptions) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="发布状态" width="100" align="center">
        <template slot-scope="scope">
          <el-tag size="mini" :type="statusType(scope.row.publishStatus, 'publish')">{{ statusLabel(scope.row.publishStatus, publishStatusOptions) }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="审核意见" prop="auditReason" min-width="160" :show-overflow-tooltip="true" />
      <el-table-column label="审核人" prop="auditorName" width="100" align="center" />
      <el-table-column label="审核时间" width="160" align="center">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.auditTime) }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width" width="220">
        <template slot-scope="scope">
          <el-button
            v-if="scope.row.auditStatus === 'pending'"
            size="mini"
            type="text"
            icon="el-icon-circle-check"
            @click="handleAudit(scope.row, 'pass')"
            v-hasPermi="['edu:audit:pass']"
          >通过</el-button>
          <el-button
            v-if="scope.row.auditStatus === 'pending'"
            size="mini"
            type="text"
            icon="el-icon-circle-close"
            @click="handleAudit(scope.row, 'reject')"
            v-hasPermi="['edu:audit:reject']"
          >驳回</el-button>
          <el-button
            v-if="scope.row.publishStatus === 'published'"
            size="mini"
            type="text"
            icon="el-icon-remove-outline"
            @click="handleAudit(scope.row, 'offline')"
            v-hasPermi="['edu:audit:offline']"
          >下架</el-button>
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
  </div>
</template>

<script>
import { listAudit, passAudit, rejectAudit, offlineAudit } from "@/api/edu/audit"

export default {
  name: "EduAudit",
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      auditList: [],
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        resourceTitle: undefined,
        auditStatus: undefined,
        publishStatus: undefined,
        uploaderName: undefined
      },
      auditStatusOptions: [
        { label: "待审核", value: "pending" },
        { label: "已通过", value: "approved" },
        { label: "已驳回", value: "rejected" },
        { label: "已下架", value: "offline" }
      ],
      publishStatusOptions: [
        { label: "审核中", value: "review" },
        { label: "已发布", value: "published" },
        { label: "已驳回", value: "rejected" },
        { label: "已下架", value: "offline" }
      ]
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listAudit(this.queryParams).then(response => {
        this.auditList = response.rows
        this.total = response.total
        this.loading = false
      })
    },
    statusLabel(value, list) {
      const target = list.find(item => item.value === value)
      return target ? target.label : value
    },
    statusType(value, type) {
      if (type === "audit") {
        return { pending: "warning", approved: "success", rejected: "danger", offline: "info" }[value] || "info"
      }
      return { review: "warning", published: "success", rejected: "danger", offline: "info" }[value] || "info"
    },
    handleQuery() {
      this.queryParams.pageNum = 1
      this.getList()
    },
    resetQuery() {
      this.resetForm("queryForm")
      this.handleQuery()
    },
    handleAudit(row, action) {
      const titleMap = { pass: "审核通过", reject: "审核驳回", offline: "资源下架" }
      const defaultMap = { pass: "审核通过", reject: "审核驳回，请完善后重新提交", offline: "人工下架" }
      this.$prompt("请输入处理意见", titleMap[action], {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        inputValue: defaultMap[action],
        inputType: "textarea"
      }).then(({ value }) => {
        if (action === "pass") {
          return passAudit({ auditId: row.auditId, auditReason: value })
        }
        if (action === "reject") {
          return rejectAudit({ auditId: row.auditId, auditReason: value })
        }
        return offlineAudit({ resourceId: row.resourceId, auditReason: value })
      }).then(() => {
        this.$modal.msgSuccess(titleMap[action] + "成功")
        this.getList()
      }).catch(() => {})
    }
  }
}
</script>
