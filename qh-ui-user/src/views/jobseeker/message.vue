<template>
  <div class="message-container">
    <el-card>
      <Chatbox/>
    </el-card>

  </div>
</template>

<script>

import Chatbox from "@/components/Chatbox/index.vue";

export default {
  name: "Message",
  components: {
    Chatbox,
  },
  data() {
    return {
    };
  },
  computed: {
  },
};
</script>

<style scoped>
.message-container {
  height: 100%;
  padding: 10px;
}
.el-card{
  width: 100%;
  height: 80vh;
}
</style>
