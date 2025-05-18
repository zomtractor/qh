<template>
  <div class="login-container">
  </div>
</template>

<script>
import {getCodeImg, login, tokenLogin} from '@/api/login'
import {setToken} from '@/utils/auth'

export default {
  name: 'Token',
  data() {
    return {
    }
  },
  created() {
    tokenLogin(this.$route.params.token).then(res => {
      if (res.code !== 200) {
        this.$message.error(res.msg);
        return;
      }
      this.$message.success("登录成功")
      setToken(res.data.token)
      this.$router.push({path: '/'})
    }).catch(err => {
      this.$message.error(err)
    })
    window.location.href="../"
  },
  methods: {
  }
}
</script>

<style scoped>
</style>
