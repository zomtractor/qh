package com.qh.recruit.admin.domain.dto;

import com.qh.recruit.admin.domain.Communicate;

public class CommunicateDto extends Communicate {
    private String posterName;
    private String receiverName;

    public String getPosterName() {
        return posterName;
    }

    public void setPosterName(String posterName) {
        this.posterName = posterName;
    }

    public String getReceiverName() {
        return receiverName;
    }

    public void setReceiverName(String receiverName) {
        this.receiverName = receiverName;
    }
}
