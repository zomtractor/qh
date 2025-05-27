<template>
  <div class="app-container" style="height: 100%; width: 100%">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="职位名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入职位名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="分类" prop="categoryIds">
        <el-select v-model="queryCategoryList" placeholder="请选择分类" multiple
                   :loading="loading" @visible-change="getCategoryList" :style="{width: '100%'}" >
          <el-option v-for="category in categoryList" :key="category.id" :label="category.name"
                     :value="category.id"></el-option>
        </el-select>
      </el-form-item>
      <el-form-item label="标签" prop="tagIds">
        <el-select v-model="queryTagList" placeholder="请选择标签" multiple
                   :loading="loading" @visible-change="getTagList" :style="{width: '100%'}" >
          <el-option v-for="tag in tagList" :key="tag.id" :label="tag.name"
                     :value="tag.id"></el-option>
        </el-select>
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
        >新增</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="success"
          plain
          icon="el-icon-edit"
          size="mini"
          :disabled="single"
          @click="handleUpdate"
        >修改</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="danger"
          plain
          icon="el-icon-delete"
          size="mini"
          :disabled="multiple"
          @click="handleDelete"
        >删除</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getJobList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="jobList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="id" align="center" prop="id" />
      <el-table-column label="岗位名称" align="center" prop="name" />
      <el-table-column label="岗位职责" align="center" prop="description" />
      <el-table-column label="薪资描述" align="center" prop="salaryDesc" />
      <el-table-column label="工作地点" align="center" prop="location" />
      <el-table-column label="要求条件" align="center" prop="requirement" />
      <el-table-column label="企业名称" align="center" prop="etpName" />
      <el-table-column label="分类" align="center" prop="categoryIds" >
        <template slot-scope="scope">
          <el-tag v-for="tag in scope.row.categoryList" :key="tag" size="small" effect="dark" type="" style="margin: 2px">
            {{ tag.name }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="标签" align="center" prop="tagIds">
        <template slot-scope="scope">
          <el-tag v-for="tag in scope.row.tagList" :key="tag" size="small" effect="dark" type="" style="margin-left: 2px">
            {{ tag.name }}
          </el-tag>
        </template>
      </el-table-column>
      <el-table-column label="岗位热度" align="center" prop="popularity" />
      <el-table-column label="创建时间" align="center" prop="createTime" width="180">
        <template slot-scope="scope">
          <span>{{ parseTime(scope.row.createTime, '{y}-{m}-{d}') }}</span>
        </template>
      </el-table-column>
      <el-table-column label="更新时间" align="center" prop="createTime" width="180">
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
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
          >删除</el-button>
        </template>
      </el-table-column>
    </el-table>

    <pagination
      v-show="total>0"
      :total="total"
      :page.sync="queryParams.pageNum"
      :limit.sync="queryParams.pageSize"
      @pagination="getJobList"
    />

    <!-- 添加或修改岗位对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="岗位职责" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入岗位职责" />
        </el-form-item>
        <el-form-item label="薪资描述" prop="salaryDesc">
          <el-input v-model="form.salaryDesc" placeholder="请输入薪资描述" />
        </el-form-item>
        <el-form-item label="工作地点" prop="location">
          <el-input v-model="form.location" placeholder="请输入工作地点" />
        </el-form-item>
        <el-form-item label="要求条件" prop="requirement">
          <el-input v-model="form.requirement" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="分类" prop="categoryIds">
          <el-select v-model="form.categoryList" placeholder="请选择分类" multiple
                     :loading="loading" @visible-change="getCategoryList" :style="{width: '100%'}" >
            <el-option v-for="category in categoryList" :key="category.id" :label="category.name"
                       :value="category.id"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="标签" prop="tagIds">
          <el-select v-model="form.tagList" placeholder="请选择标签" multiple
                     :loading="loading" @visible-change="getTagList" :style="{width: '100%'}" >
            <el-option v-for="tag in tagList" :key="tag.id" :label="tag.name"
                       :value="tag.id"></el-option>
          </el-select>
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
import { listJob, getJob, delJob, addJob, updateJob } from "@/api/etp/job";
import { listTag, addTag } from "@/api/etp/tag";
import { listCategory, addCategory, updateCategory } from "@/api/etp/category";
import { getCurrentUser } from "@/utils/local";

export default {
  name: "Job",
  data() {
    return {
      // 遮罩层
      loading: true,
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
      // 岗位表格数据
      jobList: [],
      // 分类列表
      categoryList: [],
      // 标签列表
      tagList: [],
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null,
        etpId: getCurrentUser().refId,
        description: null,
        categoryIds: null,
        tagIds: null,
      },
      queryCategoryList: [],
      queryTagList: [],
      // 表单参数
      form: {},
      // 表单校验
      rules: {
        name: [
          { required: true, message: "名称不能为空", trigger: "blur" }
        ],
        description: [
          { required: true, message: "岗位职责不能为空", trigger: "blur" }
        ],
      }
    };
  },
  created() {
    this.getJobList();
    this.getCategoryList();
    this.getTagList();
  },
  methods: {
    /** 查询岗位列表 */
    getJobList() {
      this.loading = true;
      this.queryParams.categoryIds = this.queryCategoryList.join(",");
      this.queryParams.tagIds = this.queryTagList.join(",");
      listJob(this.queryParams).then(response => {
        this.jobList = response.rows;
        this.total = response.total;
        this.loading = false;
      });
    },
    /** 查询分类列表 */
    getCategoryList() {
      this.loading = true;
      listCategory({}).then(response => {
        this.categoryList = response.rows;
        this.loading = false;
      });
    },
    /** 查询标签列表 */
    getTagList() {
      this.loading = true;
      listTag({}).then(response => {
        this.tagList = response.rows;
        this.loading = false;
      });
    },
    /** 取消 */
    cancel() {
      this.open = false;
      this.reset();
    },
    /** 表单重置 */
    reset() {
      this.form = {
        id: null,
        name: null,
        description: null,
        salaryDesc: null,
        location: null,
        requirement: null,
        etpId: null,
        categoryList: [],
        categoryIds: "",
        tagList: [],
        tagIds: "",
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
      this.getJobList();
    },
    /** 重置按钮操作 */
    resetQuery() {
      this.resetForm("queryForm");
      this.queryCategoryList = [];
      this.queryTagList = [];
      this.handleQuery();
    },
    // 多选框选中数据
    handleSelectionChange(selection) {
      this.ids = selection.map(item => item.id)
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.open = true;
      this.title = "添加岗位";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getJob(id).then(response => {
        this.form = response.data;
        this.form.categoryList = this.form.categoryIds.split(",").map(item => parseInt(item));
        this.form.tagList = this.form.tagIds.split(",").map(item => parseInt(item));
        this.open = true;
        this.title = "修改岗位";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.categoryIds = this.form.categoryList.join(",");
          this.form.tagIds = this.form.tagList.join(",");
          this.form.etpId = getCurrentUser().refId;
          if (this.form.id != null) {
            updateJob(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getJobList();
            });
          } else {
            addJob(this.form).then(response => {
              this.$modal.msgSuccess("新增成功");
              this.open = false;
              this.getJobList();
            });
          }
        }
      });
    },
    /** 删除按钮操作 */
    handleDelete(row) {
      const ids = row.id || this.ids;
      this.$modal.confirm('是否确认删除岗位编号为"' + ids + '"的数据项？').then(function() {
        return delJob(ids);
      }).then(() => {
        this.getJobList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    }
  },
};
</script>