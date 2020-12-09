package com.voicehelp.backend.record.file;

import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;

@Table(name = "record_file")
@Entity
public class RecordFile {

    @Id
    @Column(name = "file_id")
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "org.hibernate.id.UUIDGenerator")
    private String fileId;

    @Column(name = "file_name")
    private String fileName;

    @Column(name = "file_extension")
    private String extension;

    @Column(name = "file_path")
    private String path;

    private RecordFile(){

    }

    public RecordFile(String fileName, String extension) {
        this(null, fileName, extension);
    }

    public RecordFile(String fileId, String fileName, String extension) {
        this.fileId = fileId;
        this.fileName = fileName;
        this.extension = extension;
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

    public String getPath() {
        return path;
    }
}
