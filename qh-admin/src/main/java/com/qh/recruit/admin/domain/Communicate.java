package com.qh.recruit.admin.domain;

import org.apache.commons.lang3.builder.ToStringBuilder;
import org.apache.commons.lang3.builder.ToStringStyle;
import com.qh.recruit.common.annotation.Excel;
import com.qh.recruit.common.core.domain.BaseEntity;

/**
 * 沟通对象 tb_communicate
 *
 * @author ruoyi
 * @date 2025-05-02
 */
public class Communicate extends BaseEntity
{
    private static final long serialVersionUID = 1L;

    /** id */
    private Long id;

    /** 发送方 */
    @Excel(name = "发送方")
    private Long posterId;

    /** 接收方 */
    @Excel(name = "接收方")
    private Long receiverId;

    /** 上一条 */
    @Excel(name = "上一条")
    private Long previousId;

    /** 内容 */
    @Excel(name = "内容")
    private String content;

    /** 内容类型 */
    @Excel(name = "内容类型")
    private String contentType;

    /** 状态 */
    private Integer status;

    /** 锁 */
    private Long version;

    public void setId(Long id)
    {
        this.id = id;
    }

    public Long getId()
    {
        return id;
    }

    public void setPosterId(Long posterId)
    {
        this.posterId = posterId;
    }

    public Long getPosterId()
    {
        return posterId;
    }

    public void setReceiverId(Long receiverId)
    {
        this.receiverId = receiverId;
    }

    public Long getReceiverId()
    {
        return receiverId;
    }

    public void setPreviousId(Long previousId)
    {
        this.previousId = previousId;
    }

    public Long getPreviousId()
    {
        return previousId;
    }

    public void setContent(String content)
    {
        this.content = content;
    }

    public String getContent()
    {
        return content;
    }

    public void setContentType(String contentType)
    {
        this.contentType = contentType;
    }

    public String getContentType()
    {
        return contentType;
    }

    public void setStatus(Integer status)
    {
        this.status = status;
    }

    public Integer getStatus()
    {
        return status;
    }

    public void setVersion(Long version)
    {
        this.version = version;
    }

    public Long getVersion()
    {
        return version;
    }

    @Override
    public String toString() {
        return new ToStringBuilder(this,ToStringStyle.MULTI_LINE_STYLE)
                .append("id", getId())
                .append("posterId", getPosterId())
                .append("receiverId", getReceiverId())
                .append("previousId", getPreviousId())
                .append("content", getContent())
                .append("contentType", getContentType())
                .append("createTime", getCreateTime())
                .append("updateTime", getUpdateTime())
                .append("status", getStatus())
                .append("version", getVersion())
                .toString();
    }
}
