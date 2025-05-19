<template>
  <div>
<!--    company-->
    <main class="content">
<!--      <div v-if="loading" class="loading">数据加载中</div>-->
<!--      <div v-else-if="error" class="error">{{ error }}</div>-->
<!--      <div v-else class="welcome-section">-->
      <div class="welcome-section">
        <h2>欢迎您</h2>
        <div class="company-info">
          <p class="welcome-message">欢迎来到 {{ companyData.name }} 的企业信息页面</p>
          <p class="company-address">所在城市: {{ companyData.address }}</p>
          <p class="company-phone">联系电话: {{ companyData.phone }}</p>
          <p class="company-email">联系邮箱: {{ companyData.email }}</p>
          <div class="company-description">
            <p >公司简介: {{ companyData.description }}</p>
          </div>
          <div class="company-image" v-if="companyData.logo_file_id">
            <img :src="'/api/company' + companyData.logo_file_id" alt="Company Logo" />

          </div>
        </div>
      </div>
    </main>
  </div>
</template>

<script>
export default {
  name: 'Company',
  data() {
    return {
      companyData: {
        name: '',
        description: '',
        address: '',
        phone: '',
        email: '',
        logo_file_id: '',

      },
      loading: true,
      error: null
    }
  },
  mounted() {
    this.fetchCompanyData();
  },
  methods: {
    async featchCompanyData() {
      try {
        const response = await axios.get('/api/company', {
          params: {
            table: 'tb_etp',
            fields: 'name, description, address, phone, email, logo_file_id'
          }
        });
        if (response.data && response.data.length > 0) {
          this.companyData = response.data[0];
        } else {
          this.error = 'No company data found';
        }
      } catch (error) {
        this.error = 'Failed to fetch company data';
      } finally {
        this.loading = false;
      }
    },
  },
  created() {
  }
}
</script>

<style scoped lang="scss">

</style>