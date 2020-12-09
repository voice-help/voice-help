package com.voicehelp.backend.record.file.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.voicehelp.backend.record.file.RecordFile;

public class GetRecordFileDTO {
    public static class Attributes {
        public static final String OBJECT_ROOT = "file";
        public static final String ID = "id";
        public static final String NAME = "name";
        public static final String EXTENSION = "extension";
    }
    @JsonProperty(value = GetRecordFileDTO.Attributes.ID, access = JsonProperty.Access.READ_ONLY)
    private String fileId;
    @JsonProperty(value = GetRecordFileDTO.Attributes.NAME, access = JsonProperty.Access.READ_ONLY)
    private String fileName;
    @JsonProperty(value = GetRecordFileDTO.Attributes.EXTENSION, access = JsonProperty.Access.READ_ONLY)
    private String extension;

    public GetRecordFileDTO(RecordFile recordFile){
        this.fileId = recordFile.getFileId();
        this.fileName = recordFile.getFileName();
        this.extension = recordFile.getExtension();
    }

    public String getFileId() {
        return fileId;
    }



    public String getFileName() {
        return fileName;
    }


    public String getExtension() {
        return extension;
    }

}
