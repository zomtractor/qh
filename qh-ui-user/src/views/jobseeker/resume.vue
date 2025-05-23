<template>
  <div class="message-container">
    
    <div class="top-section">
      <!-- 个人信息部分 -->
      <div class="profile-section">
        <div class="profile-header">
          <div class="avatar">
            <img :src="default_img" alt="用户头像">
          </div>
          <div class="info">
            <h2>{{ userInfo.name }}</h2>
            <div class="basic-info">
              <p>学历：{{ userInfo.education }}</p>
              <p>年龄：{{ userInfo.age }}</p>
              <p>性别：{{ userInfo.gender }}</p>
              <p>电话：{{ userInfo.phone }}</p>
              <p>{{ userInfo.school }} </p>
              <p>期望：{{ userInfo.jobIntention }} </p>
            </div>
          </div>
          <el-button type="primary" size="small" @click="handleEdit">编辑</el-button>
        </div>
      </div>

      <!-- 附件管理部分 -->
      <div class="attachment-section">
        <div class="section-header">
          <h3>附件管理</h3>
          <el-upload
            class="upload-btn"
            action="/api/upload"
            :show-file-list="false"
            :on-success="handleUploadSuccess"
            :before-upload="beforeUpload"
          >
            <el-button type="primary" size="small">
              <i class="el-icon-upload"></i>
              上传文件
            </el-button>
          </el-upload>
        </div>
        <div class="attachment-list">
          <div v-for="(file, index) in attachments" :key="index" class="attachment-item">
            <i class="el-icon-document"></i>
            <span>{{ file.name }}</span>
            <span class="file-time">{{ file.time }}</span>
          </div>
        </div>
      </div>
    </div>

    <!-- 职位列表部分 -->
    <div class="job-list">
      <div class="filter-tabs">
        <el-tabs v-model="activeTab"  @tab-click="handleTabClick">
          <el-tab-pane label="已通过" name="passed" value="已通过"></el-tab-pane>
          <el-tab-pane label="已投递" name="delivered" value="已投递"></el-tab-pane>
          <el-tab-pane label="感兴趣" name="interested" value="感兴趣"></el-tab-pane>
          <el-tab-pane label="面试" name="interview" value="面试"></el-tab-pane>
        </el-tabs>
      </div>
      
      <div class="job-items">
        <div v-for="(job, index) in jobList" :key="index" class="job-item">
          <div class="job-header">
            <h3>{{ job.jobName }}</h3>
            <div class="job-meta">
              <span>薪资：{{ job.salaryDesc }}</span>
              <span>地点：{{ job.location }}</span>
            </div>
          </div>
          <div class="job-content">
            <div class="responsibilities">
              <p >{{ job.requirement }}</p>
            </div>
          </div>
          <div class="company-info">
            <img :src="default_img" alt="公司logo">
            <div class="company-meta">
              <!-- <span>{{ job.companyName }}</span> -->
              <!-- <span>人数：{{ job.employeeCount }}+</span> -->
              <span>{{ job.etpId }}</span>
              <span>人数：999+</span>
            </div>
          </div>

          <div class="goutong">
            <el-button type="success" size="small" @click="handleChat(job)">继续沟通</el-button>
          </div>
          
        </div>
        
      </div>
      
      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          background
          layout="prev, pager, next"
          :total="totalPages"
          :current-page.sync="currentPage"
          @current-change="handlePageChange">
        </el-pagination>
      </div>

      


    </div>
    <el-dialog
      title="沟通详情"
      :visible.sync="dialogVisible"
      width="30%">
      <div class="chat-content" v-if="currentJob">
        <h4>{{ currentJob.title }}</h4>
        <p>公司：{{ currentJob.companyName }}</p>
        <div class="chat-input">
          <el-input
            type="textarea"
            :rows="4"
            placeholder="请输入沟通内容"
            v-model="chatMessage">
          </el-input>
        </div>
      </div>
      <span slot="footer" class="dialog-footer">
        <el-button @click="dialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="sendMessage">发 送</el-button>
      </span>
    </el-dialog>

    <el-dialog
      title="编辑个人信息"
      :visible.sync="editDialogVisible"
      width="40%">
      <el-form :model="editForm" :rules="rules" ref="editForm" label-width="100px">
        <el-form-item label="昵称" prop="name">
          <el-input v-model="editForm.name"></el-input>
        </el-form-item>
        <el-form-item label="学历" prop="education">
          <el-select v-model="editForm.education" placeholder="请选择学历">
            <el-option label="专科" value="专科"></el-option>
            <el-option label="本科" value="本科"></el-option>
            <el-option label="硕士" value="硕士"></el-option>
            <el-option label="博士" value="博士"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item label="年龄" prop="age">
          <el-input-number v-model="editForm.age" :min="18" :max="100"></el-input-number>
        </el-form-item>
        <el-form-item label="学校" prop="school">
          <el-input v-model="editForm.school"></el-input>
        </el-form-item>
        <el-form-item label="期望职位" prop="jobIntention">
          <el-input v-model="editForm.jobIntention"></el-input>
        </el-form-item>
        <el-form-item label="电话" prop="phone">
          <el-input v-model="editForm.phone"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="editDialogVisible = false">取 消</el-button>
        <el-button type="primary" @click="submitForm('editForm')">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>



