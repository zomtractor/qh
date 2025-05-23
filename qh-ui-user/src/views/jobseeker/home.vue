<template>
  <div class="home-container">
    <!-- 搜索框 -->
    <div class="search-bar">
      <el-input
        v-model="searchKeyword"
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
      <el-select v-model="city" placeholder="选择城市">
        <el-option
          v-for="item in cities"
          :key="item"
          :label="item"
          :value="item"
        />
      </el-select>
      <el-select v-model="salary" placeholder="选择薪资">
        <el-option
          v-for="item in salaries"
          :key="item"
          :label="item"
          :value="item"
        />
      </el-select>
      <el-select v-model="industry" placeholder="选择公司行业">
        <el-option
          v-for="item in industries"
          :key="item"
          :label="item"
          :value="item"
        />
      </el-select>
      <el-button type="primary" @click="handleConfirm">确定</el-button>
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
      <el-pagination
        background
        layout="prev, pager, next"
        :total="total"
        :page-size="pageSize"
        :current-page="currentPage"
        @current-change="handlePageChange"
      />
    </div>
  </div>
</template>

<script>
import { search, confirmFilters,submitResume, navigateToHome,page } from '@/api/home/home'

export default {
  name: 'Home',
  data() {
    return {
      searchKeyword: '', // 搜索关键词
      city: '',
      salary: '',
      industry: '',
      cities: [
        '北京', '上海', '广州', '深圳', '天津', '重庆', '杭州', '南京', '武汉', '成都',
        '西安', '长沙', '沈阳', '哈尔滨', '长春', '济南', '郑州', '合肥', '福州', '南昌',
        '昆明', '贵阳', '南宁', '太原', '石家庄', '兰州', '西宁', '银川', '乌鲁木齐', '海口'
      ],
      salaries: [
        '5k以下', '5-10k', '10-15k', '15k以上'
      ],
      industries: [
        '国企', '外企', '民企', '事业单位', '银行', '央企'
      ],
      jobs: [],
      total: 0, // 总条数
      pageSize: 8, // 每页显示条数
      currentPage: 1 // 当前页码
    }
  },
  created() {
    navigateToHome().then(res => {
        this.jobs = res.rows.sort((a, b) => b.popularity - a.popularity);
        this.total= res.total;
      }); // 进入页面时发送请求并排序
  },
  methods: {
    handleSearch() {
      search({
        keyword: this.searchKeyword,
      }).then(res => {
        this.jobs = res.rows.sort((a, b) => b.popularity - a.popularity);
        this.total = res.total;
      })
    },
    handleConfirm() {
      const params = {
        city: this.city,
        salary: this.salary,
        industry: this.industry
      };
      confirmFilters(params).then(res => {
        this.jobs = res.rows.sort((a, b) => b.popularity - a.popularity);
        this.total = res.total;
      });
    },
    handleCommunicate() {
      this.$router.push({path: '/communicate'});
        // 处理沟通结果
    },
    handleSubmitResume() {
      this.$router.push({path: '/communicate'});
        // 处理投递简历结果
    },
    handlePageChange(page) {
      this.currentPage = page;
      this.getJobList();
    },
    getJobList() {
      page({
        pageNum: this.currentPage,
        pageSize: this.pageSize
      }).then(res => {
        this.jobs = res.rows.sort((a, b) => b.popularity - a.popularity);
        this.total = res.total;
      })
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

</style>