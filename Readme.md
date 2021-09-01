# Parcial 1
- Fabrizzio Rivera Delcompare, 20170051
- Daniela Sofia Dominguez Novotny, 20180365
## Crear docker file de MySQL
```Dockerfile
# Traer la imagen de MySQL
FROM mysql:8.0.21

# Crear un directorio donde van a estar los archivos CSV
RUN mkdir -p /parcial/
WORKDIR /parcial

# Colocar como variable de ambiente las credenciales de la base de datos
# Con estas credenciales nos vamos a conectar después desde R
ENV MYSQL_ROOT_PASSWORD test123
ENV MYSQL_DATABASE parcial
ENV MYSQL_USER user
ENV MYSQL_PASSWORD test123

# Copiar los archivos CSV al contender
COPY 'data/academatica_video_stats.csv' /parcial
COPY 'data/academatica_videos.csv' /parcial
COPY 'data/academatica_videos_metadatas.csv' /parcial

# Correr data.sql que carga los datos a la base de datos
ADD data.sql /docker-entrypoint-initdb.d
```

## Construir imágen y correr todos los servicios
1. Construir imagen
```bash
docker build -t my-db .
```
2. Crear red
```bash
docker network create --driver bridge my_network
```
3. Iniciar todos los servicios
```bash
docker run -it --network my_network -p 3306:3306 -d my-db --secure-file-priv=/parcial1
docker pull obedaeg/rstudio-mysql
docker run -it --network my_network -e PASSWORD=password -p 8787:8787 -d obedaeg/rstudio-mysql
```
4. Validar el puerto de cada contenedor en la red
```bash
docker network inspect my_network
```

**De manera alterntiva tambien pueden correr todos los comandos dentro de este shell script:**
1. Para iniciar ejectuar el siguiente comando:
```bash
./start.sh
```
2. Navegar a `localhost:8787`
3. Ingresar las credenciales `rstudio` y `password`

## Codigo de R
1. Instalar dependencias
```r
install.packages("RMySQL")
```

2. Crear un nuevo archivo R Markdown con el siguiente contenido:
```r
library(RMySQL)

db_user <- 'user'
db_password <- 'test123'
db_name <- 'parcial1'
db_host <- '172.20.0.2' # usar el puerto obtenido del comando `docker network inspect my_network`
db_port <- 3306

## Conexión
mydb <-  dbConnect(RMySQL::MySQL(), user = db_user, password = db_password,
                   dbname = db_name, host = db_host, port = db_port)

## Videos
db_table <- 'videos'

s <- paste0("select * from ", db_table)
rs <- dbSendQuery(mydb, s)
videos <-  fetch(rs, n = -1)
on.exit(dbDisconnect(mydb))
```

Y listo!