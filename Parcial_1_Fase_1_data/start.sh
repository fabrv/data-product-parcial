# build image
docker build -t my-db .

# create network
docker network create --driver bridge parcial_network

# start recently built container and rstudio
# and connect to network
docker run -it --network parcial_network -p 3306:3306 -d my-db --secure-file-priv=/parcial1
docker pull obedaeg/rstudio-mysql
docker run -it --network parcial_network -e PASSWORD=test123 -p 8787:8787 -d obedaeg/rstudio-mysql
docker run -it -p 3307:3306 -d 53492b7a4e01 --secure-file-priv=/parcial1