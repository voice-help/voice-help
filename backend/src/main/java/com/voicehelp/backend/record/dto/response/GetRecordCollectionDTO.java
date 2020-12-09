package com.voicehelp.backend.record.dto.response;

import com.fasterxml.jackson.annotation.JsonProperty;

import java.util.List;

public class GetRecordCollectionDTO {
    static class Attributes{
        public static final String RECORDS = "records";
    }

    @JsonProperty(value = Attributes.RECORDS, access = JsonProperty.Access.READ_ONLY)
    private final List<GetRecordDTO> records;

    public GetRecordCollectionDTO(List<GetRecordDTO> records) {
        this.records = records;
    }

    public List<GetRecordDTO> getRecords() {
        return records;
    }
}
