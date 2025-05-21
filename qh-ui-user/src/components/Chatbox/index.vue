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
          <image-preview :src="contact.avatar" size="small" class="avatar" />
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
            :class="['message-item', msg.posterId === currentUser.id ? 'sent' : 'received']"
        >
          <div class="bubble">
            <template v-if="msg.contentType === 'text'">
              {{ msg.content }}
            </template>
            <template v-else-if="msg.contentType === 'image'">
              <image-preview :src="msg.content" class="msg-image" />
            </template>
            <template v-else-if="msg.contentType === 'file'">
              <el-button
                  size="mini"
                  type="text"
                  icon="el-icon-download"
                  @click="handleDownload(msg.content)"
              >下载附件</el-button>
            </template>
          </div>
        </div>
      </div>
      <!-- 输入区域 -->
      <div class="input-area">
        <el-input
            type="textarea"
            v-model="input.text"
            placeholder="输入消息..."
            rows="2"
        />
        <div class="input-actions">
          <el-popover
              placement="top-start"
              width="200"
              trigger="hover"
          >
            <image-upload :limit="1" v-model="input.image" @on-success="uploadImg" />
            <el-button slot="reference" icon="el-icon-picture" circle />
          </el-popover>
          <el-popover
              placement="top-start"
              width="200"
              trigger="hover"
          >
            <file-upload :limit="1" v-model="input.file" @on-success="uploadFile" />
            <el-button slot="reference" icon="el-icon-paperclip" circle/>
          </el-popover>
          <el-button type="primary" @click="sendText">发送</el-button>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
import {getCurrentUser} from "@/utils/local";
import {listChats, listContact, postMsg} from "@/api/jobseeker/communicate";
import {download} from "@/utils/request";
export default {
  name: "Chatbox",
  data() {
    return {
      currentUser: {
        id: -1,
        name: "当前用户",
      },
      input: {
        text: "",
        image: '',
        file: '',
      },
      contacts: [
        {
          id: 1,
          name: "张三",
          avatar: "https://via.placeholder.com/40",
        },
        {
          id: 2,
          name: "李四",
          avatar: "https://via.placeholder.com/40",
        },
        {
          id: 3,
          name: "王五",
          avatar: "https://via.placeholder.com/40",
        },
        {
          id: 4,
          name: "赵六",
          avatar: "https://via.placeholder.com/40",
        }
      ],
      activeContactId: 1,
      messages: [
        {
          id: 1,
          posterId: 1,
          receiverId: this.activeContactId,
          content: "你好，请问贵公司目前在招聘吗？",
          contentType: "text",
        },
        {
          id: 2,
          posterId: this.activeContactId,
          receiverId: 1,
          content: "在的，欢迎投递简历",
          contentType: "text",
        },
      ],
    };
  },
  methods: {
    fetchContacts() {
      listContact().then(resp=>{
        if (resp.code === 200) {
          this.contacts = resp.rows;
          if(this.contacts.length>0) {
            this.activeContactId = this.contacts[0].id;
            this.fetchMessages(this.activeContactId);
          }
          console.log(this.contacts)
        } else {
          this.$message.error(resp.msg);
        }
      }).catch(err=>{
        this.$message.error(err);
      })
    },

    fetchMessages(refId) {
      listChats(refId).then(resp=>{
        if (resp.code === 200) {
          this.messages = resp.rows;
        } else {
          this.$message.error(resp.msg);
        }
      }).catch(err=>{
        this.$message.error(err);
      })
    },
    handleSelect(contactId) {
      this.fetchMessages(contactId);
    },

    handleFileUpload(response) {
      this.sendMedia(response.url, "file");
    },

    sendMedia(url, type) {
      const newMessage = {
        posterId: this.currentUser.id,
        receiverId: this.activeContactId,
        previousId: this.messages.length > 0 ? this.messages[this.messages.length - 1].id : -1,
        content: url,
        contentType: type,
      };
      postMsg(newMessage).then(resp=>{
        if (resp.code === 200) {
          this.$message.success("发送成功");
          this.messages.push(newMessage);
        } else {
          this.$message.error(resp.msg);
        }
      }).catch(err=>{
        this.$message.error(err);
      })
    },
    sendText() {
      this.sendMedia(this.input.text, "text");
    },
    uploadImg(){
      this.sendMedia(this.input.image, "image");
    },
    uploadFile(){
      this.sendMedia(this.input.file, "file");
    },
    handleDownload(url) {
      var name = url.substring(url.lastIndexOf("/") + 1, url.length);
      // var suffix = url.substring(url.lastIndexOf("."), url.length);
      // var name = url.substring(url.lastIndexOf("/") + 1, url.length - suffix.length);
      const a = document.createElement('a')
      a.setAttribute('download', name)
      a.setAttribute('target', '_blank')
      a.setAttribute('href', '/dev-api'+url)
      a.setAttribute('content-type', 'application/octet-stream')
      a.style.display = 'none'
      a.click()
    }
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
  width: 40px;
  height: 40px;
}
.contact-name {
  vertical-align: middle;
}
.hyper-link {
  color: #409eff;
  text-decoration: none;
}
</style>
