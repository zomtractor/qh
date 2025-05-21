package com.qh.recruit.user.domain;

import com.qh.recruit.common.annotation.Excel;
import lombok.Data;

/**
 * @auther xky
 * @date 2025/5/21
 * @describe
 */
@Data
public class ResumeJob {

    /** $column.columnComment */
    private Long id;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private Long userId;

    /** 头像文件ID */
    @Excel(name = "头像文件ID")
    private String avatarFileId;

    /** 名称 */
    @Excel(name = "名称")
    private String name;

    /** 性别 */
    @Excel(name = "性别")
    private String gender;

    /** 年龄 */
    @Excel(name = "年龄")
    private Long age;

    /** 教育经历 */
    @Excel(name = "教育经历")
    private String education;

    /** 毕业院校 */
    @Excel(name = "毕业院校")
    private String school;

    /** 联系电话 */
    @Excel(name = "联系电话")
    private String phone;

    /** 电子邮件 */
    @Excel(name = "电子邮件")
    private String email;

    /** $column.columnComment */
    @Excel(name = "${comment}", readConverterExp = "$column.readConverterExp()")
    private String jobIntention;

    /** 简历附件 */
    @Excel(name = "简历附件")
    private String attachmentFileIds;

    /** $column.columnComment */
    private Integer status;

    /** $column.columnComment */
    private Long version;
}
