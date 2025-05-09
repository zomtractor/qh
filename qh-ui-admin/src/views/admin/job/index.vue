<template>
  <div class="app-container">
    <el-form :model="queryParams" ref="queryForm" size="small" :inline="true" v-show="showSearch" label-width="68px">
      <el-form-item label="职位名称" prop="name">
        <el-input
          v-model="queryParams.name"
          placeholder="请输入职位名称"
          clearable
          @keyup.enter.native="handleQuery"
        />
      </el-form-item>
      <el-form-item label="企业名称" prop="etpName">
        <el-autocomplete
          class="inline-input"
          v-model="searchEtp"
          :fetch-suggestions="etpSearch"
          @select="handleEtpSelect"
          placeholder="请输入内容"
        ></el-autocomplete>

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
          v-hasPermi="['admin:job:add']"
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
          v-hasPermi="['admin:job:edit']"
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
          v-hasPermi="['admin:job:remove']"
        >删除</el-button>
      </el-col>
      <el-col :span="1.5">
        <el-button
          type="warning"
          plain
          icon="el-icon-download"
          size="mini"
          @click="handleExport"
          v-hasPermi="['admin:job:export']"
        >导出</el-button>
      </el-col>
      <right-toolbar :showSearch.sync="showSearch" @queryTable="getList"></right-toolbar>
    </el-row>

    <el-table v-loading="loading" :data="jobList" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="55" align="center" />
      <el-table-column label="id" align="center" prop="id" />
      <el-table-column label="岗位名称" align="center" prop="name" />
      <el-table-column label="岗位职责" align="center" prop="description" />
      <el-table-column label="todo" align="center" prop="salaryDesc" />
      <el-table-column label="工作地点" align="center" prop="location" />
      <el-table-column label="要求条件" align="center" prop="requirement" />
      <el-table-column label="企业名称" align="center" prop="etpId" />
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
            v-hasPermi="['admin:job:edit']"
          >修改</el-button>
          <el-button
            size="mini"
            type="text"
            icon="el-icon-delete"
            @click="handleDelete(scope.row)"
            v-hasPermi="['admin:job:remove']"
          >删除</el-button>
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

    <!-- 添加或修改岗位对话框 -->
    <el-dialog :title="title" :visible.sync="open" width="500px" append-to-body>
      <el-form ref="form" :model="form" :rules="rules" label-width="80px">
        <el-form-item label="名称" prop="name">
          <el-input v-model="form.name" placeholder="请输入名称" />
        </el-form-item>
        <el-form-item label="岗位职责" prop="description">
          <el-input v-model="form.description" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="todo" prop="salaryDesc">
          <el-input v-model="form.salaryDesc" placeholder="请输入todo" />
        </el-form-item>
        <el-form-item label="工作地点" prop="location">
          <el-input v-model="form.location" placeholder="请输入工作地点" />
        </el-form-item>
        <el-form-item label="要求条件" prop="requirement">
          <el-input v-model="form.requirement" type="textarea" placeholder="请输入内容" />
        </el-form-item>
        <el-form-item label="分类" prop="categoryIds">
          <el-autocomplete
            class="inline-input"
            v-model="searchCategory"
            :fetch-suggestions="queryCategory"
            placeholder="请输入内容"
            @select="handleCategorySelect"
            @change="handleCategoryEntered"
          ></el-autocomplete>
          <el-tag
            v-for="tag in form.categoryList"
            closable
            :disable-transitions="true"
            :key="tag"
            type="info"
            @close="closeCategory(tag)"
          >
            <span class="el-select__tags-text">{{ tag.name }}</span>
          </el-tag>
        </el-form-item>
        <el-form-item label="标签" prop="tagIds">
          <el-autocomplete
            class="inline-input"
            v-model="searchTag"
            :fetch-suggestions="queryTag"
            placeholder="请输入内容"
            @select="handleTagSelect"
            @change="handleTagEntered"
          ></el-autocomplete>
          <el-tag
            v-for="tag in form.tagList"
            closable
            :disable-transitions="true"
            :key="tag"
            type="info"
            @close="closeTag(tag)"
          >
            <span class="el-select__tags-text">{{ tag.name }}</span>
          </el-tag>
        </el-form-item>
        <el-form-item label="岗位热度" prop="popularity">
          <el-input v-model="form.popularity" placeholder="请输入岗位热度" />
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
import { listJob, getJob, delJob, addJob, updateJob } from "@/api/admin/job";
import { listEtp} from "@/api/admin/etp";
import {listTag,addTag} from "@/api/admin/tag";
import {listCategory,addCategory} from "@/api/admin/category";
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
      // 弹出层标题
      title: "",
      // 是否显示弹出层
      open: false,
      // 查询参数
      queryParams: {
        pageNum: 1,
        pageSize: 10,
        name: null,
        etpId: null,
        description: null,
      },
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
      },

      searchEtp: null,
      searchTag: null,
      searchCategory: null,
    };
  },
  created() {
    this.getList();
  },
  methods: {
    /** 查询岗位列表 */
    getList() {
      this.loading = true;
      listJob(this.queryParams).then(response => {
        this.jobList = response.rows;
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
        name: null,
        description: null,
        salaryDesc: null,
        location: null,
        requirement: null,
        etpId: null,
        categoryIds: null,
        tagIds: null,
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
      if(!this.searchEtp) {
        this.queryParams.etpId = null;
      }
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
      this.single = selection.length!==1
      this.multiple = !selection.length
    },
    /** 新增按钮操作 */
    handleAdd() {
      this.reset();
      this.tagList=[];
      this.categoryList=[];
      this.open = true;
      this.title = "添加岗位";
    },
    /** 修改按钮操作 */
    handleUpdate(row) {
      this.reset();
      const id = row.id || this.ids
      getJob(id).then(response => {
        this.form = response.data;
        this.open = true;
        this.title = "修改岗位";
      });
    },
    /** 提交按钮 */
    submitForm() {
      this.$refs["form"].validate(valid => {
        if (valid) {
          this.form.categoryIds = this.form.categoryList.map(item => item.id).join(",");
          this.form.tagIds = this.form.tagList.map(item => item.id).join(",");
          if (this.form.id != null) {
            updateJob(this.form).then(response => {
              this.$modal.msgSuccess("修改成功");
              this.open = false;
              this.getList();
            });
          } else {
            addJob(this.form).then(response => {
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
      this.$modal.confirm('是否确认删除岗位编号为"' + ids + '"的数据项？').then(function() {
        return delJob(ids);
      }).then(() => {
        this.getList();
        this.$modal.msgSuccess("删除成功");
      }).catch(() => {});
    },
    /** 导出按钮操作 */
    handleExport() {
      this.download('admin/job/export', {
        ...this.queryParams
      }, `job_${new Date().getTime()}.xlsx`)
    },

    etpSearch(queryString, cb) {
      listEtp({name: this.searchEtp}).then(response => {
        // list response.rows and get etpNames
        let data = response.rows.map(item => {
          return {
            value: item.id,
            name: item.name
          }
        });
        cb(data);
      });

    },
    handleEtpSelect(item){
      this.queryParams.etpId = item.value;
      this.searchEtp = item.name;
    },
    handleClose(list,tag) {
      list.splice(this.dynamicTags.indexOf(tag), 1);
    },
    handleInputTagsConfirm() {
      let inputValue;
      if (inputValue) {
        this.form.tagList.push(inputValue);
      }
      this.inputVisible = false;
    },
    queryCategory(queryString, cb) {
      listCategory({name:queryString}).then(response => {
        // list response.rows and get etpNames
        let data = response.rows.map(item => {
          return {
            value: item.name,
            category: item
          }
        });
        cb(data);
      });
    },
    handleCategorySelect(item){
      if (item.name && !this.form.categoryList.some(tag => tag.name === item.name)) {
        this.form.categoryList.push(item.category);
      }
      this.searchCategory = ''

    },
    handleCategoryEntered(itemName){
      if (itemName && !this.form.categoryList.some(tag => tag.name === itemName)) {
        listCategory({name:itemName}).then(response => {
          if (response.rows.length > 0) {
            this.form.categoryList.push(response.rows[0]);
          } else {
            addCategory({name:itemName}).then(response => {
              this.form.categoryList.push(response.data);
            });
          }
        });
      }
      this.searchCategory = ''

    },
    closeCategory(tag) {
      this.form.categoryList.splice(this.form.categoryList.indexOf(tag), 1);
    },
    queryTag(queryString, cb) {
      listTag({name:queryString}).then(response => {
        // list response.rows and get etpNames
        let data = response.rows.map(item => {
          return {
            value: item.name,
            tag: item
          }
        });
        cb(data);
      });
    },
    handleTagSelect(item){
      if (item.name && !this.form.tagList.some(tag => tag.name === item.name)) {
        this.form.tagList.push(item.tag);
      }
      this.searchTag = ''

    },
    handleTagEntered(itemName){
      if (itemName && !this.form.tagList.some(tag => tag.name === itemName)) {
        listTag({name:itemName}).then(response => {
          if (response.rows.length > 0) {
            this.form.tagList.push(response.rows[0]);
          } else {
            addTag({name:itemName}).then(response => {
              this.form.tagList.push(response.data);
            });
          }
        });
      }
      this.searchTag = ''

    },
    closeTag(tag) {
      this.form.tagList.splice(this.form.tagList.indexOf(tag), 1);
    },
  },

};
</script>
