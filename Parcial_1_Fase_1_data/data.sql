USE parcial1;

CREATE TABLE videos (
  kind VARCHAR(100),
  etag VARCHAR(500),
  id VARCHAR(1000),
  content_id VARCHAR(45),
  content_date VARCHAR(45) 
);

CREATE TABLE video_stats (
  id TEXT(1000),
  viewCount INT(250),
  likeCount INT(250),
  dislikeCount INT(250),
  favoriteCount INT(250),
  commentCount INT(250)
);

CREATE TABLE videos_meta (
  video_id TEXT(1000),
  title VARCHAR(1000),
  link VARCHAR(1000)
);

LOAD DATA INFILE '/parcial1/academatica_videos.csv'
INTO TABLE videos
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/parcial1/academatica_video_stats.csv'
INTO TABLE video_stats
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA INFILE '/parcial1/academatica_videos_metadatas.csv'
INTO TABLE videos_meta
FIELDS TERMINATED BY '\,'
OPTIONALLY ENCLOSED BY '"'
LINES TERMINATED BY "\r\n"
IGNORE 1 ROWS;