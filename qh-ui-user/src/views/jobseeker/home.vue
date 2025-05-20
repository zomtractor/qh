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

    <!-- 职位卡片 -->
    <div class="job-list">
      <div class="job-card" v-for="(job, index) in jobs" :key="index">
        <div class="job-title">{{ job.title }}</div>
        <div class="company-info">
          <div class="company-logo"></div>
          <div class="company-name">{{ job.company }}</div>
          <div class="company-size">{{ job.size }}</div>
        </div>
        <div class="skills">
          <el-tag v-for="skill in job.skills" :key="skill">{{ skill }}</el-tag>
        </div>
        <div class="job-description">
          <div v-for="(desc, index) in job.description" :key="index">{{ desc }}</div>
        </div>
        <div class="job-details">
          <div class="salary">{{ job.salary }}</div>
          <div class="location">{{ job.location }}</div>
        </div>
        <div class="actions">
          <el-button type="primary" @click="handleCommunicate(job.id)">沟通</el-button>
          <el-button type="primary" @click="handleSubmitResume(job.id)">投递简历</el-button>
        </div>
      </div>
    </div>

    <!-- 分页控件 -->
    <div class="pagination">
      <el-pagination
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
import { search, confirmFilters, getPage, submitResume, communicate } from '@/api/home/home'

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
        '5k以下', '5-10k', '10-15k', '15-20k', '20-25k', '25k以上'
      ],
      industries: [
        '国企', '外企', '民企', '事业单位', '银行', '央企'
      ],
      jobs: [
        {
          title: 'Python开发工程师',
          company: '测试公司',
          size: '人数：9999以上',
          skills: ['python', '后端开发', 'MySQL'],
          description: [
            '负责策划相关工具链构建及维护',
            '负责公司内自动化开发测试环境搭建及维护',
            '负责游戏运营相关大数据分析工具及后台支撑'
          ],
          salary: '薪资：7k-8k',
          location: '地点：福州'
        },
        {
          title: 'Python开发工程师',
          company: '测试公司',
          size: '人数：9999以上',
          skills: ['python', '后端开发', 'MySQL'],
          description: [
            '负责策划相关工具链构建及维护',
            '负责公司内自动化开发测试环境搭建及维护',
            '负责游戏运营相关大数据分析工具及后台支撑'
          ],
          salary: '薪资：7k-8k',
          location: '地点：福州'
        },
        {
          title: 'Python开发工程师',
          company: '测试公司',
          size: '人数：9999以上',
          skills: ['python', '后端开发', 'MySQL'],
          description: [
            '负责策划相关工具链构建及维护',
            '负责公司内自动化开发测试环境搭建及维护',
            '负责游戏运营相关大数据分析工具及后台支撑'
          ],
          salary: '薪资：7k-8k',
          location: '地点：福州'
        }
      ],
      total: 68, // 总条数
      pageSize: 10, // 每页显示条数
      currentPage: 1 // 当前页码
    }
  },
  methods: {
    handleSearch() {
      search({
        keyword: this.searchKeyword,
      }).then(res => {
        this.jobs = res.data;
      })
    },
    handleConfirm() {
      const params = {
        city: this.city,
        salary: this.salary,
        industry: this.industry
      };
      confirmFilters(params).then(res => {
        this.handleSearch();
      });
    },
    handleCommunicate(jobId) {
      communicate(jobId).then(res => {
        // 处理沟通结果
      });
    },
    handlePageChange(page) {
      this.currentPage = page;
      getPage({
        page: this.currentPage,
        pageSize: this.pageSize
      }).then(res => {
        this.jobs = res.data;
      });
    },
    handleSubmitResume(jobId) {
      submitResume(jobId).then(res => {
        // 处理投递简历结果
      });
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
  background-color: white;
  padding: 20px;
  border-radius: 8px;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.job-card {
  margin-bottom: 20px;
  padding: 20px;
  border-bottom: 1px solid #eee;
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

.actions .el-button {
  margin-right: 10px;
}

.pagination {
  margin-top: 20px;
  text-align: center;
}
</style>