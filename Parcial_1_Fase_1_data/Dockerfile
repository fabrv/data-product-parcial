FROM mysql:8.0.21
RUN mkdir -p /parcial1/
WORKDIR /parcial1
ENV MYSQL_ROOT_PASSWORD test123
ENV MYSQL_DATABASE parcial1
ENV MYSQL_USER user
ENV MYSQL_PASSWORD test123
COPY 'data/academatica_video_stats.csv' /parcial1
COPY 'data/academatica_videos.csv' /parcial1
COPY 'data/academatica_videos_metadatas.csv' /parcial1
ADD data.sql /docker-entrypoint-initdb.d
