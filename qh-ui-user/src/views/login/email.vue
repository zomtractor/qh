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
              <a href=".">用户登录</a>
            </span>
        </div>

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
·
        <el-form-item>
          <el-row :gutter="20">
            <el-col :span="16">
              <el-input prop="emailCode" v-model="loginForm.email" placeholder="请输入邮箱"/>
            </el-col>
            <el-col :span="8">
              <el-button @click="sendEmailCode" >发送</el-button>
            </el-col>
          </el-row>
        </el-form-item>
      </el-form>
    </div>
  </div>
</template>

<script>
import {getCodeImg, sendLoginEmail} from '@/api/login'

export default {
  name: 'Login',
  data() {
    return {
      activeRole: 'job_seeker',
      emailLogin: false,
      captchaEnabled: false,
      loginForm: {
        email: '',
        verifyCode: '',
        code: '',
        uuid: '',
        role: 'job_seeker'
      },
      codeUrl: '',
      rules: {
        emailCode: [{required: true, message: '请输入邮箱', trigger: 'blur'}],
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
      this.loginForm.email = ''
    },
    onRoleChange(tab) {
      this.loginForm.email = ''
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
    sendEmailCode() {
      this.loginForm.role = this.activeRole
      this.$refs.loginFormRef.validate((valid) => {
        if (valid) {
          sendLoginEmail(this.loginForm).then(res => {
            if (res.code !== 200) {
              this.$message.error(res.msg);
              return;
            }
            this.$message.success("登录邮件已发送，请注意查收")
          });

        } else {
          this.$message.error("请输入正确的邮箱")
        }
      });
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
