<template>
  <div class="app-container">
    <el-row :gutter="20">
      <el-col>
        <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch"
          label-width="68px">
          <el-form-item label="岗位名称" prop="jobName">
            <el-input v-model="queryParams.jobName" placeholder="请输入岗位名称" clearable style="width: 240px"
              @keyup.enter.native="handleQuery" />
          </el-form-item>
          <el-form-item label="人员名称" prop="userName">
            <el-input v-model="queryParams.userName" placeholder="请输入人员名称" clearable style="width: 240px"
              @keyup.enter.native="handleQuery" />
          </el-form-item>

          <el-form-item>
            <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
            <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
          </el-form-item>
        </el-form>

        <el-row :gutter="10" class="mb8">
          <el-col :span="1.5">
            <el-button type="primary" plain icon="el-icon-plus" size="mini" @click="handleAdd">新增</el-button>
          </el-col>
          <el-col :span="1.5" v-show="false">
            <el-button type="success" plain icon="el-icon-edit" size="mini" :disabled="single"
              @click="handleUpdate">修改</el-button>
          </el-col>
          <el-col :span="1.5" v-show="false">
            <el-button type="danger" plain icon="el-icon-delete" size="mini" :disabled="multiple"
              @click="handleDelete">删除</el-button>
          </el-col>

          <right-toolbar :showSearch.sync="showSearch" @queryTable="getList" :columns="columns"></right-toolbar>
        </el-row>

        <el-table v-loading="loading" :data="interviewList" @selection-change="handleSelectionChange">
          <el-table-column type="selection" width="50" align="center" />
          <el-table-column label="岗位编号" align="center" key="jobId" prop="jobId" v-if="columns[0].visible" />
          <el-table-column label="岗位名称" align="center" key="jobName" prop="jobName" width="200"
            v-if="columns[1].visible" :show-overflow-tooltip="true" />
          <el-table-column label="岗位薪资" align="center" key="jobSalary" prop="jobSalary" v-if="columns[2].visible"
            :show-overflow-tooltip="true" />
          <el-table-column label="待招人员名称" align="center" key="userName" prop="userName" width="120"
            v-if="columns[3].visible" :show-overflow-tooltip="true" />
          <el-table-column label="学历" align="center" key="education" prop="education" v-if="columns[4].visible"
            width="120" />
          <el-table-column label="具体信息" align="center" width="160" class-name="small-padding fixed-width">
            <template slot-scope="scope" v-if="scope.row.jobId !== 1">
              <el-button size="mini" type="text" icon="el-icon-edit" @click="handleUpdate(scope.row)">修改</el-button>

            </template>
          </el-table-column>
          <el-table-column label="面试时间" align="center"  key="time"   prop="time" v-if="columns[6].visible" width="160">
            <template slot-scope="scope">
              <span>{{ parseTime(scope.row.time) }}</span>
            </template>
          </el-table-column>
          <el-table-column label="通过" align="center" key="interviewStatus" prop="interviewStatus" v-if="columns[5].visible">
            <template slot-scope="scope">
              <el-switch v-model="scope.row.interviewStatus" active-value="通过" inactive-value="不通过"
                @change="handleStatusChange(scope.row)"></el-switch>
            </template>
          </el-table-column>


        </el-table>

        <pagination v-show="total > 0" :total="total" :page.sync="queryParams.pageNum"
          :limit.sync="queryParams.pageSize" @pagination="getList" />
      </el-col>

    </el-row>

    <!-- 添加或修改用户配置对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="800px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-row>
          <el-col :span="12">
            <el-form-item label="公司" prop="etpId">
              <el-select v-model="form.etpId" placeholder="请选择公司">
                <el-option v-for="item in etpList" :key="item.id" :label="item.name" :value="item.id"></el-option>
              </el-select>
            </el-form-item>

          </el-col>
          <el-col :span="12">
            <el-form-item label="岗位名称" prop="jobId">
              <el-select v-model="form.jobId" placeholder="请选择岗位">
                <el-option v-for="item in jobList" :key="item.id" :label="item.name" :value="item.id"></el-option>
              </el-select>
            </el-form-item>

          </el-col>

        </el-row>
        <el-row>
          <el-col :span="12">
            <el-form-item label="面试人员名称" prop="userId">
              <el-select v-model="form.userId" placeholder="请选择人员">
                <el-option v-for="item in userList" :key="item.id" :label="item.username" :value="item.id"></el-option>
              </el-select>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="通过" prop="interviewStatus">
              <el-radio-group v-model="form.interviewStatus">
                <el-radio v-for="dict in ['通过', '不通过']" :key="dict" :label="dict">{{ dict }}</el-radio>
              </el-radio-group>
            </el-form-item>
          </el-col>

        </el-row>

        <el-row>
          <el-col :span="12">
            <el-form-item label="面试时间" prop="time">
              <el-date-picker v-model="form.time" type="date" placeholder="选择日期">
              </el-date-picker>
            </el-form-item>
          </el-col>
          <el-col :span="12">
            <el-form-item label="备注" prop="message">
              <el-input v-model="form.message" placeholder="请填写备注" type="textarea"
                :autosize="{ minRows: 2, maxRows: 4 }" />
            </el-form-item>
          </el-col>
        </el-row>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button type="primary" @click="submitForm">确 定</el-button>
        <el-button @click="cancel">取 消</el-button>
      </div>
    </el-dialog>


  </div>
