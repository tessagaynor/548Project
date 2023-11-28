package com.ltp.test;

import java.time.LocalDate;
import java.util.concurrent.atomic.AtomicInteger;

import org.springframework.format.annotation.DateTimeFormat;

public class Movie {
    private static final AtomicInteger count = new AtomicInteger(0);
    private Integer id;
    private String title;
    private String genre;
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private LocalDate releaseDate;
    private int rating; // Ensure this is between 1 and 5 in your service logic

    public Movie() {
        this.id = count.incrementAndGet();
    }

    public static AtomicInteger getCount() {
        return count;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getGenre() {
        return genre;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public LocalDate getReleaseDate() {
        return releaseDate;
    }

    public void setReleaseDate(LocalDate releaseDate) {
        this.releaseDate = releaseDate;
    }

    public int getRating() {
        return rating;
    }

    public void setRating(int rating) {
        this.rating = rating;
    }

    
}
