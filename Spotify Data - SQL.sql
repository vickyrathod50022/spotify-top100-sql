select * from spotify;

-- How many total songs are available?
select count(name) from spotify;

-- How many unique artists are present?
select distinct count(artists) from spotify;

alter table spotify
change name song_name varchar(200);

-- List all songs by a specific artist.
select artists,song_name from spotify
order by artists;

-- Find all songs with energy greater than 0.8.
select song_name, energy from spotify
where energy >0.8;

-- Get all songs that have a time signature of 4.
select song_name, time_signature from spotify
where time_signature = 4;

-- How many songs does each artist have?
select artists, count(song_name) as "songs count" from spotify
group by artists;


-- What is the average danceability of all songs?
select avg(danceability) from spotify;

-- Which artist has released the most songs?
select artists, count(song_name) as "song count" from spotify
group by artists;

--  Which artists have more than 5 songs?
select artists, count(song_name) as "song_count" from spotify
group by artists
order by song_count desc
limit 5;

-- Find artists with consistently low loudness (average loudness < -6).
select artists, avg(loudness) as "avg_loudness" from spotify
group by artists
having avg_loudness < -6;

-- Find the top 3 most energetic songs per artist.
select * from (select energy, artists, song_name, dense_rank() over(partition by artists  order by energy desc) "Top10_energetic_songs" from spotify) tas
where Top10_energetic_songs < 4;

-- Show cumulative song duration per artist.
SELECT artists, SUM(duration_ms) AS total_duration_ms FROM spotify
GROUP BY artists
ORDER BY total_duration_ms DESC;

-- Bucket songs based on tempo (Slow, Medium, Fast).
select *, 
case
when tempo <100 then "Low"
when tempo <150 then "Medium"
when tempo <200 then "high"
else "NA"
end as "tempo_bucket"
from spotify;

