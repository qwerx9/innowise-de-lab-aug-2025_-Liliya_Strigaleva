CREATE TABLE dim_users (
    user_sk SERIAL PRIMARY KEY,
    source_user_id INT UNIQUE,
    user_name VARCHAR(50) NOT NULL,
    user_age INT,
    region_sk INT REFERENCES dim_region(region_sk),
    subscription_sk INT REFERENCES dim_subscription(subscription_sk)
);

CREATE TABLE dim_songs (
    song_sk SERIAL PRIMARY KEY,
    source_song_id INT UNIQUE,
    song_name VARCHAR(50) NOT NULL,
    artist_sk INT REFERENCES dim_artist(artist_sk),
    album_name VARCHAR(50),
    duration INT CHECK (duration >= 0),
    genre_sk INT REFERENCES dim_genre(genre_sk)
);

CREATE TABLE dim_date (
    time_sk SERIAL PRIMARY KEY,
    source_time_id INT UNIQUE,
    date_add DATE NOT NULL,
    date_added_on_playlist DATE,
    time_of_day INT,
    time_of_week INT,
    time_of_month INT
);

CREATE TABLE dim_region (
    region_sk SERIAL PRIMARY KEY,
    source_region_id INT UNIQUE,
    region_name VARCHAR(50) NOT NULL
);

CREATE TABLE dim_subscription (
    subscription_sk SERIAL PRIMARY KEY,
    source_subscription_id INT UNIQUE,
    subscription_type VARCHAR(50) NOT NULL
);

CREATE TABLE dim_artist (
    artist_sk SERIAL PRIMARY KEY,
    source_artist_id INT UNIQUE,
    artist_name VARCHAR(50) NOT NULL,
    region_sk INT REFERENCES dim_region(region_sk),
    genre_sk INT REFERENCES dim_genre(genre_sk)
);

CREATE TABLE dim_genre (
    genre_sk SERIAL PRIMARY KEY,
    source_genre_id INT UNIQUE,
    genre_name VARCHAR(50) NOT NULL
);

--Средняя длительность прослушивания по жанрам

SELECT g.genre_name, ROUND(AVG(f.streaming_duration), 2) AS avg_duration
FROM fact_streaming f
JOIN dim_songs s ON f.song_sk = s.song_sk
JOIN dim_genre g ON s.genre_sk = g.genre_sk
GROUP BY g.genre_name
ORDER BY avg_duration DESC;

--Сравнение активность пользователей с подпиской и без неё

SELECT s.subscription_type, COUNT(*) AS total_streams
FROM fact_streaming f
JOIN dim_subscription s ON f.subscription_sk = s.subscription_sk
GROUP BY s.subscription_type
ORDER BY total_streams DESC;

--Топ 5 песен по прослушиваниям 

SELECT s.song_name, COUNT(*) AS play_count
FROM fact_streaming f
JOIN dim_songs s ON f.song_sk = s.song_sk
GROUP BY s.song_name
ORDER BY play_count DESC
LIMIT 5;

