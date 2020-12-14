package com.voicehelp.backend.record;

import com.voicehelp.backend.record.dto.request.CreateRecordDTO;
import com.voicehelp.backend.record.dto.response.GetRecordCollectionDTO;
import com.voicehelp.backend.record.dto.response.GetRecordDTO;
import com.voicehelp.backend.record.exception.RecordNotFoundException;
import com.voicehelp.backend.record.file.RecordFile;
import com.voicehelp.backend.record.file.RecordFileRepository;
import com.voicehelp.backend.record.file.dto.request.CreateRecordFileDTO;
import com.voicehelp.backend.record.rating.Rating;
import com.voicehelp.backend.record.rating.dto.request.CreateRatingDTO;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

@Service
public class RecordService {

    private RecordRepository recordRepository;
    private RecordFileRepository recordFileRepository;
    private final String STORAGE_DIR = "records";

    public RecordService(RecordRepository recordRepository, RecordFileRepository recordFileRepository) {
        this.recordRepository = recordRepository;
        this.recordFileRepository = recordFileRepository;
    }

    public void createRecord(CreateRecordDTO createRecordDTO, MultipartFile multipartFile) throws IOException {
        String fileName = storeRecordFile(multipartFile, createRecordDTO.getRecordFile().getExtension());
        final RecordFile recordFile = createRecordFile(createRecordDTO.getRecordFile(), fileName);
        final Record record = new Record(recordFile, createRecordDTO.getRecordName(), createRecordDTO.getCreateBy());
        recordRepository.save(record);
    }

    private RecordFile createRecordFile(CreateRecordFileDTO createRecordFileDTO, String fileName) {
        final RecordFile recordFile = new RecordFile(fileName, createRecordFileDTO.getExtension());
        return recordFileRepository.save(recordFile);
    }

    private String storeRecordFile(MultipartFile multipartFile, String extension) throws IOException {
        Path recordDirPath = Paths.get("/tmp", STORAGE_DIR);
        Path recordDir = Files.createDirectories(recordDirPath);
        Path recordFile = Paths.get(recordDir.toString(), String.format("%s.%s", generateFileName(), extension));
        multipartFile.transferTo(recordFile);
        return recordFile.getFileName().toString();
    }

    public GetRecordDTO getRecordById(String recordId) {
        Optional<Record> recordOptional = recordRepository.findByRecordId(recordId);
        Record record = recordOptional.orElseThrow(IllegalArgumentException::new);

        return new GetRecordDTO(record, getRecordRatingByRecordId(recordId));
    }

    public GetRecordCollectionDTO getAllRecords(int page, int size, Sort sort) {
        Page<Record> recordPage = recordRepository.findAll(PageRequest.of(page, size, sort));
        List<GetRecordDTO> records = recordPage.get()//
                .map((record) -> new GetRecordDTO(record, getRecordRatingByRecordId(record.getRecordId())))//
                .collect(Collectors.toList());
        return new GetRecordCollectionDTO(records);
    }

    public Double getRecordRatingByRecordId(String recordId){
        Optional<Double> recordRatingOptional = recordRepository.getRecordAverageRatingByRecordId(recordId);
        return recordRatingOptional.orElse(0.0);
    }

    public File getRecordFileByRecordId(String recordId) {
        Optional<String> recordFileNameByRecordId = recordRepository.findRecordFileNameByRecordId(recordId);
        String fileName = recordFileNameByRecordId.orElseThrow(RecordNotFoundException::new);
        Path recordDirPath = Paths.get("/tmp", STORAGE_DIR);
        Path recordFilePath = Paths.get(recordDirPath.toString(), fileName);
        return recordFilePath.toFile();
    }

    public void createRating(CreateRatingDTO ratingDTO, String userName) {
        Optional<Record> recordOptional = recordRepository.findByRecordId(ratingDTO.getRecordId());
        Record record = recordOptional.orElseThrow(RecordNotFoundException::new);
        Rating rating = new Rating(record, ratingDTO.getRating(), userName);
        record.addRating(rating);
        recordRepository.save(record);
    }

    private String generateFileName() {
        return UUID.randomUUID().toString();
    }

}
