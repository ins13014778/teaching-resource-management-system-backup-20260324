<template>
  <div class="app-container">
    <el-form ref="queryForm" :model="queryParams" size="small" :inline="true" v-show="showSearch">
      <el-form-item label="消息标题">
        <el-input v-model="queryParams.messageTitle" placeholder="请输入消息标题" clearable @keyup.enter.native="handleQuery" />
      </el-form-item>
      <el-form-item label="消息类型">
        <el-input v-model="queryParams.messageType" placeholder="如 system / audit / report" clearable />
      </el-form-item>
      <el-form-item label="已读状态">
        <el-select v-model="queryParams.readStatus" clearable placeholder="全部状态">
          <el-option label="未读" value="0" />
          <el-option label="已读" value="1" />
        </el-select>
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd" v-hasPermi="['edu:message:add']">新增消息</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" />
    </el-row>

    <el-table v-loading="loading" :data="messageList">
      <el-table-column label="消息ID" prop="messageId" width="90" align="center" />
      <el-table-column label="接收人" prop="userName" width="120" />
      <el-table-column label="消息标题" prop="messageTitle" min-width="180" show-overflow-tooltip />
      <el-table-column label="消息类型" prop="messageType" width="120" />
      <el-table-column label="已读状态" width="90" align="center">
        <template slot-scope="scope">
          <el-tag size="mini" :type="scope.row.readStatus === '1' ? 'success' : 'warning'">{{ scope.row.readStatus === '1' ? '已读' : '未读' }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column label="发送时间" width="160">
        <template slot-scope="scope">{{ parseTime(scope.row.createTime) }}</template>
      </el-table-column>
      <el-table-column label="操作" width="220" align="center">
        <template slot-scope="scope">
          <el-button size="mini" type="text" @click="handleView(scope.row)">查看</el-button>
          <el-button size="mini" type="text" @click="handleRead(scope.row)" v-if="scope.row.readStatus === '0'">标记已读</el-button>
          <el-button size="mini" type="text" @click="handleDelete(scope.row)" v-hasPermi="['edu:message:remove']">删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum" :limit.sync="queryParams.pageSize" @pagination="getList" />

    <el-dialog :title="title" :visible.sync="open" width="620px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="90px">
        <el-form-item label="用户ID" prop="userId">
          <el-input-number v-model="form.userId" :min="1" style="width:100%" />
        </el-form-item>
        <el-form-item label="接收人" prop="userName">
          <el-input v-model="form.userName" placeholder="请输入接收人名称" />
        </el-form-item>
        <el-form-item label="消息标题" prop="messageTitle">
          <el-input v-model="form.messageTitle" placeholder="请输入消息标题" />
        </el-form-item>
        <el-form-item label="消息内容" prop="messageContent">
          <el-input v-model="form.messageContent" type="textarea" :rows="5" placeholder="请输入消息内容" />
        </el-form-item>
        <el-form-item label="消息类型">
          <el-input v-model="form.messageType" placeholder="默认 system" />
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="open = false">取 消</el-button>
      </div>
    </el-dialog>

    <el-dialog title="消息详情" :visible.sync="viewOpen" width="660px" append-to-body>
      <div v-if="viewData">
        <h3>{{ viewData.messageTitle }}</h3>
        <p>接收人：{{ viewData.userName }} ｜ 类型：{{ viewData.messageType }} ｜ 时间：{{ parseTime(viewData.createTime) }}</p>
        <div class="msg-content">{{ viewData.messageContent }}</div>
      </div>
    </el-dialog>
  </div>
</template>

<script>
import { listMessage, getMessage, addMessage, readMessage, delMessage } from '@/api/edu/message'

export default {
  name: 'EduMessage',
  data() {
    return {
      loading: false,
      showSearch: true,
      total: 0,
      messageList: [],
      open: false,
      viewOpen: false,
      title: '',
      viewData: null,
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        messageTitle: undefined,
        messageType: undefined,
        readStatus: undefined
      },
      form: {},
      rules: {
        userId: [{ required: true, message: '用户ID不能为空', trigger: 'blur' }],
        userName: [{ required: true, message: '接收人不能为空', trigger: 'blur' }],
        messageTitle: [{ required: true, message: '消息标题不能为空', trigger: 'blur' }],
        messageContent: [{ required: true, message: '消息内容不能为空', trigger: 'blur' }]
      }
    }
  },
  created() {
    this.getList()
  },
  methods: {
    getList() {
      this.loading = true
      listMessage(this.queryParams).then(res => {
        this.messageList = res.rows || []
        this.total = res.total || 0
        this.loading = false
      }).catch(() => {
        this.loading = false
      })
    },
    reset() {
      this.form = {
        userId: 1,
        userName: '',
        messageTitle: '',
        messageContent: '',
        messageType: 'system'
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
      this.title = '新增消息'
    },
    handleView(row) {
      getMessage(row.messageId).then(res => {
        this.viewData = res.data
        this.viewOpen = true
      })
    },
    handleRead(row) {
      readMessage(row.messageId).then(() => {
        this.$modal.msgSuccess('已标记为已读')
        this.getList()
      })
    },
    submitForm() {
      this.$refs.form.validate(valid => {
        if (!valid) return
        addMessage(this.form).then(() => {
          this.$modal.msgSuccess('新增成功')
          this.open = false
          this.getList()
        })
      })
    },
    handleDelete(row) {
      this.$modal.confirm('是否确认删除该条消息？').then(() => delMessage(row.messageId)).then(() => {
        this.$modal.msgSuccess('删除成功')
        this.getList()
      }).catch(() => {})
    }
  }
}
</script>

<style scoped>
.msg-content {
  white-space: pre-wrap;
  line-height: 1.8;
  color: #303133;
}
</style>
