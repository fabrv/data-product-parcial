# Parcial 1
## Iniciar el servicio
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
install.packages("flexdashboard")
```

2. Crear un nuevo archivo R Markdown con el siguiente contenido:
```r
---
title: "Parcial 1"
output: 
  flexdashboard::flex_dashboard:
    orientation: rows
    vertical_layout: fill
    cache: TRUE
---

```{r setup, include=FALSE}
install.packages("flexdashboard")
install.packages("dplyr")
install.packages("ggplot2")
install.packages("lubridate")

library(flexdashboard)
library(dplyr)
library(ggplot2)
library(lubridate)
`` `

{r bases_de_datos}
db_user <- 'user'
db_password <- 'test123'
db_name <- 'parcial1'
db_host <- '172.20.0.2' # for local access
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

## Videos metadata
db_table <- 'videos_meta'

sM <- paste0("select * from ", db_table)
rsM <- dbSendQuery(mydbM, sM)
metadata <-  fetch(rsM, n = -1)
on.exit(dbDisconnect(mydbM))

## Videos Stats
db_table <- 'video_stats'

sS <- paste0("select * from ", db_table)
rsS <- dbSendQuery(mydbS, sS)
stats <-  fetch(rsS, n = -1)
on.exit(dbDisconnect(mydbS))
```