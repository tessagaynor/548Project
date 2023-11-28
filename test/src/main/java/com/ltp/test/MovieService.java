package com.ltp.test;

import java.util.ArrayList;
import java.util.List;

import org.springframework.stereotype.Service;

@Service
public class MovieService {
    private final List<Movie> movies = new ArrayList<>();

    public List<Movie> getAllMovies() {
        return new ArrayList<>(movies);
    }

    public void addMovie(Movie movie) {
        validateRating(movie);
        movies.add(movie);
    }

    public void updateMovie(Movie updatedMovie) {
        validateRating(updatedMovie);
        movies.removeIf(m -> m.getId().equals(updatedMovie.getId()));
        movies.add(updatedMovie);
    }

    public void deleteMovie(Integer movieId) {
        movies.removeIf(m -> m.getId().equals(movieId));
    }

    private void validateRating(Movie movie) {
        if (movie.getRating() < 1 || movie.getRating() > 5) {
            throw new IllegalArgumentException("Rating must be between 1 and 5.");
        }
    }

    public Movie getMovieById(Integer movieId) {
        return movies.stream().filter(m -> m.getId().equals(movieId)).findFirst().orElse(null);
    }
}