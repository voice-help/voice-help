package com.voicehelp.backend.record;

import com.voicehelp.backend.record.file.RecordFile;
import com.voicehelp.backend.record.rating.Rating;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.TimeZone;

@Entity
@Table(name = "record")
public class Record {

    @Id
    @Column(name = "record_id")
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "org.hibernate.id.UUIDGenerator")
    private String recordId;

    @JoinColumn(name = "file_id")
    @OneToOne
    private RecordFile file;

    @Column(name = "record_name")
    private String recordName;

    @Column(name = "create_user")
    private String createBy;

    @OneToMany(
            cascade = CascadeType.ALL,
            orphanRemoval = true
    )
    @JoinColumn(name = "record_id")
    private List<Rating> ratings;

    @Column(name = "create_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate;

    private Record() {
    }

    public Record(RecordFile file, String recordName, String createBy) {
        this(null, file, recordName, createBy);
    }

    public Record(String recordId, RecordFile file, String recordName, String createBy) {
        this.recordId = recordId;
        this.file = file;
        this.recordName = recordName;
        this.createBy = createBy;
        this.createDate = new Date(Calendar.getInstance(TimeZone.getTimeZone("UTC")).getTimeInMillis());
    }

    public void addRating(Rating rating) {
        ratings.add(rating);
    }

    public String getRecordId() {
        return recordId;
    }

    public RecordFile getFile() {
        return file;
    }

    public String getRecordName() {
        return recordName;
    }

    public String getCreateBy() {
        return createBy;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public List<Rating> getRatings() {
        return ratings;
    }

    public void removeRating(Rating rating){
        ratings.remove(rating);
    }
}
