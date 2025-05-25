<template>
  <div class="home-container">
    <!-- 搜索框 -->
    <div class="search-bar">
      <el-input
        v-model="queryParams.keywords"
        placeholder="搜公司、职位"
        @keyup.enter.native="handleSearch"
      >
        <el-button
          slot="append"
          icon="el-icon-search"
          @click="handleSearch"
        />
      </el-input>
    </div>

    <!-- 筛选条件 -->
    <div class="filters">
      <el-select v-model="queryParams.location" placeholder="选择城市" clearable>
        <el-option
          v-for="item in cities"
          :key="item"
          :label="item"
          :value="item"
        />
      </el-select>
      <el-select v-model="salaryRange" placeholder="选择薪资" clearable>
        <el-option
          v-for="item in salaries"
          :key="item.id"
          :label="item.desc"
          :value="item.range"
        />
      </el-select>
      <el-select v-model="queryCategoryList" placeholder="请选择分类" multiple
                 :loading="loading" @visible-change="getCategoryList">
        <el-option v-for="category in categoryList" :key="category.id" :label="category.name"
                   :value="category.id"></el-option>
      </el-select>
      <el-select v-model="queryTagList" placeholder="请选择标签" multiple
                 :loading="loading" @visible-change="getTagList">
        <el-option v-for="tag in tagList" :key="tag.id" :label="tag.name"
                   :value="tag.id"></el-option>
      </el-select>
      <el-button type="primary" @click="handleSearch">确定</el-button>
    </div>

    <!-- 职位列表 -->
    <div class="job-list">
      <div class="job-card" v-for="(job, index) in jobs" :key="index">
        <div class="job-header">
             <div class="job-name">职位名称：{{ job.name }}</div>
             <div class="job-popularity">热门度：{{ job.popularity }}</div>
        </div>
        <div class="job-info">
             <div class="salary">薪资：{{ job.salaryDesc }}</div>
             <div class="location">地点：{{ job.location }}</div>
        </div>
        <div class="job-description">
          <div class="description-title">职位描述：</div>
          <div class="description-content">{{ job.description }}</div>
        </div>
        <div class="job-requirement">
          <div class="requirement-title">职位要求：</div>
          <div class="requirement-content">{{ job.requirement }}</div>
        </div>
        <div class="actions">
          <el-button type="primary" @click="handleCommunicate">沟通</el-button>
          <el-button type="success" @click="handleSubmitResume">投递简历</el-button>
        </div>
      </div>
    </div>
    <div class="pagination">
      <pagination
          v-show="total>0"
          :total="total"
          :page.sync="queryParams.pageNum"
          :limit.sync="queryParams.pageSize"
          @pagination="getJobList"
      />
    </div>
  </div>
</template>

<script>
import { jobList, getJob } from '@/api/home/home'
import { getCurrentUser } from "@/utils/local";
import { listTag } from "@/api/etp/tag";
import { listCategory } from "@/api/etp/category";

