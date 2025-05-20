<template>
  <div class="chat-container">
    <div class="chat-header">
      <div class="user-info">
        <div class="avatar">
          <img src="https://img.icons8.com/color/48/user.png" alt="头像">
        </div>
        <span>HR</span>
      </div>
      <div class="close-btn" @click="goBack">×</div>
    </div>

    <div class="chat-messages">
      <div class="message sent">
        <div class="message-content">
          您好，我对贵公司的职位很感兴趣，可以进一步沟通吗？
        </div>
      </div>
      <div v-for="(msg, index) in messages" :key="index" :class="['message', msg.type]">
         <div class="message-content">{{ msg.content }}</div>
      </div>
    </div>

    <div class="chat-input">
      <div class="input-area">
        <div class="input-icons">
          <i @click="handleIconClick('clip')">📎</i>
          <i @click="handleIconClick('emojis')">💬</i>
          <i @click="handleIconClick('emoji')">😊</i>
          <i @click="handleIconClick('call')">📞</i>
        </div>
        <input type="text" placeholder="按 Enter 键发送" @keyup.enter="sendMessage">
      </div>
    </div>
  </div>
</template>

<script>
export default {
  data() {
    return {
      message: '',
      messages: [] // 添加messages数组存储聊天记录
    }
  },
  methods: {
    handleIconClick(iconType) {
      console.log(`Clicked ${iconType} icon`)
      // 在这里添加图标点击的逻辑
    },
    sendMessage(event) {
      const input = event.target
      const message = input.value.trim()

      if (message) {
        // 将新消息添加到messages数组
                  this.messages.push({
                    type: 'sent', // 消息类型，可以是'sent'或'received'
                    content: message
                  })
        input.value = ''
      }
    },
    goBack() {
            this.$router.push('/jobseeker');
          }
  }
}
</script>

<style scoped>
* {
  margin: 0;
  padding: 0;
  box-sizing: border-box;
  font-family: Arial, sans-serif;
}

body {
  background-color: #f5f5f5;
  height: 100vh;
  display: flex;
  flex-direction: column;
}

.chat-container {
  flex: 1;
  display: flex;
  flex-direction: column;
  height: 100%;
  max-width: 600px;
  margin: 0 auto;
  box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.chat-header {
  background-color: #5d6d7e;
  color: white;
  padding: 10px 15px;
  display: flex;
  align-items: center;
  justify-content: space-between;
}

.user-info {
  display: flex;
  align-items: center;
}

.avatar {
  width: 40px;
  height: 40px;
  border-radius: 50%;
  background-color: #ddd;
  overflow: hidden;
  margin-right: 10px;
}

.avatar img {
  width: 100%;
  height: 100%;
  object-fit: cover;
}

.close-btn {
  font-size: 20px;
  cursor: pointer;
}

.chat-messages {
  flex: 1;
  padding: 15px;
  overflow-y: auto;
  background-color: white;
}

.message {
  margin-bottom: 15px;
  display: flex;
}

.message-content {
  max-width: 80%;
  padding: 10px 15px;
  border-radius: 18px;
  position: relative;
}

.received {
  justify-content: flex-start;
}

.sent {
  justify-content: flex-end;
}

.received .message-content {
  background-color: #f1f1f1;
}

.sent .message-content {
  background-color: #e3f2fd;
}

.chat-input {
  padding: 10px 15px;
  border-top: 1px solid #ddd;
  background-color: white;
}

.input-area {
  display: flex;
  align-items: center;
  border: 1px solid #ddd;
  border-radius: 20px;
  padding: 8px 15px;
  background-color: white;
}

.input-area input {
  flex: 1;
  border: none;
  outline: none;
  margin-left: 10px;
  font-size: 14px;
}

.input-icons {
  display: flex;
  align-items: center;
}

.input-icons i {
  margin-right: 15px;
  cursor: pointer;
  color: #777;
}
</style>