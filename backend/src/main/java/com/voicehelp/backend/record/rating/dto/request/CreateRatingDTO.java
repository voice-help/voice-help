package com.voicehelp.backend.record.rating.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;

public class CreateRatingDTO {


    public static class Attributes {
        public static final String RECORD_ID = "recordId";
        public static final String USER = "user";
        public static final String RATING = "rating";
    }

    @JsonProperty(value = Attributes.RECORD_ID, access = JsonProperty.Access.WRITE_ONLY)
    private String recordId;
    @JsonProperty(value = Attributes.USER, access = JsonProperty.Access.WRITE_ONLY)
    private String user;
    @JsonProperty(value = Attributes.RATING, access = JsonProperty.Access.WRITE_ONLY)
    private Integer rating;

    public String getRecordId() {
        return recordId;
    }

    public void setRecordId(String recordId) {
        this.recordId = recordId;
    }

    public String getUser() {
        return user;
    }

    public void setUser(String user) {
        this.user = user;
    }

    public Integer getRating() {
        return rating;
    }

    public void setRating(Integer rating) {
        this.rating = rating;
    }
}
