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
            <el-menu-item index="Home">首页</el-menu-item>
            <el-menu-item index="Recommend">推荐</el-menu-item>
            <el-menu-item index="Message">消息</el-menu-item>
            <el-menu-item index="Resume">简历</el-menu-item>
          </el-menu>
        </div>
        <div class="nav-right">
          <el-input
              placeholder="搜公司、职位"
              prefix-icon="el-icon-search"
              class="nav-search"
              v-model="searchText"
              clearable
          />
          <div class="user-info">
            <span class="user-name">昵称</span>
            <el-avatar :size="32" src="https://img.icons8.com/color/48/user.png" />
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

export default {
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
</style>
