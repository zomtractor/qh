<template>
  <div class="message-container">
    
    <div class="top-section">
      <!-- 个人信息部分 -->
      <div class="profile-section">
        <div class="profile-header">
          <div class="avatar">
            <image-preview :src="userInfo.avatarFileId || default_img" alt="用户头像" :width="100" :height="100" />
            <!-- <img :src="userInfo.avatarFileId || default_img" alt="用户头像"> -->
          </div>
          <div class="info">
            <h2>{{ userInfo.name }}</h2>
            <div class="basic-info">
              <p>学历：{{ userInfo.education }}</p>
              <p>年龄：{{ userInfo.age }}</p>
              <p>电话：{{ userInfo.phone }}</p>
              <p>学校：{{ userInfo.school }} </p>
              <p>期望：{{ userInfo.jobIntention }} </p>
            </div>
          </div>
          <el-button type="primary" size="small" @click="handleEdit">编辑</el-button>
        </div>
      </div>

      <!-- 附件管理部分 -->
      <div class="attachment-section">
        <div class="section-header">
          <file-upload
              style="width: 100%"
            v-model="userInfo.attachmentFileIds"
            :file-type="['doc', 'docx', 'pdf']"
            :limit="5"
            :file-size="10"

          />
        </div>
        <el-button type="primary" size="small" @click="handleFileSave">保存</el-button>
        <!-- 文件列表会由FileUpload组件自动处理和显示 -->
      </div>
    </div>

    <!-- 职位列表部分 -->
    <div class="job-list">
      <div class="filter-tabs">
        <el-tabs v-model="activeTab"  @tab-click="handleTabClick">
          <el-tab-pane label="已投递" name="已投递"  value=""></el-tab-pane>
          <el-tab-pane label="待面试" name="待面试" value="待面试"></el-tab-pane>
          <el-tab-pane label="已通过" name="通过" value="通过"></el-tab-pane>
          <el-tab-pane label="未通过" name="不通过" value="不通过"></el-tab-pane>
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
            <image-preview :src="job.logo || default_img" alt="用户头像" :width="100" :height="100" />
            <!-- <img :src="job.logo || default_img" alt="公司logo"> -->

          </div>

<!--          <div class="goutong">-->
<!--            <el-button type="success" size="small" @click="handleChat(job)">继续沟通</el-button>-->
<!--          </div>-->
          
        </div>
        
      </div>
      
      <!-- 分页 -->
      <div class="pagination">
        <el-pagination
          background
          layout="prev, pager, next"
          :total="total"
          :current-page.sync="jobQuery.pageNum"
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
        <el-form-item label="头像" prop="avatar">
          <div class="avatar-uploader">
            <image-upload
              v-model="editForm.avatarFileId"
              :file-type="['jpg', 'jpeg', 'png']"
              :limit="1"
              :file-size="2"
              @on-success="handleAvatarSuccess"
            />
          </div>

        </el-form-item>
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
import FileUpload from '@/components/FileUpload'
import ImagePreview from '@/components/ImagePreview'
import { getUserInfo, updateUserInfo,getInterviewInfo,getResumeImgs} from '@/api/jobseeker/resume'
import { getCurrentUser} from '@/utils/local'
import { search, confirmFilters,submitResume, navigateToHome } from '@/api/home/home'


export default {
  name: 'Message',
  components: {
    ImagePreview,
    FileUpload
  },
  data() {
    return {
      default_img: require('@/assets/default-avatar.jpg'),

      activeTab: '已投递',
      userInfo: {
        id:1,
        avatar: '',
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
      editForm: {
        avatar: '',
        gender: 'male',
        name: '',
        education: '',
        age: 18,
        school: '',
        major: '',
        jobIntention: '',
        salary: '',
        userId: getCurrentUser().id,
        email: '',
      },
      // attachments: [
      //
      // ],
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
          etpName: '测试公司',
          logo: require('@/assets/default-avatar.jpg'),
          employeeCount: '9999'
        }
      ],
      currentPage: 1,
      totalPages: 68,
      dialogVisible: false,
      currentJob: null,
      chatMessage: '',
      editDialogVisible: false,
      rules: {
        avatarFileId: [
          { required: true, message: '请上传头像', trigger: 'change' }
        ],
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
      },
      jobQuery: {
        pageNum: 1,
        pageSize: 10,
        interviewStatus: 'passed'
      },
      total: 0,
    }
  },
  created() {
    // userInfo = getUserInfo(userId)
    this.getuserInfo()
    // this.getresumeImgs()
    this.getinterviewInfo()
    // console.log(11111)
    // console.log(this.jobList)
    // console.log(this.attachments)
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


    // async getresumeImgs() {
    //   try {

    //     const res = await getResumeImgs(getCurrentUser().id)
    //     console.log(getCurrentUser().id)
    //     this.attachments = res.data
    //     console.log(res.data)
        
    //   } catch (error) {
    //     this.$message.error('失败')
    //     console.error('失败:', error)
    //   }
    // },

    async getinterviewInfo() {
      this.jobQuery.userId = getCurrentUser().id
      this.jobQuery.interviewStatus = this.activeTab
      try {
        const res = await getInterviewInfo(this.jobQuery)
        console.log(res.rows)
        this.jobList = res.rows
        
      } catch (error) {
        this.$message.error('失败')
        console.error('失败:', error)
      }
    },

/*    handleUploadSuccess(res, file) {
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
    },*/
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
      this.editForm = {
        ...this.editForm,
        avatarFileId: this.userInfo.avatarFileId,
        name: this.userInfo.name,
        education: this.userInfo.education,
        age: this.userInfo.age,
        school: this.userInfo.school,
        jobIntention: this.userInfo.jobIntention,
        phone: this.userInfo.phone,
        userId: getCurrentUser().id,
        id: getCurrentUser().refId,
        email: this.userInfo.email,
        gender: this.userInfo.gender
      }
      this.editDialogVisible = true
    },
    async submitForm(formName) {
      this.$refs[formName].validate(async (valid) => {
        if (valid) {
          try {
            const res = await updateUserInfo(this.editForm)
            if (res.code === 200) {
              this.$message.success('更新成功')
              this.editDialogVisible = false
              // 更新用户信息显示
              this.getuserInfo()
            } else {
              this.$message.error(res.msg || '更新失败')
            }
          } catch (error) {
            console.error('更新失败:', error)
            this.$message.error('更新失败')
          }
        } else {
          return false
        }
      })
    },
    handleFileSave(){
      console.log(this.userInfo)
        updateUserInfo(this.userInfo).then(res=>{
          if (res.code === 200) {
            this.$message.success('更新成功')
            this.editDialogVisible = false
            this.getuserInfo()
          } else {
            this.$message.error(res.msg || '更新失败')
          }
        }).catch(e=>{
          console.error('更新失败:', e)
          this.$message.error('更新失败')
        })
    },
    handleAvatarSuccess() {
      this.$message.success('头像上传成功')
    },
    handlePageChange(){
      this.getinterviewInfo()
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

.avatar-uploader {
  display: flex;
  align-items: center;
  gap: 20px;
}
</style>

