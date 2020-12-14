package com.voicehelp.backend.record.rating;

import com.voicehelp.backend.record.Record;
import com.voicehelp.backend.record.rating.dto.request.CreateRatingDTO;
import org.hibernate.annotations.GenericGenerator;

import javax.persistence.*;
import java.util.Calendar;
import java.util.Date;
import java.util.TimeZone;

@Entity
@Table(name = "record_rating")
public class Rating {

    @Id
    @Column(name = "rating_id")
    @GeneratedValue(generator = "uuid2")
    @GenericGenerator(name = "uuid2", strategy = "org.hibernate.id.UUIDGenerator")
    private String ratingId;

    @Column(name = "rate")
    private int rate;

    @JoinColumn(name = "record_id")
    @ManyToOne
    private Record record;

    @Column(name = "rating_user")
    private String createBy;

    @Column(name = "create_date")
    @Temporal(TemporalType.TIMESTAMP)
    private Date createDate;

    private Rating() {
    }

    public Rating(Record record, int rate, String createBy) {
        this.record = record;
        this.rate = rate;
        this.createBy = createBy;
        this.createDate = new Date(Calendar.getInstance(TimeZone.getTimeZone("UTC")).getTimeInMillis());
    }

}
