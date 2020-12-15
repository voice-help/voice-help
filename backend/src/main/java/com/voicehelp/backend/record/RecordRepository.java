package com.voicehelp.backend.record;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.PagingAndSortingRepository;
import org.springframework.stereotype.Repository;

import java.util.Optional;

@Repository
public interface RecordRepository extends PagingAndSortingRepository<Record, String> {
    Optional<Record> findByRecordId(String recordId);

    @Query(value = " SELECT rf.file_name FROM record" +
            "        LEFT JOIN record_file AS rf ON rf.file_id = record.file_id" +
            "        WHERE record.record_id = :recordId", nativeQuery = true)
    Optional<String> findRecordFileNameByRecordId(String recordId);

    @Query(value = "SELECT AVG(record_rating.rate)" +
            " FROM record_rating" +
            " WHERE record_rating.record_id = :recordId", nativeQuery = true)
    Optional<Double> getRecordAverageRatingByRecordId(String recordId);
}
