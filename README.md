## 启航——企业招聘系统
- 基于ruoyi开发
#### 模块说明
- 管理端：qh-ui-admin
- 后端模块：qh-admin
- 求职端与企业端：qh-ui-user
#### 后端初始化
1. 安装redis： https://github.com/microsoftarchive/redis/releases/tag/win-3.0.504
2. 安装mysql 
3. 创建数据库/配置数据库连接：修改`qh-admin/src/main/resources/application-druid.yml`文件
4. 导入数据库：`sql/qh.sql`
#### 前端初始化
1. 进入到对应前端目录
2. 执行命令
```bash
npm install
```
3. 运行
```bash
npm run serve #求职端/企业端
npm run dev #管理后端
```
#### 开发说明
- 最好依照原型图进行设计
##### 求职端和企业端
- 可以参考`qh-ui-admin`的写法
- 在api/对应模块中记录后端接口，在view中实现视图和逻辑接口调用
##### 后端：
- 需要在`com.qh.recruit.user.controller`下重新定义请求路径(前缀已定义)
- 可以调用并开发`com.qh.recruit.admin`下的其它包
