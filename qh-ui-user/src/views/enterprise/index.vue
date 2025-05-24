<template>
  <el-container style="height: 100vh;">
    <!-- 左侧导航 -->
    <el-aside width="260px" class="menu-aside">
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
        <div class="time">{{ currentTime }}</div>
        <span class="user-name">欢迎您，企业用户{{currentUser.name}}</span>
        <div class="user-info">

          <el-dropdown @command="logout">
            <image-preview :src="currentUser.avatar" width="32px" height="32px" />
            <el-dropdown-menu slot="dropdown">
              <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
            </el-dropdown-menu>
          </el-dropdown>
        </div>
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
import {getToken, removeToken} from "@/utils/auth";
import {tokenLogin, tokenLogout} from "@/api/login";
import {setCurrentUser} from "@/utils/local";
export default {
  name: 'Enterprise',
  data() {
    return {
      activeMenu: 'Company',
      currentView: 'Company',
      currentTime: '',
      currentUser: {
        id: "",
        name: "",
        email: "",
        phone: "",
        avatarFileId: "",
        role: "enterprise",
      }
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
    logout(){
      this.$confirm('确定要退出登录吗？', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        this.$message.success('退出成功')
        removeToken()
        setTimeout(()=>{
          window.location.href='/'
        },1000)
      }).catch(() => {
        this.$message.info('取消登出')
      });
    }
  },
  created() {
    this.updateTime();
    this.timer = setInterval(this.updateTime, 1000);
  },
  mounted() {
    tokenLogin(getToken()).then(res => {
      if (res.code !== 200) {
        removeToken()
        this.$message.error(res.msg);
        window.location.href='/'
      }
      console.log(res.data)
      setCurrentUser(res.data)
      this.currentUser = res.data
    }).catch(err => {
      removeToken()
      this.$message.error(err)
      window.location.href='/'
    })
  },
  beforeDestroy() {
    tokenLogout(getToken())
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
  min-height: calc(100vh - 60px);
  box-sizing: border-box;
  font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 8px;
  color: white;
}
.user-name {
  margin-right: 20px;
  color: #333;
}
</style>