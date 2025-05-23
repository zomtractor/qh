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
          <div class="user-info">
            <span >{{currentUser.name}}</span>
            <el-dropdown @command="logout">
              <image-preview :src="currentUser.avatar" width="32px" height="32px" />
              <el-dropdown-menu slot="dropdown">
                <el-dropdown-item @click="logout">退出登录</el-dropdown-item>
              </el-dropdown-menu>
            </el-dropdown>
          </div>
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
import {getToken, removeToken} from "@/utils/auth";
import {tokenLogin} from "@/api/login";
import {setCurrentUser} from "@/utils/local";

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
      currentUser: {
        id: "",
        name: "",
        email: "",
        phone: "",
        avatarFileId: "",
        role: "job_seeker",
      }
    };
  },
  computed: {
    currentComponent() {
      return this.componentsMap[this.activeMenu];
    },
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
  methods: {
    changeMenu(index) {
      this.activeMenu = index;
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
    },
    handleNavigateToHome() {
          this.changeMenu('Home'); // 切换到首页
          navigateToHome(); // 发送首页数据请求
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
.el-dropdown-menu {
  min-width: 120px;
  text-align: right; /* 文字右对齐 */
  padding-right: 16px; /* 增加右边距 */
}

.el-dropdown-menu__item {
  display: flex;
  justify-content: flex-end; /* 内容右对齐 */
}
</style>
