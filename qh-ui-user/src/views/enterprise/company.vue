<template>
  <div class="company-container">
    <!-- 欢迎信息 -->
    <div class="welcome-header">
      <h1>欢迎访问公司管理中心</h1>
    </div>

    <!-- 公司信息卡片 -->
    <el-card class="company-card" shadow="hover">
      <div slot="header" class="clearfix">
        <span>公司基本信息</span>
        <el-button
            v-if="!isEditing"
            style="float: right; padding: 3px 0"
            type="text"
            @click="startEditing"
        >
          <i class="el-icon-edit"></i> 编辑
        </el-button>
        <div v-else style="float: right">
          <el-button size="mini" @click="cancelEditing">取消</el-button>
          <el-button size="mini" type="primary" @click="saveCompanyInfo">保存</el-button>
        </div>
      </div>

      <div class="company-content">
        <!-- 公司logo展示 -->
        <div class="logo-section">
          <div v-if="!isEditing">
            <image-preview :src="companyInfo.logoFileId" v-if="!isEditing">
            </image-preview>
            <div v-else class="empty-logo">
              <i class="el-icon-picture-outline" style="font-size: 50px;"></i>
              <p>暂无logo</p>
            </div>
          </div>
          <div v-else>
            <image-upload
                v-model="companyInfo.logoFileId"
                :limit="1"
                :file-size="5"
                :is-show-tip="false"
            ></image-upload>
          </div>
        </div>

        <!-- 公司详细信息 -->
        <div class="info-section">
          <el-form label-width="100px" :disabled="!isEditing">
            <el-form-item label="公司名称">
              <el-input v-model="companyInfo.name" :readonly="!isEditing"></el-input>
            </el-form-item>

            <el-form-item label="公司简介">
              <el-input
                  v-model="companyInfo.description"
                  type="textarea"
                  :rows="3"
                  :readonly="!isEditing"
                  placeholder="请输入公司宣传信息"
              ></el-input>
            </el-form-item>

            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item label="法定代表人">
                  <el-input v-model="companyInfo.legalPerson" :readonly="!isEditing"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="联系电话">
                  <el-input v-model="companyInfo.phone" :readonly="!isEditing"></el-input>
                </el-form-item>
              </el-col>
            </el-row>

            <el-form-item label="公司地址">
              <el-input v-model="companyInfo.address" :readonly="!isEditing"></el-input>
            </el-form-item>

            <el-row :gutter="20">
              <el-col :span="12">
                <el-form-item label="电子邮箱">
                  <el-input v-model="companyInfo.email" :readonly="!isEditing"></el-input>
                </el-form-item>
              </el-col>
              <el-col :span="12">
                <el-form-item label="公司网站">
                  <el-input v-model="companyInfo.website" :readonly="!isEditing"></el-input>
                </el-form-item>
              </el-col>
            </el-row>
          </el-form>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
// import { getCompanyInfo, updateCompanyInfo } from "@/api/system/company";
import ImageUpload from "@/components/ImageUpload";
import {loadMyCompany, updateEtp} from "@/api/etp";
import {getCurrentUser} from "@/utils/local";

export default {
  name: "Company",
  components: {ImageUpload},
  data() {
    return {
      isEditing: false,
      originalData: {},
      companyInfo: {
        id: null,
        userId: null,
        logoFileId: null,
        name: "",
        description: "",
        legalPerson: "",
        address: "",
        phone: "",
        email: "",
        website: ""
      }
    };
  },
  created() {
    this.loadCompanyInfo();
  },
  methods: {
    loadCompanyInfo() {
      loadMyCompany(getCurrentUser().id).then(resp=>{
        if(resp.code==200){
          this.companyInfo = resp.data;
          this.originalData = resp.data;
        }
      })
    },
    startEditing() {
      this.isEditing = true;
    },
    cancelEditing() {
      this.isEditing = false;
      // 恢复原始数据
      this.companyInfo = JSON.parse(JSON.stringify(this.originalData));
    },
    saveCompanyInfo() {
      this.$confirm("确认保存修改的公司信息吗?", "提示", {
        confirmButtonText: "确定",
        cancelButtonText: "取消",
        type: "warning"
      }).then(() => {
        updateEtp(this.companyInfo).then(resp => {
          if(resp.code !== 200) {
            this.$message.error("保存失败");
            return;
          } else {
            this.$message.success("保存成功");
            this.isEditing = false;
            this.loadCompanyInfo(); // 重新加载数据确保最新
          }
        });
      }).catch(() => {
        this.$message.info("已取消保存");
      });
    }
  }
};
</script>

<style scoped>
.company-container {
  padding: 20px;
}

.welcome-header {
  text-align: center;
  margin-bottom: 30px;
  padding: 20px;
  background: linear-gradient(135deg, #f5f7fa 0%, #c3cfe2 100%);
  border-radius: 8px;
  color: #333;
}

.welcome-header h1 {
  margin-bottom: 10px;
  font-weight: 500;
}

.company-card {
  max-width: 1000px;
  margin: 0 auto;
}

.company-content {
  display: flex;
  flex-wrap: wrap;
}

.logo-section {
  flex: 0 0 200px;
  padding: 10px;
  text-align: center;
}

.empty-logo {
  width: 150px;
  height: 150px;
  line-height: 150px;
  text-align: center;
  border: 1px dashed #dcdfe6;
  border-radius: 4px;
  color: #909399;
}

.empty-logo p {
  line-height: 1.5;
  margin-top: -30px;
}

.info-section {
  flex: 1;
  min-width: 300px;
  padding: 10px;
}

/* 响应式调整 */
@media (max-width: 768px) {
  .company-content {
    flex-direction: column;
  }

  .logo-section {
    margin-bottom: 20px;
  }
}
</style>