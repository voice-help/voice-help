package com.voicehelp.backend.record.dto.request;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.voicehelp.backend.record.file.dto.request.CreateRecordFileDTO;


public class CreateRecordDTO {

    public static class Attributes {
        public static final String NAME = "name";
        public static final String USER = "user";
    }

    @JsonProperty(value = Attributes.NAME, access = JsonProperty.Access.WRITE_ONLY)
    private String recordName;
    @JsonProperty(value = Attributes.USER, access = JsonProperty.Access.WRITE_ONLY)
    private String createBy;
    @JsonProperty(value = CreateRecordFileDTO.Attributes.OBJECT_ROOT, access = JsonProperty.Access.WRITE_ONLY)
    private CreateRecordFileDTO recordFile;


    public static CreateRecordDTO create(String recordName, String extension, String createBy) {
        final CreateRecordDTO createRecordDTO = new CreateRecordDTO();
        final CreateRecordFileDTO createRecordFileDTO = new CreateRecordFileDTO();
        createRecordDTO.setRecordName(recordName);
        createRecordFileDTO.setExtension(extension);
        createRecordDTO.setRecordFile(createRecordFileDTO);
        createRecordDTO.setCreateBy(createBy);

        return createRecordDTO;
    }

    public String getRecordName() {
        return recordName;
    }

    public void setRecordName(String recordName) {
        this.recordName = recordName;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public CreateRecordFileDTO getRecordFile() {
        return recordFile;
    }

    public void setRecordFile(CreateRecordFileDTO recordFile) {
        this.recordFile = recordFile;
    }
}
