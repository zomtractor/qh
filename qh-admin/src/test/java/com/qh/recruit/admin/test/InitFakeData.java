package com.qh.recruit.admin.test;

import com.qh.recruit.RuoYiApplication;
import com.qh.recruit.admin.domain.*;
import com.qh.recruit.admin.mapper.*;
import org.junit.jupiter.api.Test;
import org.mybatis.spring.annotation.MapperScan;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.time.LocalDateTime;
import java.time.ZoneId;
import java.util.*;
import java.util.stream.Collectors;

import com.github.javafaker.Faker;
import org.springframework.test.annotation.Rollback;

@SpringBootTest(classes = RuoYiApplication.class)
@MapperScan(basePackages = "com.qh.recruit.user.mapper")
public class InitFakeData {

    @Autowired
    private UserMapper userMapper;

    @Autowired
    private EtpMapper etpMapper;

    @Autowired
    private ResumeMapper resumeMapper;

    @Autowired
    private CategoryMapper categoryMapper;

    @Autowired
    private TagMapper tagMapper;

    @Autowired
    private JobMapper jobMapper;

    @Autowired
    private CommunicateMapper communicateMapper;

    @Autowired
    private InterviewMapper interviewMapper;

    @Autowired
    private PasswordEncoder passwordEncoder;

    private final Faker faker = new Faker(Locale.CHINA);

    private final Random random = new Random();

    @Test
    @Rollback
    public void generateTestData() {
        // 清空所有表数据（注意：仅用于测试环境）
//        clearAllTables();

        // 生成管理员用户
        generateAdminUsers();

        // 生成分类
        List<Category> categories = generateCategories();

        // 生成标签
        List<Tag> tags = generateTags();

        // 生成企业用户和企业信息
        List<User> etpUsers = generateEnterpriseUsers(20);
        List<Etp> enterprises = generateEnterprises(etpUsers);

        // 生成求职者用户和简历
        List<User> jobSeekerUsers = generateJobSeekerUsers(60);
        List<Resume> resumes = generateResumes(jobSeekerUsers);

        // 为每个企业生成岗位
        List<Job> jobs = generateJobsForEnterprises(enterprises, categories, tags);

        // 更新企业热度（所有岗位热度总和）
        updateEnterprisePopularity(enterprises, jobs);

        generateCommunicate(jobSeekerUsers, etpUsers);

        // 生成沟通和面试记录
        generateInterviews(resumes, jobs, enterprises);
    }


    private void generateAdminUsers() {
        User admin = new User();
        admin.setUsername("admin");
        admin.setPassword(passwordEncoder.encode("123456"));
        admin.setUserType("admin");
        userMapper.insertUser(admin);
    }

    private List<Category> generateCategories() {
        List<Category> categories = new ArrayList<>();
        for (int i = 0; i < 20; i++) {
            Category category = new Category();
            category.setName(faker.job().title() + "类");
            categories.add(category);
            categoryMapper.insertCategory(category);
        }
        return categories;
    }

    private List<Tag> generateTags() {
        List<Tag> tags = new ArrayList<>();
        for (int i = 0; i < 20; i++) {
            Tag tag = new Tag();
            tag.setName(faker.lorem().word());
            tag.setPopularity(((long) random.nextInt(100)));
            tags.add(tag);
            try{
                tagMapper.insertTag(tag);
            } catch (Exception e){
                i--;
                continue;
            }
        }
        return tags;
    }

