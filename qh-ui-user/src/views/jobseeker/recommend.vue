<template>
  <div class="recommend-container">
    <!-- 筛选条件 -->
    <div class="filter-section">
      <div class="filter-tags">
        <el-radio-group v-model="priority">
          <el-radio label="skill">优先技能</el-radio>
          <el-radio label="hot">优先热度</el-radio>
          <el-radio label="welfare">优先福利</el-radio>
        </el-radio-group>
      </div>
      <div class="filter-selects">
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
        <el-button type="primary" @click="handleFilter">筛选</el-button>
      </div>
    </div>

    <!-- 职位卡片 -->
    <div class="job-list">
      <div class="job-card" v-for="(item, index) in jobs" :key="index">
        <div class="job-header">
          <div class="job-title">{{ item.userJob.name }}</div>
          <div class="match-score">匹配度：{{ item.score.toFixed(2) }}</div>
        </div>
        <div class="job-info">
          <div class="salary">薪资：{{ item.userJob.salaryDesc }}</div>
          <div class="location">地点：{{ item.userJob.location }}</div>
        </div>
        <div class="job-description">
          <div class="description-title">职位描述：</div>
          <div class="description-content">{{ item.userJob.description }}</div>
        </div>
        <div class="job-requirement">
          <div class="requirement-title">职位要求：</div>
          <div class="requirement-content">{{ item.userJob.requirement }}</div>
        </div>
        <div class="action-buttons">
          <el-button type="primary" @click="communicate(item.userJob)">沟通</el-button>
          <el-button type="success" @click="submitResume(item.userJob)">投递简历</el-button>
        </div>
      </div>
    </div>

    <!-- 分页 -->
    <div class="pagination">
      <el-pagination
        background
        layout="prev, pager, next"
        :total="100"
        :current-page.sync="currentPage"
        @current-change="handlePageChange">
      </el-pagination>
    </div>
  </div>
</template>

<script>
import { getRecommendJobs, communicateWithRecruiter, submitResumeToJob } from '@/api/recommend/recommend'
export default {
  data() {
    return {
      priority: 'skill', // 推荐算法
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
      currentPage: 1,
      pageSize: 8,
      total: 60,
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
      ]
    }
  },
  methods: {
    // 获取职位列表数据
    async fetchJobs() {
      try {
        const params = {
          page: this.currentPage,
          pageSize: this.pageSize,
          city: this.city,
          priority: this.priority,
          salary: this.salary,
          industry: this.industry,
        }
        const res = await getRecommendJobs(params)
        this.jobs = res.data
        console.log(res.data.total)
      } catch (error) {
        this.$message.error('获取职位列表失败')
        console.error('获取职位列表失败:', error)
      }
    },
    // 处理筛选条件
    async handleFilter() {
      this.currentPage = 1
      await this.fetchJobs()
    },
    // 处理分页变化
    async handlePageChange(page) {
      this.currentPage = page
      await this.fetchJobs()
    },
    // 处理沟通请求
    async communicate(job) {
      try {
        await communicateWithRecruiter({ jobId: job.id })
        this.$message.success('已发起沟通请求')
        // 这里可以添加跳转到聊天页面的逻辑
        this.$router.push({
          path: '/chat',
          query: { jobId: job.id }
        })
      } catch (error) {
        this.$message.error('发起沟通失败')
        console.error('发起沟通失败:', error)
      }
    },
    // 处理简历投递
    async submitResume(job) {
      try {
        await submitResumeToJob({ jobId: job.id })
        this.$message.success('简历投递成功')
      } catch (error) {
        this.$message.error('简历投递失败')
        console.error('简历投递失败:', error)
      }
    }
  },
  created() {
    this.fetchJobs()
  }
}
</script>

<style scoped lang="scss">
.recommend-container {
  padding: 20px;
  background-color: #f5f7fa;
  min-height: 100vh;

  .filter-section {
    background: #fff;
    padding: 20px;
    margin-bottom: 24px;
    border-radius: 8px;
    box-shadow: 0 2px 12px 0 rgba(0,0,0,.05);

    .filter-tags {
      margin-bottom: 20px;
      .el-radio-group {
        display: flex;
        flex-wrap: wrap;
        .el-radio {
          margin-right: 24px;
          margin-bottom: 10px;
          line-height: 32px;
        }
      }
    }

    .filter-selects {
      display: flex;
      align-items: center;
      .el-select {
        margin-right: 20px;
        width: 180px;
      }
      .el-button {
        margin-left: auto;
      }
    }
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
      transform: translateY(-5px);
      box-shadow: 0 4px 16px 0 rgba(0, 0, 0, 0.15);
    }

    .job-header {
      display: flex;
      justify-content: space-between;
      align-items: center;
      margin-bottom: 15px;
    }

    .job-title {
      font-size: 18px;
      font-weight: bold;
      color: #303133;
    }

    .match-score {
      font-size: 16px;
      font-weight: bold;
      color: #67c23a;
      padding: 4px 8px;
      background-color: #f0f9eb;
      border-radius: 4px;
    }

    .job-info {
      display: flex;
      justify-content: space-between;
      margin-bottom: 15px;
      font-size: 14px;
      color: #606266;
    }

    .job-description,
    .job-requirement {
      margin-bottom: 15px;
    }

    .description-title,
    .requirement-title {
      font-size: 14px;
      font-weight: bold;
      color: #303133;
      margin-bottom: 8px;
    }

    .description-content,
    .requirement-content {
      font-size: 14px;
      color: #606266;
      line-height: 1.6;
      white-space: pre-wrap;
    }

    .action-buttons {
      display: flex;
      justify-content: space-between;
      margin-top: 20px;
    }

    .action-buttons .el-button {
      width: 48%;
      font-size: 14px;
    }
  
}
</style>
</template>