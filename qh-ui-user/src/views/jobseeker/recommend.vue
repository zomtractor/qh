<template>
  <div class="recommend-container">
    <!-- 筛选条件 -->
    <div class="filter-section">
      <div class="filter-tags">
        <el-radio-group v-model="filters.priority">
          <el-radio label="skill">优先技能</el-radio>
          <el-radio label="salary">优先薪资</el-radio>
          <el-radio label="welfare">优先福利</el-radio>
        </el-radio-group>
      </div>
      <div class="filter-selects">
        <el-select v-model="filters.city" placeholder="城市">
          <el-option label="福州" value="福州"></el-option>
        </el-select>
        <el-select v-model="filters.salaryRange" placeholder="薪资">
          <el-option label="7k-8k" value="7k-8k"></el-option>
        </el-select>
        <el-select v-model="filters.industry" placeholder="公司行业">
          <el-option label="测试公司" value="测试公司"></el-option>
        </el-select>
        <el-button type="primary" @click="handleFilter">筛选</el-button>
      </div>
    </div>

    <!-- 职位列表 -->
    <div class="job-list">
      <div v-for="(job, index) in jobs" :key="index" class="job-card">
        <div class="job-header">
          <div class="left">
            <h3 class="job-title">{{ job.title }}</h3>
            <div class="company-info">
              <img :src="job.companyLogo" class="company-logo">
              <span class="company-name">{{ job.companyName }}</span>
              <span class="company-size">{{ job.companySize }}人以上</span>
            </div>
            <div class="job-tags">
              <el-tag v-for="tag in job.tags" :key="tag" size="small" type="info">{{ tag }}</el-tag>
            </div>
          </div>
          <div class="right">
            <div class="salary">{{ job.salary }}</div>
            <div class="location">{{ job.location }}</div>
            <div class="action-buttons">
              <el-button type="primary" size="small" @click="communicate(job)">沟通</el-button>
              <el-button size="small" @click="submitResume(job)">投递简历</el-button>
            </div>
          </div>
        </div>
        <div class="job-description">
          <div v-for="(desc, idx) in job.description" :key="idx">{{ desc }}</div>
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
  name: 'Recommend',
  data() {
    return {
      filters: {
        priority: 'skill',
        city: '',
        salaryRange: '',
        industry: ''
      },
      currentPage: 1,
      pageSize: 5,
      total: 0,
      jobs: []
    }
  },
  methods: {
    // 获取职位列表数据
    async fetchJobs() {
      try {
        const params = {
          page: this.currentPage,
          pageSize: this.pageSize,
          ...this.filters
        }
        const res = await getRecommendJobs(params)
        this.jobs = res.data.list
        this.total = res.data.total
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
    .job-card {
      background: #fff;
      padding: 24px;
      margin-bottom: 20px;
      border-radius: 8px;
      box-shadow: 0 2px 12px 0 rgba(0,0,0,.05);
      transition: all 0.3s ease;
      border: 1px solid transparent;
      
      &:hover {
        transform: translateY(-2px);
        box-shadow: 0 4px 16px 0 rgba(0,0,0,.1);
        border-color: #e6e6e6;
      }

      .job-header {
        display: flex;
        justify-content: space-between;
        margin-bottom: 20px;

        .left {
          flex: 1;
          padding-right: 20px;

          .job-title {
            font-size: 20px;
            font-weight: 600;
            margin-bottom: 12px;
            color: #303133;

            &:hover {
              color: #409EFF;
              cursor: pointer;
            }
          }

          .company-info {
            display: flex;
            align-items: center;
            color: #606266;
            
            .company-logo {
              width: 40px;
              height: 40px;
              margin-right: 12px;
              border-radius: 4px;
              object-fit: cover;
              border: 1px solid #ebeef5;
            }

            .company-name {
              margin-right: 15px;
              font-size: 14px;
              &:hover {
                color: #409EFF;
                cursor: pointer;
              }
            }

            .company-size {
              color: #909399;
              font-size: 13px;
            }
          }
        }

        .right {
          text-align: right;
          min-width: 160px;
          
          .salary {
            color: #f56c6c;
            font-size: 18px;
            font-weight: 600;
            margin-bottom: 8px;
          }

          .location {
            color: #909399;
            font-size: 13px;
            margin-bottom: 12px;
          }

          .action-buttons {
            .el-button {
              margin-left: 8px;
              padding: 8px 12px;
              font-size: 13px;

              &:first-child {
                margin-left: 0;
              }
            }
          }
        }
      }
      .job-description {
        margin-top: 16px;
        margin-bottom: 20px;
        color: #606266;
        line-height: 1.8;
        font-size: 14px;
        
        div {
          margin-bottom: 6px;
          &:last-child {
            margin-bottom: 0;
          }
        }
      }
    }
  }
}
</style>
</template>