    private List<User> generateEnterpriseUsers(int count) {
        List<User> users = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            User user = new User();
            user.setUsername("company_" + faker.name().username().replace(".", ""));
            user.setPassword(passwordEncoder.encode("123456"));
            user.setUserType("enterprise");
            userMapper.insertUser(user);
            users.add(user);
        }
        return users;
    }

    private List<Etp> generateEnterprises(List<User> etpUsers) {
        List<Etp> enterprises = new ArrayList<>();
        for (User user : etpUsers) {
            Etp etp = new Etp();
            etp.setUserId(user.getId());
            etp.setName(faker.company().name());
            etp.setDescription(faker.lorem().paragraph(5));
            etp.setLegalPerson(faker.name().fullName());
            etp.setAddress(faker.address().fullAddress());
            etp.setPhone(faker.phoneNumber().cellPhone());
            etp.setEmail(faker.internet().emailAddress());
            etp.setWebsite("https://" + faker.internet().domainName());
            etp.setPopularity(0L); // 初始为0，后面会根据岗位热度更新

            etpMapper.insertEtp(etp);
            enterprises.add(etp);
        }
        return enterprises;
    }

    private List<User> generateJobSeekerUsers(int count) {
        List<User> users = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            User user = new User();
            user.setUsername("user_" + faker.name().username().replace(".", ""));
            user.setPassword(passwordEncoder.encode("123456"));
            user.setUserType("job_seeker");
            userMapper.insertUser(user);
            users.add(user);
        }
        return users;
    }

    private List<Resume> generateResumes(List<User> jobSeekerUsers) {
        List<Resume> resumes = new ArrayList<>();
        for (User user : jobSeekerUsers) {
            Resume resume = new Resume();
            resume.setUserId(user.getId());
            resume.setName(faker.name().fullName());
            resume.setGender(random.nextBoolean() ? "male" : "female");
            resume.setAge((long) (20 + random.nextInt(20)));
            resume.setEducation(getRandomEducation());
            resume.setSchool(faker.university().name());
            resume.setPhone(faker.phoneNumber().cellPhone());
            resume.setEmail(faker.internet().emailAddress());
            resume.setJobIntention(faker.job().position());
            resume.setAttachmentFileIds(generateRandomFileIds());

            resumeMapper.insertResume(resume);
            resumes.add(resume);
        }
        return resumes;
    }

    private List<Job> generateJobsForEnterprises(List<Etp> enterprises, List<Category> categories, List<Tag> tags) {
        List<Job> jobs = new ArrayList<>();
        for (Etp etp : enterprises) {
            int jobCount = 10; // 每个企业10个岗位
            for (int i = 0; i < jobCount; i++) {
                Job job = new Job();
                job.setName(faker.job().title());
                job.setDescription(faker.lorem().paragraph(3));
                job.setSalaryDesc(getRandomSalary());
                job.setLocation(faker.address().city());
                job.setRequirement(faker.lorem().paragraph(2));
                job.setEtpId(etp.getId());

                // 随机选择1-3个分类
                List<Long> categoryIds = getRandomSubset(categories, 1, 3).stream()
                        .map(Category::getId)
                        .collect(Collectors.toList());
                job.setCategoryIds(String.join(",", categoryIds.stream().map(String::valueOf).collect(Collectors.toList())));

                // 随机选择1-5个标签
                List<Long> tagIds = getRandomSubset(tags, 1, 5).stream()
                        .map(Tag::getId)
                        .collect(Collectors.toList());
                job.setTagIds(String.join(",", tagIds.stream().map(String::valueOf).collect(Collectors.toList())));

                job.setPopularity(5L + random.nextInt(46)); // 5-50的热度

                jobMapper.insertJob(job);
                jobs.add(job);
            }
        }
        return jobs;
    }

    private void updateEnterprisePopularity(List<Etp> enterprises, List<Job> jobs) {
        Map<Long, Integer> etpPopularityMap = new HashMap<>();

        // 计算每个企业的总热度
        for (Job job : jobs) {
            etpPopularityMap.merge(job.getEtpId(), (int)(long)(job.getPopularity()), Integer::sum);
        }

        // 更新企业热度
        for (Etp etp : enterprises) {
            Integer popularity = etpPopularityMap.get(etp.getId());
            if (popularity != null) {
                etp.setPopularity(popularity+0L);
                etpMapper.updateEtp(etp);
            }
        }
    }
    private void generateCommunicate(List<User> jobSeekerUsers, List<User> etpUsers) {
        // 确保有求职者和企业用户
        if (jobSeekerUsers.isEmpty() || etpUsers.isEmpty()) {
            return;
        }

        for (User jobSeeker : jobSeekerUsers) {
            // 每位求职者与1-5个企业沟通
            int etpCount = 1 + random.nextInt(5); // 1-5个企业
            List<User> contactedEtps = getRandomSubset(etpUsers, etpCount, etpCount);

            for (User etpUser : contactedEtps) {
                // 每个企业至少有3条沟通记录
                int messageCount = 3 + random.nextInt(3); // 3-5条消息

                Long previousId = -1L; // 第一条消息的previous_id为-1

                for (int i = 0; i < messageCount; i++) {
                    Communicate communicate = new Communicate();

                    // 随机决定是求职者发送还是企业发送
                    boolean isJobSeekerSender = random.nextBoolean();
                    communicate.setPosterId(isJobSeekerSender ? jobSeeker.getId() : etpUser.getId());
                    communicate.setReceiverId(isJobSeekerSender ? etpUser.getId() : jobSeeker.getId());

                    communicate.setPreviousId(previousId);
                    communicate.setContent(generateMessageContent());
                    communicate.setContentType(getRandomContentType());

                    communicateMapper.insertCommunicate(communicate);

                    // 更新previousId为当前消息的ID，用于下一条消息
                    previousId = communicate.getId();
                }
            }
        }
    }

    // 生成随机消息内容
    private String generateMessageContent() {
        String[] greetings = {"你好", "您好", "Hi", "Hello", "请问"};
        String[] questions = {
                "这个岗位还在招聘吗？",
                "薪资范围是多少？",
                "工作地点在哪里？",
                "有什么福利待遇？",
                "需要什么技能？",
                "什么时候可以面试？",
                "公司发展前景如何？"
        };
        String[] responses = {
                "还在招聘的",
                "薪资范围如招聘信息所述",
                "工作地点在" + faker.address().city(),
                "我们有五险一金、年终奖等福利",
                "需要" + faker.job().keySkills() + "等技能",
                "随时可以安排面试",
                "我们公司发展前景良好"
        };

        if (random.nextBoolean()) {
            // 生成问题
            return greetings[random.nextInt(greetings.length)] + questions[random.nextInt(questions.length)];
        } else {
            // 生成回复
            return responses[random.nextInt(responses.length)];
        }
    }

    // 获取随机消息类型
    private String getRandomContentType() {
        String[] types = {"text", "image", "file"};
        // 90%的概率是文本，10%的概率是图片或文件
        if (random.nextInt(10) < 9) {
            return "text";
        } else {
            return types[1 + random.nextInt(2)];
        }
    }

    private void generateInterviews(List<Resume> resumes, List<Job> jobs, List<Etp> enterprises) {
        // 按企业分组岗位
        Map<Long, List<Job>> jobsByEtp = jobs.stream()
                .collect(Collectors.groupingBy(Job::getEtpId));

        for (Resume resume : resumes) {
            // 每位求职者与1-5个企业有沟通记录
            List<Etp> contactedEtps = getRandomSubset(enterprises, 1, 5);

            for (Etp etp : contactedEtps) {
                // 每个企业有3条沟通记录
                for (int i = 0; i < 3; i++) {
                    Interview interview = new Interview();
                    interview.setUserId(resume.getUserId());
                    interview.setEtpId(etp.getId());

                    // 随机选择一个该企业的岗位
                    List<Job> etpJobs = jobsByEtp.get(etp.getId());
                    if (etpJobs != null && !etpJobs.isEmpty()) {
                        Job randomJob = etpJobs.get(random.nextInt(etpJobs.size()));
                        interview.setJobId(randomJob.getId());
                    }

                    // 随机决定是否是面试记录（0-2个企业有面试记录）
                    boolean isInterview = i == 0 && random.nextInt(contactedEtps.size()) < 3;

                    if (isInterview) {
                        interview.setInterviewStatus(getRandomInterviewStatus());
                        interview.setMessage(faker.lorem().sentence());
                        interview.setTime(faker.date().between(
                                Date.from(LocalDateTime.now().minusMonths(1).atZone(ZoneId.systemDefault()).toInstant()),
                                Date.from(LocalDateTime.now().plusMonths(1).atZone(ZoneId.systemDefault()).toInstant()
                                )));
                    } else {
                        interview.setInterviewStatus("communicating");
                        interview.setMessage(faker.lorem().sentence());
                    }

                    interviewMapper.insertInterview(interview);
                }
            }
        }
    }

    // 辅助方法
    private <T> List<T> getRandomSubset(List<T> list, int min, int max) {
        int count = min + random.nextInt(max - min + 1);
        Collections.shuffle(list);
        return new ArrayList<>(list.subList(0, Math.min(count, list.size())));
    }

    private String getRandomEducation() {
        String[] educations = {"高中", "大专", "本科", "硕士", "博士"};
        return educations[random.nextInt(educations.length)];
    }

    private String getRandomSalary() {
        String[] salaries = {
                "5000", "8000", "7999", "15000",
                "2000", "3000", "4000", "8888"
        };
        return salaries[random.nextInt(salaries.length)];
    }

    private String getRandomInterviewStatus() {
        String[] statuses = {
                "pending", "scheduled", "passed", "failed", "cancelled"
        };
        return statuses[random.nextInt(statuses.length)];
    }

    private String generateRandomFileIds() {
        int count = random.nextInt(3); // 0-2个附件
        if (count == 0) return null;

        List<String> ids = new ArrayList<>();
        for (int i = 0; i < count; i++) {
            ids.add(UUID.randomUUID().toString());
        }
        return String.join(",", ids);
    }
}

