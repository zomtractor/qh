<template>
  <div id="app">
    <el-container>
      <el-header class="nav-bar">
        <div class="nav-left">
          <div class="logo" @click="changeMenu('Home')"></div>
          <el-menu
              class="nav-menu"
              mode="horizontal"
              :default-active="activeMenu"
              background-color="#4A4A4A"
              text-color="#fff"
              active-text-color="#ffd04b"
              @select="changeMenu"
          >
            <el-menu-item index="Home" class="full-width-menu-item">
              <el-button type="primary" class="full-width-button" @click="handleNavigateToHome">首页</el-button>
            </el-menu-item>
            <el-menu-item index="Recommend">推荐</el-menu-item>
            <el-menu-item index="Message">消息</el-menu-item>
            <el-menu-item index="Resume">简历</el-menu-item>
          </el-menu>
        </div>
        <div class="nav-right">
          <el-dropdown @command="handleCommand">
                      <div class="user-info">
                        <span class="user-name">昵称</span>
                        <el-avatar :size="32" src="https://img.icons8.com/color/48/user.png" />
                        <i class="el-icon-arrow-down el-icon--right"></i>
                      </div>
                      <el-dropdown-menu slot="dropdown">
                        <el-dropdown-item command="logout">退出</el-dropdown-item>
                      </el-dropdown-menu>
                    </el-dropdown>
        </div>
      </el-header>

      <el-main>
        <component :is="currentComponent" />
      </el-main>
    </el-container>
  </div>
</template>

<script>
import Home from "./home.vue";
import Recommend from "./recommend.vue";
import Message from "./message.vue";
import Resume from "./resume.vue";
import { navigateToHome } from '@/api/home/home'; // 导入首页请求方法

export default {
  name: 'JobSeeker',
  data() {
    return {
      activeMenu: "Home",
      searchText: "",
      componentsMap: {
        Home,
        Recommend,
        Message,
        Resume,
      },
    };
  },
  computed: {
    currentComponent() {
      return this.componentsMap[this.activeMenu];
    },
  },
  methods: {
    changeMenu(index) {
      this.activeMenu = index;
    },
    handleNavigateToHome() {
      this.changeMenu('Home'); // 切换到首页
      navigateToHome(); // 发送首页数据请求
    },
    handleCommand(command) {
          if (command === 'logout') {
            // 处理退出逻辑
            this.$router.push('/login');
          }
    }
  },
};
</script>

<style scoped>
.nav-bar {
  background-color: #4a4a4a;
  color: white;
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 0 30px;
  height: 60px;
}

.nav-left {
  display: flex;
  align-items: center;
}

.logo {
  font-size: 18px;
  color: white;
  margin-right: 20px;
  cursor: pointer;
}

.nav-menu {
  border-bottom: none;
}

.nav-right {
  display: flex;
  align-items: center;
}

.nav-search {
  width: 200px;
  margin-right: 20px;
}

.user-info {
  display: flex;
  align-items: center;
  gap: 8px;
  color: white;
}

.full-width-menu-item {
  padding: 0; /* 移除内边距 */
}

.full-width-button {
  width: 100%; /* 按钮宽度占满父容器 */
  height: 100%; /* 按钮高度占满父容器 */
  border-radius: 0; /* 移除圆角 */
  background-color: transparent; /* 背景透明 */
  border: none; /* 移除边框 */
  color: #fff; /* 文字颜色与菜单项一致 */
  font-size: 14px; /* 字体大小与菜单项一致 */
  padding: 0 20px; /* 内边距与菜单项一致 */
  text-align: left; /* 文字左对齐 */
}

.full-width-button:hover {
  background-color: rgba(255, 255, 255, 0.1); /* 鼠标悬停背景色 */
}

.full-width-button:focus {
  outline: none; /* 移除焦点边框 */
}

</style>
