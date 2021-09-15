# pull database image
docker pull fabrv/my-db

# create network
echo "creating network"
docker network create --driver bridge my_network

# start recently built container and rstudio
# and connect to network
echo "starting"
docker run -it --network my_network -p 3306:3306 -d fabrv/my-db --secure-file-priv=/parcial1
docker pull obedaeg/rstudio-mysql
docker run -it --network my_network -e PASSWORD=password -p 8787:8787 -d obedaeg/rstudio-mysql