</template>

<script>
import { listInterview, getInterview, delInterview, addInterview, updateInterview, changeInterviewStatus, joblist, etplist, userlist } from "@/api/enterprise/interview";
import { getToken } from "@/utils/auth";


export default {
  name: "interview",
  data() {
    return {
      interviewList: [],
      userList: [],
      jobList: [],
      etpList: [],
      // 遮罩层
      loading: false,
      // 选中数组
      ids: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 用户表格数据
      userList: null,
      // 弹出层标题
      title: "",
      // 所有部门树选项
      deptOptions: undefined,
      // 过滤掉已禁用部门树选项
      enabledDeptOptions: undefined,
      // 是否显示弹出层
      open: false,
      // 部门名称
      deptName: undefined,
      // 默认密码
      initPassword: undefined,
      // 日期范围
      dateRange: [],
      // 岗位选项
      postOptions: [],
      // 角色选项
      roleOptions: [],
      // 表单参数
      form: {},
      defaultProps: {
        children: "children",
        label: "label"
      },

      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userName: undefined,
        jobName: undefined,

      },
      // 列信息
      columns: [
        { key: 0, label: `岗位编号`, visible: true },
        { key: 1, label: `岗位名称`, visible: true },
        { key: 2, label: `岗位薪资`, visible: true },
        { key: 3, label: `待招人员名称`, visible: true },
        { key: 4, label: `学历`, visible: true },
        { key: 5, label: `具体信息`, visible: true },
        { key: 6, label: `面试时间`, visible: true },
        { key: 7, label: `通过`, visible: true }
      ],
      // 表单校验
      rules: {
        userId: [
          { required: true, message: "岗位名称不能为空", trigger: "blur" }
        ],
        etpId: [
          { required: true, message: "岗位名称不能为空", trigger: "blur" }
        ],
        jobId: [
          { required: true, message: "岗位名称不能为空", trigger: "blur" }
        ],
        time: [
          { required: true, message: "岗位名称不能为空", trigger: "blur" }
        ]

      }
    };
  },
  watch: {

  },
  created() {
    let that = this
    joblist().then(res => {
      that.jobList = res.rows
    })
    etplist().then(res => {
      that.etpList = res.rows
    })
    userlist().then(res => {
      that.userList = res.rows
    })
    this.getList();
  },
  methods: {
    /** 查询用户列表 */
    getList() {
      this.loading = true;
      listInterview(this.addDateRange(this.queryParams, this.dateRange)).then(response => {
        this.interviewList = response.rows;
        this.total = response.total;
        this.loading = false;
      }
      );
    },

    // 面试状态修改
    handleStatusChange(row) {
      this.$modal.confirm('确认要"' + row.interviewStatus + '""' + row.userName + '"面试吗？').then(function () {
        return updateInterview(row);
      }).then(() => {
        this.$modal.msgSuccess(row.interviewStatus + "成功");
      }).catch(function () {
        row.interviewStatus = row.interviewStatus ==="通过" ? "不通过" : "通过";
      });
    },
    // 取消按钮
    cancel() {
      this.open = false;
      this.reset();
    },
    // 表单重置
    reset() {
      this.form = {
        jobId: undefined,
        userId: undefined,
        etpId: undefined,
        message: '',
        interviewStatus: "通过",

      };
      this.resetForm("form");
    },
    /** 搜索按钮操作 */
    handleQuery() {
      this.queryParams.pageNum = 1;
      this.getList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.dateRange = [];
      this.resetForm("queryForm");
      this.queryParams.deptId = undefined;
      this.$refs.tree.setCurrentKey(null);
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.userId);
      this.single = selection.length != 1;
      this.multiple = !selection.length;
    },
    // 更多操作触发
    handleCommand(command, row) {
      switch (command) {
        case "handleResetPwd":
          this.handleResetPwd(row);
          break;
        case "handleAuthRole":
          this.handleAuthRole(row);
          break;
        default:
          break;
      }
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加面试";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const userId = row.userId || this.ids;
      getInterview(userId).then(response => {
        this.form = response.data;
        this.postOptions = response.posts;
        this.roleOptions = response.roles;
        this.$set(this.form, "postIds", response.postIds);
        this.$set(this.form, "roleIds", response.roleIds);
        this.open = true;
        this.title = "修改面试";
        this.form.password = "";
      });
    },

    /** 提交按钮 */
    submitForm: function () {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != undefined) {
            updateInterview(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addInterview(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const userIds = row.userId || this.ids;
      this.$modal.confirm('是否确认删除面试编号为"' + userIds + '"的数据项？').then(function () {
        return delInterview(userIds);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => { });
    },

  }
};
</script>