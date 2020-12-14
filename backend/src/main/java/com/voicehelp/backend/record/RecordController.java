package com.voicehelp.backend.record;

import com.voicehelp.backend.record.dto.request.CreateRecordDTO;
import com.voicehelp.backend.record.dto.response.GetRecordCollectionDTO;
import com.voicehelp.backend.record.dto.response.GetRecordDTO;
import com.voicehelp.backend.record.rating.dto.request.CreateRatingDTO;
import org.springframework.core.io.InputStreamResource;
import org.springframework.data.domain.Sort;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.security.Principal;
import java.util.Objects;
import java.util.Optional;

@RestController
@RequestMapping("/api/v1/record")
public class RecordController {

    private final RecordService recordService;

    public RecordController(RecordService recordService) {
        this.recordService = recordService;
    }

    @RequestMapping(method = RequestMethod.POST, consumes = {MediaType.MULTIPART_FORM_DATA_VALUE})
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> postRecord(
            @RequestPart("file") MultipartFile file,
            @RequestParam("name") String recordName,
            @RequestParam("extension") String extension,
            Principal principal) throws IOException {

        recordService.createRecord(CreateRecordDTO.create(recordName, extension, principal.getName()), file);
        return new ResponseEntity<>(HttpStatus.OK);
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{id}")
    @ResponseBody
    public ResponseEntity<?> getRecordById(@PathVariable("id") String recordId) {
        GetRecordDTO result = recordService.getRecordById(recordId);
        return new ResponseEntity<>(result, HttpStatus.OK);
    }

    @RequestMapping(method = RequestMethod.GET)
    @ResponseBody
    public ResponseEntity<?> getAllRecords(@RequestParam(value = "page", required = false) Optional<Integer> pageVariable,
                                           @RequestParam(value = "pageSize", required = false) Optional<Integer> pageSizeVariable,
                                           @RequestParam(value = "sortBy", required = false) Optional<String> sortByVariable,
                                           @RequestParam(value = "sortDirection", required = false) Optional<String> sortDirectionVariable) {
        Integer page = pageVariable.orElse(0);
        Integer pageSize = pageSizeVariable.orElse(25);
        String sortBy = sortByVariable.orElse("recordName");
        Sort.Direction sortDirection = sortDirectionFromName(sortDirectionVariable);
        GetRecordCollectionDTO recordCollection = recordService.getAllRecords(page, pageSize, Sort.by(sortDirection, sortBy));
        return new ResponseEntity<>(recordCollection, HttpStatus.OK);
    }

    @RequestMapping(method = RequestMethod.GET, value = "/{id}/file")
    @ResponseBody
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> getRecordFileByRecordId(@PathVariable("id") String recordId, HttpServletRequest request) throws IOException {
        File recordFile = recordService.getRecordFileByRecordId(recordId);
        HttpHeaders headers = new HttpHeaders();
        headers.add("Cache-Control", "no-cache, no-store, must-revalidate");
        headers.add("Pragma", "no-cache");
        headers.add("Expires", "0");
        InputStream i = new FileInputStream(recordFile);
        InputStreamResource inputStreamResource = new InputStreamResource(i);
        System.out.println("The length of the file is : " + recordFile.length());

        var contentType = request.getServletContext().getMimeType(recordFile.getAbsolutePath());
        if (Objects.isNull(contentType)) {
            contentType = "application/octet-stream";
        }


        return ResponseEntity.ok()//
                .contentType(MediaType.parseMediaType(contentType))//
                .header(HttpHeaders.CONTENT_DISPOSITION, "attachment; filename=\""
                        + inputStreamResource.getFilename() + "\"")
                .body(inputStreamResource);
    }

    @RequestMapping(method = RequestMethod.POST, value = "/rating")
    @PreAuthorize("isAuthenticated()")
    public ResponseEntity<?> postRating(@RequestBody CreateRatingDTO ratingDTO, Principal principal) {
        recordService.createRating(ratingDTO, principal.getName());
        return new ResponseEntity<>(HttpStatus.OK);
    }

    private static Sort.Direction sortDirectionFromName(Optional<String> direction) {
        return direction.filter(item -> item.equals("desc"))//
                .map(dir -> Sort.Direction.DESC)
                .orElse(Sort.Direction.ASC);
    }
}
