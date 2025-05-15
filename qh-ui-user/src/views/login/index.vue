<template>
  <div class="login-container">
    <div class="form-panel">
      <el-tabs v-model="activeRole" @tab-click="onRoleChange">
        <el-tab-pane label="我是求职者" name="job_seeker"></el-tab-pane>
        <el-tab-pane label="我是招聘员" name="enterprise"></el-tab-pane>
      </el-tabs>
      <el-form :model="loginForm" :rules="rules" ref="loginFormRef">
        <template v-if="activeRole === 'job_seeker'">
          <div class="form-header">
            <span class="login-mode-switch" @click="switchLoginMode">{{ emailLogin ? '用户名登录' : '邮箱登录' }}</span>
          </div>
          <el-form-item prop="username">
            <el-input v-model="loginForm.username" :placeholder="emailLogin ? '请输入邮箱' : '请输入用户名'" />
          </el-form-item>
        </template>
        <template v-else>
          <el-form-item prop="phone">
            <el-input v-model="loginForm.phone" placeholder="请输入手机号" />
          </el-form-item>
        </template>

        <el-form-item prop="password">
          <el-input v-model="loginForm.password" type="password" placeholder="请输入密码" />
        </el-form-item>

        <el-form-item prop="code">
          <el-row :gutter="20">
            <el-col :span="14">
              <el-input v-model="loginForm.code" placeholder="请输入验证码" />
            </el-col>
            <el-col :span="10">
              <VerifyCodeImg @click="getCode" :src="codeUrl" />
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
import { login } from '@/api/login'
import { setToken } from '@/utils/auth'

export default {
  name: 'Login',
  data() {
    return {
      activeRole: 'job_seeker',
      emailLogin: false,
      loginForm: {
        username: '',
        phone: '',
        password: '',
        code: '',
        uuid: ''
      },
      codeUrl: '',
      rules: {
        username: [{ required: true, message: '请输入用户名或邮箱', trigger: 'blur' }],
        phone: [{ required: true, message: '请输入手机号', trigger: 'blur' }],
        password: [{ required: true, message: '请输入密码', trigger: 'blur' }],
        code: [{ required: true, message: '请输入验证码', trigger: 'blur' }]
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
      this.codeUrl = `/captchaImage?uuid=${(this.loginForm.uuid = this.$uuid())}`
    },
    handleLogin() {
      this.$refs.loginFormRef.validate(valid => {
        if (!valid) return
        const loginData = {
          role: this.activeRole,
          ...this.loginForm
        }
        login(loginData).then(res => {
          setToken(res.token)
          this.$router.push(this.activeRole === 'job_seeker' ? '/home' : '/enterprise')
        })
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
</style>
