<template>
  <el-container style="height: 100vh;">
    <!-- 左侧导航 -->
    <el-aside width="250px" class="menu-aside">
      <div class="logo">
        <i class="el-icon-monitor"></i>
        企业管理后台
      </div>
      <el-menu
          :default-active="activeMenu"
          background-color="#1f1f1f"
          text-color="#fff"
          active-text-color="#409EFF"
          @select="handleMenuSelect"
      >
        <el-menu-item index="Company">
          <i class="el-icon-office-building"></i>
          <span slot="title">公司信息</span>
        </el-menu-item>
        <el-menu-item index="Job">
          <i class="el-icon-office-building"></i>
          <span slot="title">岗位管理</span>
        </el-menu-item>
        <el-menu-item index="Communicate">
          <i class="el-icon-office-building"></i>
          <span slot="title"> 人员沟通</span>
        </el-menu-item>

        <el-menu-item index="Interview">
          <i class="el-icon-chat-dot-square"></i>
          <span slot="title">面试管理</span>
        </el-menu-item>
      </el-menu>
    </el-aside>

    <!-- 右侧内容区域 -->
    <el-container>
      <!-- 顶部栏 -->
      <el-header class="top-bar">
        <div>{{ currentTime }}</div>
        <div>&nbsp;xxx，欢迎您</div>
      </el-header>

      <!-- 主体内容 -->
      <el-main class="main-content">
        <component :is="currentView" />
      </el-main>
    </el-container>
  </el-container>
</template>

<script>
// 导入页面组件
import Company from './company.vue';
import Job from './job.vue';
import Interview from './interview.vue';
import Communicate from './communicate.vue';
export default {
  name: 'Enterprise',
  data() {
    return {
      activeMenu: 'Company',
      currentView: 'Company',
      currentTime: ''
    };
  },
  components: {
    Company,
    Job,
    Communicate,
    Interview
  },
  methods: {
    handleMenuSelect(index) {
      this.activeMenu = index;
      this.currentView = index;
    },
    updateTime() {
      const now = new Date();
      this.currentTime = now.toLocaleString('zh-CN', { hour12: false });
    },
  },
  created() {
    this.updateTime();
    this.timer = setInterval(this.updateTime, 1000);
  }
};
</script>

<style scoped>
/* 左侧导航 */
.menu-aside {
  background-color: #1f1f1f;
  color: white;
  display: flex;
  flex-direction: column;
}

.logo {
  font-size: 16px;
  padding: 20px;
  color: white;
  display: flex;
  align-items: center;
  font-weight: bold;
  border-bottom: 1px solid #2c2c2c;
}

.logo i {
  margin-right: 8px;
}

/* 顶部栏 */
.top-bar {
  background-color: #ffffff;
  display: flex;
  justify-content: flex-end;
  align-items: center;
  height: 60px;
  padding: 0 20px;
  font-size: 14px;
  border-bottom: 1px solid #e0e0e0;
}

.time {
  margin-right: 40px;
  color: #666;
}

.user {
  color: #333;
  font-weight: 500;
}

/* 主内容区域 */
.main-content {
  background-color: #f4f6f8;
  padding: 40px;
  display: flex;
  justify-content: center;
  align-items: center;
  min-height: calc(100vh - 60px);
  box-sizing: border-box;
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}
</style>