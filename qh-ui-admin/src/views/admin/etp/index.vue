<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="企业名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入企业名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="法人" prop="legalPerson">
        <el-input
          v-model="queryParams.legalPerson"
          placeholder="请输入法人"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="电话" prop="phone">
        <el-input
          v-model="queryParams.phone"
          placeholder="请输入电话"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="官网" prop="website">
        <el-input
          v-model="queryParams.website"
          placeholder="请输入官网"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="企业热度" prop="popularity">
        <el-input
          v-model="queryParams.popularity"
          placeholder="请输入企业热度"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item>
        <el-button type="primary" icon="el-icon-search" size="mini" @click="handleQuery">搜索</el-button>
        <el-button icon="el-icon-refresh" size="mini" @click="resetQuery">重置</el-button>
      </el-form-item>
    </el-form>

    <el-row :gutter="10" class="mb8">
      <el-col :span="1.5">
        <el-button
          type="primary"
          plain
          icon="el-icon-plus"
          size="mini"
          @click="handleAdd"
          v-hasPermi="['admin:etp:add']"
        >新增
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
          v-hasPermi="['admin:etp:edit']"
        >修改
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
          v-hasPermi="['admin:etp:remove']"
        >删除
        </el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['admin:etp:export']"
        >导出
        </el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="etpList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center"/>
      <el-table-column label="id" align="center" prop="id"/>
      <el-table-column label="用户名" align="center" prop="userName"/>
      <el-table-column label="商标id" align="center" prop="logoFileId">
        <template slot-scope="scope">
          <image-preview :src="scope.row.logoFileId"/>
        </template>
      </el-table-column>
      <el-table-column label="企业名称" align="center" prop="name"/>
      <el-table-column label="宣传信息" align="center" prop="description"/>
      <el-table-column label="法人" align="center" prop="legalPerson"/>
      <el-table-column label="地址" align="center" prop="address"/>
      <el-table-column label="电话" align="center" prop="phone"/>
      <el-table-column label="电子邮件" align="center" prop="email"/>
      <el-table-column label="官网" align="center" prop="website"/>
      <el-table-column label="企业热度" align="center" prop="popularity"/>
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="updateTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.updateTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="操作" align="center" class-name="small-padding fixed-width">
        <template slot-scope="scope">
          <el-button
            size="mini"
            type="text"
            icon="el-icon-edit"
            @click="handleUpdate(scope.row)"
            v-hasPermi="['admin:etp:edit']"
          >修改
          </el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['admin:etp:remove']"
          >删除
          </el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getList"
    />

    <!-- 添加或修改企业管理对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="logo" prop="logoFileId">
          <image-upload v-model="form.logoFileId" :file-type="['png', 'jpg', 'jpeg']" limit="1"/>
        </el-form-item>
        <!--          <el-input v-model="form.userId" placeholder="请输入用户id" />-->
        <el-form-item label="用户" prop="userId">
          <el-select v-model="form.userId" placeholder="请选择企业用户"
                     :loading="loading" @visible-change="getUserList" :style="{width: '100%'}">
            <el-option v-for="user in userList" :key="user.id" :label="user.username"
                       :value="user.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="企业名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入企业名称"/>
        </el-form-item>
        <el-form-item label="宣传信息" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容"/>
        </el-form-item>
        <el-form-item label="法人" prop="legalPerson">
          <el-input v-model="form.legalPerson" placeholder="请输入法人"/>
        </el-form-item>
        <el-form-item label="地址" prop="address">
          <el-input v-model="form.address" placeholder="请输入地址"/>
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="form.phone" placeholder="请输入电话"/>
        </el-form-item>
        <el-form-item label="电子邮件" prop="email">
          <el-input v-model="form.email" placeholder="请输入电子邮件"/>
        </el-form-item>
        <el-form-item label="官网" prop="website">
          <el-input v-model="form.website" placeholder="请输入官网"/>
        </el-form-item>
        <el-form-item label="企业热度" prop="popularity">
          <el-input v-model="form.popularity" placeholder="请输入企业热度"/>
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
import {listEtp, getEtp, delEtp, addEtp, updateEtp} from "@/api/admin/etp";
import {listUser} from "@/api/admin/user";

export default {
  name: "Etp",
  data() {
    return {
      // 遮罩层
      loading: true,
      // 选中数组
      ids: [],
      userList: [],
      // 非单个禁用
      single: true,
      // 非多个禁用
      multiple: true,
      // 显示搜索条件
      showSearch: true,
      // 总条数
      total: 0,
      // 企业管理表格数据
      etpList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        userId: null,
        name: null,
        legalPerson: null,
        phone: null,
        website: null,
        popularity: null,
      },
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        userId: [
          {required: true, message: "todo不能为空", trigger: "blur"}
        ],
        name: [
          {required: true, message: "企业名称不能为空", trigger: "blur"}
        ],
        legalPerson: [
          {required: true, message: "法人不能为空", trigger: "blur"}
        ],
      }
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询企业管理列表 */
    getList() {
      this.loading = true;
      listEtp(this.queryParams).then(response => {
        this.etpList = response.rows;
        this.total = response.total;
        this.loading = false;
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
        id: null,
        userId: null,
        logoFileId: null,
        name: null,
        description: null,
        legalPerson: null,
        address: null,
        phone: null,
        email: null,
        website: null,
        popularity: null,
        createTime: null,
        updateTime: null,
        status: null,
        version: null
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
      this.resetForm("queryForm");
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length !== 1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加企业管理";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getEtp(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改企业管理";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          if (this.form.id != null) {
            updateEtp(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addEtp(this.form).then(response => {
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
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除企业管理编号为"' + ids + '"的数据项？').then(function () {
        return delEtp(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {
      });
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('admin/etp/export', {
        ...this.queryParams
      }, `etp_${new Date().getTime()}.xlsx`)
    },
    getUserList() {
      listUser({userType: 'enterprise'}).then(response => {
        this.userList = response.rows;
      });
    }
  }
};
</script>