import { getUserInfo, updateUserInfo,getInterviewInfo} from '@/api/jobseeker/resume'
import { getCurrentUser} from '@/utils/local'
import { search, confirmFilters,submitResume, navigateToHome } from '@/api/home/home'


export default {
  name: 'Message',
  data() {
    return {
      default_img: require('@/assets/default-avatar.jpg'),
      activeTab: '已通过',
      userInfo: {
        id:1,
        avatar: require('@/assets/default-avatar.jpg'),
        name: '昵称',
        education: '硕士',
        age: 25,
        school: '福州大学',
        major: '软件工程',
        gender:'男',
        jobIntention: '后端开发',
        phone:"1232324",
        email:''
        
      },
      attachments: [
        { name: '简历1.pdf', time: '2025.4.20 18：35' },
        { name: '简历2.pdf', time: '2025.4.20 18：35' },
        { name: '简历3.pdf', time: '2025.4.20 18：35' }
      ],
      activeTab: 'passed',
      jobList: [
        {
          name: 'Python开发工程师',
          salaryDesc: '7k-8k',
          location: '福州',
          requirement: [
            '负责集团相关工具框架建设及维护',
            '负责公司内容标准化开发测试环境搭建及维护',
            '负责游戏运营相关大数据分析工具及后台支撑'
          ],
          companyName: '测试公司',
          companyLogo: require('@/assets/default-avatar.jpg'),
          employeeCount: '9999'
        }
      ],
      currentPage: 1,
      totalPages: 68,
      dialogVisible: false,
      currentJob: null,
      chatMessage: '',
      editDialogVisible: false,
      editForm: {
        gender: 'male',
        name: '',
        education: '',
        age: 18,
        school: '',
        major: '',
        jobIntention: '',
        salary: '',
        userId:getCurrentUser().id,
        email: '',
      },
      rules: {
        name: [
          { required: true, message: '请输入昵称', trigger: 'blur' },
          { min: 2, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur' }
        ],
        education: [
          { required: true, message: '请选择学历', trigger: 'change' }
        ],
        age: [
          { required: true, message: '请输入年龄', trigger: 'blur' }
        ],
        school: [
          { required: true, message: '请输入学校名称', trigger: 'blur' }
        ],
        // major: [
        //   { required: true, message: '请输入专业', trigger: 'blur' }
        // ],
        jobIntention: [
          { required: true, message: '请输入期望职位', trigger: 'blur' }
        ],
        phone: [
          { required: true, message: '请输入电话', trigger: 'blur' }
        ]
      }
    }
  },
  created() {
    // userInfo = getUserInfo(userId)
    this.getuserInfo()
    this.getinterviewInfo()
    console.log(11111)
    console.log(this.jobList)
    // this.userInfo.avatar = "../assets/default-avatar.jpg"
  
  },
  methods: {
    handleTabClick(){
      this.getinterviewInfo()
    },
    async getuserInfo() {
      try {

        const res = await getUserInfo(getCurrentUser().id)
        this.userInfo = res.data
        
      } catch (error) {
        this.$message.error('失败')
        console.error('失败:', error)
      }
    },


    async getinterviewInfo() {
      let interview = {
          userId: getCurrentUser().id,
          interviewStatus: this.activeTab
      }
      try {
        
        const res = await getInterviewInfo(interview)
        console.log(res.data)
        this.jobList = res.data
        
      } catch (error) {
        this.$message.error('失败')
        console.error('失败:', error)
      }
    },

    handleUploadSuccess(res, file) {
      // 上传成功后将文件添加到附件列表
      this.attachments.push({
        name: file.name,
        time: new Date().toLocaleString('zh-CN', {
          year: 'numeric',
          month: '2-digit',
          day: '2-digit',
          hour: '2-digit',
          minute: '2-digit'
        }).replace(/\//g, '.')
      });
    },
    beforeUpload(file) {
      // 上传前的文件验证
      const isPDF = file.type === 'application/pdf';
      const isLt5M = file.size / 1024 / 1024 < 5;

      if (!isPDF) {
        this.$message.error('上传文件只能是 PDF 格式!');
      }
      if (!isLt5M) {
        this.$message.error('上传文件大小不能超过 5MB!');
      }
      return isPDF && isLt5M;
    },
    handleChat(job) {
      console.log("111111")
      this.currentJob = job;
      this.dialogVisible = true;
      this.chatMessage = '';
    },
    
    sendMessage() {
      if (!this.chatMessage.trim()) {
        this.$message.warning('请输入沟通内容');
        return;
      }
      // 这里添加发送消息的逻辑
      console.log('发送消息:', this.chatMessage);
      this.dialogVisible = false;
      this.$message.success('发送成功');
    },
    handleEdit() {
      this.editForm = { ...this.userInfo };  // 复制当前用户信息到表单
      this.editDialogVisible = true;
    },
    submitForm(formName) {
      this.$refs[formName].validate((valid) => {
        if (valid) {
          // 这里添加提交表单的逻辑
          
          this.editForm.userId = getCurrentUser().id,
          this.editForm.email = this.userInfo.email
          this.editForm.gender = this.userInfo.gender
          updateUserInfo(this.editForm )
          this.userInfo = { ...this.editForm };  // 更新用户信息
          this.editDialogVisible = false;
          this.$message.success('保存成功');
        } else {
          return false;
        }
      });
    }
  }
  


}
</script>

<style scoped>
.message-container {
  padding: 20px;
  max-width: calc(100% - 200px);  /* 设置最大宽度，左右各减去100px */
  margin: 0 auto;  /* 居中显示 */
}

.dialog-footer {
  text-align: right;
  margin-top: 20px;
}

.el-form-item {
  margin-bottom: 20px;
}
.chat-content {
  padding: 20px;
}

.chat-content h4 {
  margin: 0 0 15px 0;
  color: #333;
}

.chat-content p {
  color: #666;
  margin-bottom: 20px;
}

.chat-input {
  margin-top: 20px;
}

.top-section {
  display: flex;
  gap: 20px;
  margin-bottom: 20px;
}

.profile-section {
  background: #fff;
  border-radius: 8px;
  padding: 20px;
  flex: 1;
  width: 50%;
  box-sizing: border-box;
}

.attachment-section {
  background: #fff;
  border-radius: 8px;
  padding: 20px;
  flex: 1;
  width: 50%;
  box-sizing: border-box;
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1);
}

.profile-header {
  display: flex;
  align-items: flex-start;
}

.avatar {
  flex-shrink: 0;
}

.avatar img {
  width: 100px;
  height: 100px;
  border-radius: 50%;
  margin-right: 20px;
}

.info {
  flex: 1;
  padding-left: 20px;
}

.info h2 {
  margin: 0 0 10px 0;
  text-align: left;
}

.basic-info {
  text-align: left;
}

.basic-info p {
  margin: 5px 0;
  color: #666;
}

.info {
  width: 100%;
}

.info h2 {
  margin: 0 0 10px 0;
  text-align: left;
}

.basic-info {
  text-align: left;
  width: 100%;
}

.basic-info p {
  margin: 5px 0;
  color: #666;
  text-align: left;
}

.section-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 20px;
}

