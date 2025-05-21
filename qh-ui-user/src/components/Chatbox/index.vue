<template>
  <div class="chatbox">
    <!-- 左侧联系人列表 -->
    <div class="contacts">
      <el-menu :default-active="String(activeContactId)" @select="handleSelect">
        <el-menu-item
            v-for="contact in contacts"
            :key="contact.id"
            :index="String(contact.id)"
        >
          <el-avatar :src="contact.avatar" size="small" class="avatar" />
          <span class="contact-name">{{ contact.name }}</span>
        </el-menu-item>
      </el-menu>
    </div>

    <!-- 右侧聊天窗口 -->
    <div class="chat-window">
      <div class="messages">
        <div
            v-for="msg in messages"
            :key="msg.id"
            :class="['message-item', msg.poster_id === currentUser.id ? 'sent' : 'received']"
        >
          <div class="bubble">
            <template v-if="msg.content_type === 'text'">
              {{ msg.content }}
            </template>
            <template v-else-if="msg.content_type === 'image'">
              <img :src="msg.content" class="msg-image" />
            </template>
            <template v-else-if="msg.content_type === 'file'">
              <a :href="msg.content" target="_blank">下载附件</a>
            </template>
          </div>
        </div>
      </div>

      <!-- 输入区域 -->
      <div class="input-area">
        <el-input
            type="textarea"
            v-model="inputText"
            placeholder="输入消息..."
            rows="2"
        />
        <div class="input-actions">
          <el-upload
              :action="uploadUrl"
              :show-file-list="false"
              :on-success="handleImageUpload"
              accept="image/*"
          >
            <el-button icon="el-icon-picture" circle />
          </el-upload>
          <el-upload
              :action="uploadUrl"
              :show-file-list="false"
              :on-success="handleFileUpload"
          >
            <el-button icon="el-icon-paperclip" circle />
          </el-upload>
          <el-button type="primary" @click="sendText">发送</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {getCurrentUser} from "@/utils/local";

export default {
  name: "Chatbox",
  data() {
    return {
      currentUser: {
        id: -1,
        name: "当前用户",
      },
      contacts: [],
      activeContactId: null,
      messages: [],
      inputText: "",
      uploadUrl: "/api/upload", // 上传接口地址（请替换）
    };
  },
  methods: {
    async fetchContacts() {
      // 模拟请求（实际应调接口）
      if (this.contactType === "Resume") {
        this.contacts = [
          { id: 201, name: "张三", avatar: "https://via.placeholder.com/40" },
          { id: 202, name: "李四", avatar: "https://via.placeholder.com/40" },
        ];
      } else {
        this.contacts = [
          { id: 301, name: "字节跳动", avatar: "https://via.placeholder.com/40" },
          { id: 302, name: "腾讯", avatar: "https://via.placeholder.com/40" },
        ];
      }

      if (this.contacts.length > 0) {
        this.activeContactId = this.contacts[0].id;
        this.fetchMessages();
      }
    },

    fetchMessages() {
      // 模拟聊天记录（实际应请求 /api/communicate/list?poster=...&receiver=...）
      this.messages = [
        {
          id: 1,
          poster_id: this.currentUser.id,
          receiver_id: this.activeContactId,
          content: "你好，请问贵公司目前在招聘吗？",
          content_type: "text",
        },
        {
          id: 2,
          poster_id: this.activeContactId,
          receiver_id: this.currentUser.id,
          content: "在的，欢迎投递简历",
          content_type: "text",
        },
      ];
    },

    sendText() {
      if (!this.inputText.trim()) return;

      const newMessage = {
        id: Date.now(),
        poster_id: this.currentUser.id,
        receiver_id: this.activeContactId,
        content: this.inputText,
        content_type: "text",
      };

      // 模拟插入数据库
      this.messages.push(newMessage);
      this.inputText = "";
    },

    handleSelect(contactId) {
      this.activeContactId = Number(contactId);
      this.fetchMessages();
    },

    handleImageUpload(response) {
      this.sendMedia(response.url, "image");
    },

    handleFileUpload(response) {
      this.sendMedia(response.url, "file");
    },

    sendMedia(url, type) {
      const newMessage = {
        id: Date.now(),
        poster_id: this.currentUser.id,
        receiver_id: this.activeContactId,
        content: url,
        content_type: type,
      };
      this.messages.push(newMessage);
    },
  },
  mounted() {
    this.currentUser = getCurrentUser();
    this.fetchContacts();
  },
};
</script>

<style scoped>
.chatbox {
  display: flex;
  height: 100%;
  background: #f5f5f5;
}

.contacts {
  width: 220px;
  border-right: 1px solid #ccc;
  background: #fff;
}

.chat-window {
  flex: 1;
  display: flex;
  flex-direction: column;
  padding: 10px;
}

.messages {
  flex: 1;
  overflow-y: auto;
  padding-right: 10px;
}

.message-item {
  margin: 10px 0;
  display: flex;
}

.message-item.sent {
  justify-content: flex-end;
}

.message-item.received {
  justify-content: flex-start;
}

.bubble {
  max-width: 60%;
  padding: 8px 12px;
  border-radius: 6px;
  background-color: #e6f7ff;
  word-wrap: break-word;
}

.message-item.sent .bubble {
  background-color: #cce5ff;
}

.input-area {
  border-top: 1px solid #ccc;
  padding-top: 10px;
}

.input-actions {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-top: 5px;
}

.msg-image {
  max-width: 150px;
  border-radius: 4px;
}
.avatar {
  margin-right: 8px;
}
.contact-name {
  vertical-align: middle;
}
</style>
