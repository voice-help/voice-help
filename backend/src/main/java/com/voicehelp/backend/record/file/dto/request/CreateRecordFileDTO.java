package com.voicehelp.backend.record.file.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;


public class CreateRecordFileDTO {

    public static class Attributes {
        public static final String OBJECT_ROOT = "file";
        public static final String EXTENSION = "extension";
    }

    @JsonProperty(value = Attributes.EXTENSION, access = JsonProperty.Access.WRITE_ONLY)
    private String extension;

    public String getExtension() {
        return extension;
    }

    public void setExtension(String extension) {
        this.extension = extension;
    }
}
