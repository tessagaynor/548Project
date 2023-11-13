-- Create a database
CREATE DATABASE MovieDatabase;
USE MovieDatabase;

-- Create a table for genres
CREATE TABLE Genres (
    GenreID INT PRIMARY KEY,
    GenreName VARCHAR(50) NOT NULL
);

-- Insert some sample genres
INSERT INTO Genres (GenreID, GenreName) VALUES
(1, 'Action'),
(2, 'Drama'),
(3, 'Comedy'),
(4, 'Science Fiction'),
(5, 'Thriller');

-- Create a table for movies
CREATE TABLE Movies (
    MovieID INT PRIMARY KEY,
    Title VARCHAR(255) NOT NULL,
    ReleaseDate DATE,
    GenreID INT,
    FOREIGN KEY (GenreID) REFERENCES Genres(GenreID)
);

-- Create a table for ratings
CREATE TABLE Ratings (
    RatingID INT PRIMARY KEY,
    MovieID INT,
    Rating INT CHECK (Rating >= 1 AND Rating <= 5),
    Reason VARCHAR(255),
    FOREIGN KEY (MovieID) REFERENCES Movies(MovieID)
);

-- Insert some sample movies
INSERT INTO Movies (MovieID, Title, ReleaseDate, GenreID) VALUES
(1, 'Inception', '2010-07-16', 4),
(2, 'The Shawshank Redemption', '1994-09-23', 2),
(3, 'The Dark Knight', '2008-07-18', 1);

-- Insert some sample ratings
INSERT INTO Ratings (RatingID, MovieID, Rating, Reason) VALUES
(1, 1, 5, 'Mind-bending plot and amazing visuals'),
(2, 2, 4, 'Compelling story and great performances'),
(3, 3, 5, 'Epic superhero film with a gripping storyline');

-- Create a stored procedure to add or delete a movie
DELIMITER //

CREATE PROCEDURE AddOrDeleteMovie(
    IN action VARCHAR(10),
    IN movieTitle VARCHAR(255),
    IN releaseDate DATE,
    IN genreID INT,
    IN rating INT,
    IN reason VARCHAR(255),
    INOUT movieID INT
)
BEGIN
    DECLARE genreExists INT;

    -- Check if the specified genre exists
    SELECT COUNT(*) INTO genreExists FROM Genres WHERE GenreID = genreID;

    IF genreExists = 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid genre ID. Genre does not exist.';
    END IF;

    IF action = 'ADD' THEN
        -- Add a new movie
        INSERT INTO Movies (Title, ReleaseDate, GenreID) VALUES (movieTitle, releaseDate, genreID);
        SET movieID = LAST_INSERT_ID();

        -- Add a rating for the movie
        INSERT INTO Ratings (MovieID, Rating, Reason) VALUES (movieID, rating, reason);

    ELSEIF action = 'DELETE' THEN
        -- Delete a movie and its associated ratings
        DELETE FROM Ratings WHERE MovieID = movieID;
        DELETE FROM Movies WHERE MovieID = movieID;

    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Invalid action. Use ADD or DELETE.';
    END IF;
END //

DELIMITER ;
