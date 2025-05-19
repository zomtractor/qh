<template>
  <div class="recommend-container">
    <!-- 筛选条件 -->
    <div class="filter-section">
      <div class="filter-tags">
        <el-checkbox v-model="filters.skill">优先技能</el-checkbox>
        <el-checkbox v-model="filters.salary">优先薪资</el-checkbox>
        <el-checkbox v-model="filters.scale">优先规模</el-checkbox>
        <el-checkbox v-model="filters.development">优先发展</el-checkbox>
        <el-checkbox v-model="filters.interview">优先面试效率</el-checkbox>
        <el-checkbox v-model="filters.welfare">优先福利</el-checkbox>
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
              <el-tag v-for="tag in job.tags" :key="tag" size="small">{{ tag }}</el-tag>
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
export default {
  name: 'Recommend',
  data() {
    return {
      filters: {
        skill: true,
        salary: false,
        scale: false,
        development: false,
        interview: false,
        welfare: false,
        city: '',
        salaryRange: '',
        industry: ''
      },
      currentPage: 1,
      jobs: [
        {
          title: 'Python开发工程师',
          companyName: '测试公司',
          companyLogo: '',
          companySize: '9999',
          salary: '7k-8k',
          location: '福州',
          tags: ['python', '后端开发', 'MySql'],
          description: [
            '1. 负责策划相关工具链构建及维护',
            '2. 负责公司内自动化开发测试环境搭建及维护',
            '3. 负责游戏运营相关大数据分析工具及后台支撑'
          ]
        }
      ]
    }
  },
  methods: {
    handlePageChange(page) {
      this.currentPage = page;
      // TODO: 加载对应页面数据
    },
    communicate(job) {
      // TODO: 实现沟通功能
    },
    submitResume(job) {
      // TODO: 实现简历投递功能
    }
  },
  created() {
    // TODO: 初始化加载数据
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
      .el-checkbox {
        margin-right: 24px;
        margin-bottom: 10px;
      }
    }

    .filter-selects {
      .el-select {
        margin-right: 20px;
        width: 180px;
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