.attachment-item {
  display: flex;
  align-items: center;
  padding: 10px;
  border-bottom: 1px solid #eee;
}


.attachment-item:hover {
  background-color: #f5f7fa; /* Element UI 主题色中的浅灰色 */
  border-radius: 4px;
  transform: translateY(-1px); /* 轻微上移效果 */
  box-shadow: 0 2px 12px 0 rgba(0, 0, 0, 0.1); /* 添加阴影 */
}


.file-time {
  margin-left: auto;
  color: #999;
}

/* 移除重复的样式定义 */
/* .attachment-section {
  background: #fff;
  border-radius: 8px;
  padding: 20px;
  margin-bottom: 20px;
} */

.job-list {
  background: #fff;
  border-radius: 8px;
  padding: 20px;
}

.job-item {
  border: 1px solid #eee;
  border-radius: 4px;
  padding: 15px;
  margin-bottom: 15px;
  display: flex;
  align-items: flex-start;
  gap: 50px;  /* 将间距从20px减小到10px */
}


.job-header {
  width: 200px;
  min-width: 200px;
}

.job-header h3 {
  margin: 0;
  text-align: left;
  font-size: 18px;
  color: #333;
}

.job-content {
  flex: 2;
  border: 1px solid #eee;
  border-radius: 4px;
  padding: 15px;
  box-shadow: 0 2px 8px rgba(0, 0, 0, 0.1);
  text-align: left;  /* 添加这行确保内容左对齐 */
}

.responsibilities {
  margin: 0;
  text-align: left;  /* 添加这行确保内容左对齐 */
}

.responsibilities p {
  margin: 5px 0;
  color: #666;
  text-align: left;  /* 添加这行确保内容左对齐 */
}








.company-info {
  display: flex;
  align-items: center;
  margin-top: 15px;
  padding-top: 15px;
}

.company-info img {
  width: 70px;
  height: 70px;
  border-radius: 50%;
  margin-right: 10px;
}

.company-meta {
  flex: 1;
  display: flex;
  flex-direction: column;
  justify-content: center;
}



.job-meta {
  display: flex;
  gap: 20px;
  text-align: right;
  flex-direction: column;
  margin-right: 55px;
  margin-top: 20px;
}

.job-meta span {
  color: #666;
  text-align: right;
}

.company-meta span {
  display: block;
  margin-bottom: 5px;
  color: #666;
  text-align: left;
}

.goutong {
  display: flex;
  align-items: center;
  margin-top: 30px;
  padding-top: 15px;
}


.pagination {
  text-align: center;
  margin-top: 20px;
}
</style>
