<template>
  <div class="login-container">
    <div class="form-panel">
      <el-tabs v-model="activeRole" @tab-click="onRoleChange">
        <el-tab-pane label="我是求职者" name="job_seeker"></el-tab-pane>
        <el-tab-pane label="我是招聘员" name="enterprise"></el-tab-pane>
      </el-tabs>
      <el-form :model="loginForm" :rules="rules" ref="loginFormRef">
        <div class="form-header">
            <span class="login-mode-switch" @click="switchLoginMode">
              <a href="email">邮箱登录</a>
            </span>
        </div>
        <el-form-item prop="username">
          <el-input v-model="loginForm.username" placeholder="请输入用户名/手机号/邮箱"/>
        </el-form-item>
        <el-form-item prop="password">
          <el-input v-model="loginForm.password" type="password" placeholder="请输入密码"/>
        </el-form-item>

        <el-form-item prop="code">
          <el-row :gutter="20">
            <el-col :span="14">
              <el-input v-model="loginForm.code" placeholder="请输入验证码"/>
            </el-col>
            <el-col :span="10">
              <img :src="codeUrl" @click="getCode" class="login-code-img"/>
            </el-col>
          </el-row>
        </el-form-item>

        <el-form-item>
          <el-button type="primary" @click="handleLogin">登录</el-button>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import {getCodeImg, login} from '@/api/login'
import {setToken} from '@/utils/auth'

export default {
  name: 'Login',
  data() {
    return {
      activeRole: 'job_seeker',
      emailLogin: false,
      captchaEnabled: false,
      loginForm: {
        username: '',
        password: '',
        code: '',
        uuid: '',
        verifyCode: '',
        role: 'job_seeker'
      },
      codeUrl: '',
      rules: {
        username: [{required: true, message: '请输入用户名或邮箱', trigger: 'blur'}],
        phone: [{required: true, message: '请输入手机号', trigger: 'blur'}],
        password: [{required: true, message: '请输入密码', trigger: 'blur'}],
        code: [{required: true, message: '请输入验证码', trigger: 'blur'}]
      }
    }
  },
  created() {
    this.getCode()
  },
  methods: {
    switchLoginMode() {
      this.emailLogin = !this.emailLogin
      this.loginForm.username = ''
    },
    onRoleChange(tab) {
      this.loginForm.username = ''
      this.loginForm.phone = ''
      this.loginForm.password = ''
      this.loginForm.code = ''
      this.getCode()
    },
    getCode() {
      getCodeImg().then(res => {
        this.captchaEnabled = res.captchaEnabled === undefined ? true : res.captchaEnabled;
        if (this.captchaEnabled) {
          this.codeUrl = "data:image/gif;base64," + res.img;
          this.loginForm.uuid = res.uuid;
        }
      });
    },
    handleLogin() {
      this.$refs.loginFormRef.validate(valid => {
        if (valid) {
          this.loading = true;
          this.loginForm.role = this.activeRole;
          login(this.loginForm).then(resp => {
            console.log(resp)
            if (resp.code === 200) {
              setToken(resp.data)
              this.$router.push(this.activeRole === 'job_seeker' ? '/jobSeeker' : '/enterprise')
            }
          }).catch(() => {
            this.loading = false;
            if (this.captchaEnabled) {
              this.getCode();
            }
          });
        }
      })
    }
  }
}
</script>

<style scoped>
.login-container {
  display: flex;
  justify-content: center;
  align-items: center;
  height: 100vh;
  background: #f5f5f5;
}

.form-panel {
  width: 400px;
  padding: 30px;
  background: white;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
  border-radius: 10px;
}

.form-header {
  text-align: right;
  margin-bottom: 10px;
}

.login-mode-switch {
  color: #409EFF;
  cursor: pointer;
}

.login-code {
  width: 33%;
  height: 38px;
  float: right;

  img {
    cursor: pointer;
    vertical-align: middle;
  }
}

.login-code-img {
  height: 38px;
}
</style>
