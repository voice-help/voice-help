package com.voicehelp.backend.record.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;
import com.voicehelp.backend.record.Record;
import com.voicehelp.backend.record.file.dto.response.GetRecordFileDTO;
import com.voicehelp.backend.record.file.RecordFile;

import java.util.Date;


public class GetRecordDTO {

    public static class Attributes {
        public static final String ID = "id";
        public static final String NAME = "name";
        public static final String USER = "user";
        public static final String CREATE_DATE = "create_date";
        public static final String RATING = "rating";
    }

    @JsonProperty(value = Attributes.ID, access = JsonProperty.Access.READ_ONLY)
    private String recordId;
    @JsonProperty(value = Attributes.NAME, access = JsonProperty.Access.READ_ONLY)
    private String recordName;
    @JsonProperty(value = Attributes.USER, access = JsonProperty.Access.READ_ONLY)
    private String userEmail;
    @JsonProperty(value = Attributes.CREATE_DATE, access = JsonProperty.Access.READ_ONLY)
    private Date createDate;
    @JsonProperty(value = GetRecordFileDTO.Attributes.OBJECT_ROOT, access = JsonProperty.Access.READ_ONLY)
    private GetRecordFileDTO createRecordFileDTO;
    @JsonProperty(value = Attributes.RATING, access = JsonProperty.Access.READ_ONLY)
    private double rating;

    public GetRecordDTO(Record recordEntity, double rating) {
        this.recordId = recordEntity.getRecordId();
        this.recordName = recordEntity.getRecordName();
        this.userEmail = recordEntity.getCreateBy();
        this.createDate = recordEntity.getCreateDate();
        final RecordFile recordFileEntity = recordEntity.getFile();
        this.createRecordFileDTO = new GetRecordFileDTO(recordFileEntity);
        this.rating = rating;
    }
}
