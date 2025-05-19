<template>

</template>
<script>
import {getToken} from "@/utils/auth";

export default {
  name: "index",
  created() {
    let token = getToken().toString()
    if(!token) window.location.href="login/"
    else {
      if(token.startsWith("j")){
        window.location.href="jobSeeker/"
      } else {
        window.location.href="enterprise/"
      }
    }
  }
}
</script>
<style scoped lang="scss">

</style>