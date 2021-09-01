FROM mysql:8.0.21
RUN mkdir -p /parcial/
WORKDIR /parcial
ENV MYSQL_ROOT_PASSWORD test123
ENV MYSQL_DATABASE parcial
ENV MYSQL_USER user
ENV MYSQL_PASSWORD test123
COPY 'data/academatica_video_stats.csv' /parcial
COPY 'data/academatica_videos.csv' /parcial
COPY 'data/academatica_videos_metadatas.csv' /parcial
ADD data.sql /docker-entrypoint-initdb.d
