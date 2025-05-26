<template>
  <div class="recommend-container">
    <!-- 筛选条件 -->
    <div class="filter-section">
      <div class="filter-tags">
        <el-radio-group v-model="queryParams.priority" @change="handlePriorityChange">
          <el-radio label="skill">优先技能</el-radio>
          <el-radio label="hot">优先热度</el-radio>
          <el-radio label="welfare">优先福利</el-radio>
        </el-radio-group>
      </div>
      <div class="filter-selects">
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
        <el-button type="primary" @click="handleFilter">筛选</el-button>
      </div>
    </div>

    <!-- 职位卡片 -->
    <div class="job-list">
      <div class="job-card" v-for="(item, index) in jobs.slice(0,20)" :key="index">
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
          <el-button type="primary" @click="handleCommunicate(item.userJob.id)">沟通</el-button>
          <el-button type="success" @click="handleSubmitResume(item.userJob.id)">投递简历</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import { getRecommendJobs, communicateWithRecruiter, submitResumeToJob } from '@/api/recommend/recommend'
import { listCategory } from "@/api/etp/category";
import { listTag } from "@/api/etp/tag";
import {contact} from "@/api/jobseeker/communicate";

export default {
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
      currentPage: 1,
      pageSize: 8,
      total: 0,
      jobs: [],
      categoryList: [],
      tagList: [],
      queryCategoryList: [],
      queryTagList: [],
      salaryRange: null,
      queryParams: {
        page: null,
        pageSize: null,
        priority: 'skill',
        keywords: null,
        categoryIds: null,
        tagIds: null,
        salaryLowerBound: null,
        salaryUpperBound: null,
        location: null,
      },
    }
  },
  methods: {
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
    // 获取职位列表数据
    async fetchJobs() {
      try {
        if (this.salaryRange != null) {
          this.queryParams.salaryLowerBound = this.salaryRange.split(',')[0];
          this.queryParams.salaryUpperBound = this.salaryRange.split(',')[1];
        }
        this.queryParams.categoryIds = this.queryCategoryList.join(",");
        this.queryParams.tagIds = this.queryTagList.join(",");
        const res = await getRecommendJobs(this.queryParams)
        this.jobs = res.data;
        this.total = res.total;
      } catch (error) {
        this.$message.error('获取职位列表失败')
        console.error('获取职位列表失败:', error)
      }
    },
    // 处理优先条件变化
    async handlePriorityChange() {
      await this.fetchJobs()
      this.$message.success(`已切换到${this.getPriorityText()}推荐模式`)
    },
    // 获取优先条件文本
    getPriorityText() {
      const priorityMap = {
        skill: '优先技能',
        hot: '优先热度',
        welfare: '优先福利'
      }
      return priorityMap[this.queryParams.priority] || ''
    },
    // 处理筛选条件
    async handleFilter() {
      this.queryParams.page = 1
      await this.fetchJobs()
    },
    // 处理沟通请求
/*    async communicate(job) {
      try {
        await communicateWithRecruiter({jobId: job.id})
        this.$message.success('已发起沟通请求')
        // 这里可以添加跳转到聊天页面的逻辑
        this.$router.push({
          path: '/chat',
          query: {jobId: job.id}
        })
      } catch (error) {
        this.$message.error('发起沟通失败')
        console.error('发起沟通失败:', error)
      }
    },
    // 处理简历投递
    async submitResume(job) {
      try {
        await submitResumeToJob({jobId: job.id})
        this.$message.success('简历投递成功')
      } catch (error) {
        this.$message.error('简历投递失败')
        console.error('简历投递失败:', error)
      }
    }*/
    handleCommunicate(id) {
      contact(id).then(resp=>{
        if(resp.code === 200) {
          this.$message.success('沟通请求已发送');
          // setTimeout(()=>{
          //   this.$router.push({path: '/communicate'});
          // },1000)
        } else {
          this.$message.error(resp.msg);
        }
      })
    },
    // 投递简历
    handleSubmitResume(id) {
      contact(id).then(resp=>{
        if(resp.code === 200) {
          this.$message.success('沟通请求已发送');
          // setTimeout(()=>{
          //   this.$router.push({path: '/communicate'});
          // },1000)
        } else {
          this.$message.error(resp.msg);
        }
      })
    }
  },
  created() {
    this.fetchJobs()
  }
};
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