export default {
  name: 'Home',

  data() {
    return {
      cities: [
        '北京', '上海', '广州', '深圳', '天津', '重庆', '杭州', '南京', '武汉', '成都',
        '西安', '长沙', '沈阳', '哈尔滨', '长春', '济南', '郑州', '合肥', '福州', '南昌',
        '昆明', '贵阳', '南宁', '太原', '石家庄', '兰州', '西宁', '银川', '乌鲁木齐', '海口'
      ],
      salaries: [
        {id:1, desc:'5k以下', range:'0,5000'},
        {id:2, desc:'5-10k', range:'5000,10000'},
        {id:3, desc:'10-15k', range:'10000,15000'},
        {id:4, desc:'15k以上', range:'15000,0'}
      ],
      loading: true,
      jobs: [],
      categoryList: [],
      tagList: [],
      queryCategoryList: [],
      queryTagList: [],
      salaryRange: null,
      queryParams: {
        pageNum: 1,
        pageSize: 8,
        keywords: null,
        categoryIds: null,
        tagIds: null,
        salaryLowerBound: null,
        salaryUpperBound: null,
        location: null,
      },
    }
  },
  created() {
    this.getJobList();
  },
  methods: {
    // 获取岗位列表
    getJobList() {
      this.loading = true;
      if (this.salaryRange != null) {
        this.queryParams.salaryLowerBound = this.salaryRange.split(',')[0];
        this.queryParams.salaryUpperBound = this.salaryRange.split(',')[1];
      }
      this.queryParams.categoryIds = this.queryCategoryList.join(",");
      this.queryParams.tagIds = this.queryTagList.join(",");
      jobList(this.queryParams).then(res => {
        this.jobs = res.rows.sort((a, b) => b.popularity - a.popularity);
        this.total = res.total;
        this.loading = false;
      })
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
    // 搜索
    handleSearch() {
      this.queryParams.pageNum = 1;
      this.getJobList();
    },
    // 沟通
    handleCommunicate() {
      this.$router.push({path: '/communicate'});
        // TODO:处理沟通结果
    },
    // 投递简历
    handleSubmitResume() {
      this.$router.push({path: '/communicate'});
        // TODO:处理投递简历结果
    }
  }
}
</script>

<style scoped>
.home-container {
  background-color: #f5f5f5;
  padding: 20px;
}

.search-bar {
  margin-bottom: 20px;
}

.search-bar .el-input {
  width: 300px;
}

.filters {
  display: flex;
  align-items: center;
  margin-bottom: 20px;
}

.filters .el-select {
  margin-right: 10px;
  width: 150px;
}

.job-list {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(300px, 1fr));
      gap: 20px;
      padding: 20px;
    }

    .job-card {
      border: 1px solid #dcdfe6;
      border-radius: 8px;
      padding: 20px;
      background-color: #fff;
      box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
      transition: all 0.3s ease;
    }

.job-card:hover {
  transform: translateY(-2px);
  box-shadow: 0 4px 12px 0 rgba(0, 0, 0, 0.12);
}

.job-title {
  font-size: 18px;
  font-weight: bold;
}

.company-info {
  display: flex;
  align-items: center;
  margin: 10px 0;
}

.company-logo {
  width: 30px;
  height: 30px;
  border-radius: 50%;
  background-color: #ccc;
  margin-right: 10px;
}

.skills {
  margin: 10px 0;
}

.skills .el-tag {
  margin-right: 5px;
}

.job-description {
  margin: 10px 0;
}

.job-details {
  display: flex;
  margin: 10px 0;
}

.salary {
  margin-right: 20px;
}

.actions {
  margin-top: 10px;
}

.actions {
  display: flex;
  gap: 12px;
  margin-top: 20px;
}

.actions .el-button {
  flex: 1;
  padding: 12px 0;
  font-size: 14px;
  border-radius: 6px;
}

.actions .el-button--primary {
  background: #409eff;
  border-color: #409eff;
}

.actions .el-button--success {
  background: #67c23a;
  border-color: #67c23a;
}

.pagination {
  margin-top: 20px;
  text-align: center;
}

.job-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.job-name {
  font-size: 20px;
  font-weight: 600;
  color: #1d2129;
}

.job-info {
  display: flex;
  justify-content: space-between;
  margin-bottom: 20px;
  font-size: 14px;
  color: #4e5969;
}

.salary {
  color: #f56c6c;
  font-weight: 500;
}

.location {
  color: #86909c;
}

.job-description,
.job-requirement {
  margin-bottom: 20px;
  line-height: 1.6;
  text-align: left;
}

.description-title,
.requirement-title {
  font-size: 16px;
  font-weight: 600;
  color: #1d2129;
  margin-bottom: 12px;
}

.description-content,
.requirement-content {
  font-size: 14px;
  color: #4e5969;
  line-height: 1.6;
}
</style>