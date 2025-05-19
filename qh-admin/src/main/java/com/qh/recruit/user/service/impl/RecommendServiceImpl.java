package com.qh.recruit.user.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.qh.recruit.admin.domain.Job;
import com.qh.recruit.admin.mapper.JobMapper;
import com.qh.recruit.common.core.domain.AjaxResult;
import com.qh.recruit.common.core.domain.entity.SysUser;
import com.qh.recruit.common.core.page.TableDataInfo;
import com.qh.recruit.common.utils.SecurityUtils;
import com.qh.recruit.user.domain.JobRecommendQuery;
import com.qh.recruit.user.service.RecommendService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * 职位推荐服务实现类
 */
@Service
public class RecommendServiceImpl implements RecommendService {

    @Autowired
    private JobMapper jobMapper;

//    /**
//     * 计算技能匹配度得分
//     */
//    private double calculateSkillMatchScore(SysUser user, Job job) {
//        // 获取用户技能列表
//        List<String> userSkills = getUserSkills(user);
//        if (userSkills.isEmpty() || job.getSkills() == null || job.getSkills().isEmpty()) {
//            return 0.0;
//        }
//
//        // 计算技能交集数量
//        long matchCount = userSkills.stream()
//                .filter(skill -> job.getSkills().contains(skill))
//                .count();
//
//        // 返回匹配度得分 (0-1之间)
//        return (double) matchCount / Math.max(userSkills.size(), job.getSkills().size());
//    }
//
//    /**
//     * 计算薪资匹配度得分
//     */
//    private double calculateSalaryMatchScore(SysUser user, Job job) {
//        // 获取用户期望薪资范围
//        String expectedSalary = getUserExpectedSalary(user);
//        if (StringUtils.isEmpty(expectedSalary) || StringUtils.isEmpty(job.getSalary())) {
//            return 0.0;
//        }
//
//        // 解析薪资范围
//        int[] expectedRange = parseSalaryRange(expectedSalary);
//        int[] jobRange = parseSalaryRange(job.getSalary());
//
//        // 计算薪资范围重叠度
//        int overlapStart = Math.max(expectedRange[0], jobRange[0]);
//        int overlapEnd = Math.min(expectedRange[1], jobRange[1]);
//
//        if (overlapStart >= overlapEnd) {
//            return 0.0;
//        }
//
//        // 计算重叠比例
//        int overlapSize = overlapEnd - overlapStart;
//        int expectedSize = expectedRange[1] - expectedRange[0];
//
//        return (double) overlapSize / expectedSize;
//    }
//
//    /**
//     * 计算福利匹配度得分
//     */
//    private double calculateWelfareMatchScore(SysUser user, Job job) {
//        // 获取用户期望的福利标签
//        List<String> expectedWelfare = getUserExpectedWelfare(user);
//        if (expectedWelfare.isEmpty() || job.getWelfare() == null || job.getWelfare().isEmpty()) {
//            return 0.0;
//        }
//
//        // 计算福利标签的匹配数量
//        long matchCount = expectedWelfare.stream()
//                .filter(welfare -> job.getWelfare().contains(welfare))
//                .count();
//
//        // 返回匹配度得分
//        return (double) matchCount / Math.max(expectedWelfare.size(), job.getWelfare().size());
//    }
//
//    /**
//     * 获取用户技能列表
//     */
//    private List<String> getUserSkills(SysUser user) {
//        // TODO: 从用户画像或简历中获取技能列表
//        return new ArrayList<>();
//    }
//
//    /**
//     * 获取用户期望薪资
//     */
//    private String getUserExpectedSalary(SysUser user) {
//        // TODO: 从用户画像或简历中获取期望薪资
//        return "";
//    }
//
//    /**
//     * 获取用户期望的福利标签
//     */
//    private List<String> getUserExpectedWelfare(SysUser user) {
//        // TODO: 从用户画像或简历中获取期望福利
//        return new ArrayList<>();
//    }
//
//    /**
//     * 解析薪资范围字符串
//     * @param salary 格式如 "7k-8k"
//     * @return [最小值, 最大值]
//     */
//    private int[] parseSalaryRange(String salary) {
//        try {
//            String[] parts = salary.toLowerCase().split("-");
//            int min = Integer.parseInt(parts[0].replace("k", ""));
//            int max = Integer.parseInt(parts[1].replace("k", ""));
//            return new int[]{min, max};
//        } catch (Exception e) {
//            return new int[]{0, 0};
//        }
//    }
//
//    @Override
    public AjaxResult getRecommendJobs(JobRecommendQuery query) {
//        // 获取当前登录用户信息
//        LoginUser loginUser = SecurityUtils.getLoginUser();
//        SysUser user = loginUser.getUser();
//
//        // 构建查询条件
//        QueryWrapper<Job> jobQueryWrapper = new QueryWrapper<>();
//        jobQueryWrapper.eq("status", "0"); // 只查询正常状态的职位
//
//        // 添加基础筛选条件
//        if (StringUtils.isNotEmpty(query.getCity())) {
//            jobQueryWrapper.eq("city", query.getCity());
//        }
//        if (StringUtils.isNotEmpty(query.getIndustry())) {
//            jobQueryWrapper.eq("industry", query.getIndustry());
//        }
//        if (StringUtils.isNotEmpty(query.getSalaryRange())) {
//            jobQueryWrapper.eq("salary", query.getSalaryRange());
//        }
//
//        // 查询所有符合条件的职位
//        List<Job> allJobs = jobMapper.selectList(jobQueryWrapper);
//
//        // 计算职位得分并排序
//        List<JobScore> jobScores = allJobs.stream().map(job -> {
//            JobScore score = new JobScore();
//            score.setJob(job);
//
//            // 基础匹配得分
//            double baseScore = 0.0;
//
//            // 根据优先条件计算权重
//            switch (query.getPriority()) {
//                case "skill":
//                    // 技能匹配度权重加倍
//                    baseScore += calculateSkillMatchScore(user, job) * 2.0;
//                    baseScore += calculateSalaryMatchScore(user, job);
//                    baseScore += calculateWelfareMatchScore(user, job);
//                    break;
//                case "salary":
//                    // 薪资匹配度权重加倍
//                    baseScore += calculateSkillMatchScore(user, job);
//                    baseScore += calculateSalaryMatchScore(user, job) * 2.0;
//                    baseScore += calculateWelfareMatchScore(user, job);
//                    break;
//                case "welfare":
//                    // 福利匹配度权重加倍
//                    baseScore += calculateSkillMatchScore(user, job);
//                    baseScore += calculateSalaryMatchScore(user, job);
//                    baseScore += calculateWelfareMatchScore(user, job) * 2.0;
//                    break;
//                default:
//                    baseScore += calculateSkillMatchScore(user, job);
//                    baseScore += calculateSalaryMatchScore(user, job);
//                    baseScore += calculateWelfareMatchScore(user, job);
//            }
//
//            score.setScore(baseScore);
//            return score;
//        }).sorted((a, b) -> Double.compare(b.getScore(), a.getScore())) // 按得分降序排序
//          .collect(Collectors.toList());
//
//        // 分页处理
//        int start = (query.getPage() - 1) * query.getPageSize();
//        int end = Math.min(start + query.getPageSize(), jobScores.size());
//        List<Job> pageJobs = jobScores.subList(start, end)
//                .stream()
//                .map(JobScore::getJob)
//                .collect(Collectors.toList());
//
//        Map<String, Object> result = new HashMap<>();
//        result.put("list", pageJobs);
//        result.put("total", jobScores.size());
//
        return AjaxResult.success("11");
    }

    @Override
    public AjaxResult communicate(Long jobId) {
        // TODO: 实现发起沟通逻辑
        // 1. 验证职位是否存在
        // 2. 创建沟通记录
        // 3. 发送消息通知企业方
        return AjaxResult.success("发起沟通成功");
    }

    @Override
    public AjaxResult submitResume(Long jobId) {
        // TODO: 实现简历投递逻辑
        // 1. 验证职位是否存在且开放投递
        // 2. 检查用户简历完整性
        // 3. 创建投递记录
        // 4. 发送投递成功通知
        return AjaxResult.success("简历投递成功");
    }
}