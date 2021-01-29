
install.packages("DBI")
install.packages("RMySQL")

library(DBI)

library(RMySQL)

# Una vez que se tengan las librerias necesarias se procede a la lectura 
# (podría ser que necesites otras, si te las solicita instalalas y cargalas), 
# de la base de datos de Shiny la cual es un demo y nos permite interactuar con 
# este tipo de objetos. El comando dbConnect es el indicado para realizar la 
# lectura, los demás parametros son los que nos dan acceso a la BDD.

MyDataBase <- dbConnect(
  drv = RMySQL::MySQL(),
  dbname = "shinydemo",
  host = "shiny-demo.csa7qlmguqrf.us-east-1.rds.amazonaws.com",
  username = "guest",
  password = "guest")

# Si no se arrojaron errores por parte de R, vamos a explorar la BDD

dbListTables(MyDataBase)

# Ahora si se quieren desplegar los campos o variables que contiene la tabla 
# City se hará lo siguiente

dbListFields(MyDataBase, 'City')

# Para realizar una consulta tipo MySQL sobre la tabla seleccionada haremos lo 
# siguiente

DataDB <- dbGetQuery(MyDataBase, "select * from City")

# Observemos que el objeto DataDB es un data frame, por lo tanto ya es un objeto 
# de R y podemos aplicar los comandos usuales

class(DataDB)
head(DataDB)

dbListFields(MyDataBase, 'Country')




pop.mean <- mean(DataDB$Population)  # Media a la variable de población
pop.mean 

pop.3 <- pop.mean *3   # Operaciones aritméticas
pop.3

# Incluso podemos hacer unos de otros comandos de busqueda aplicando la 
# libreria dplyr
install.packages("dplyr")
library(dplyr)




pop50.mex <-  DataDB %>% filter(CountryCode == "MEX" ,  Population > 50000)   # Ciudades del país de México con más de 50,000 habitantes

head(pop50.mex)

unique(DataDB$CountryCode)   # Países que contiene la BDD

dbListFields(MyDataBase, 'CountryLanguage')

DataDB <- dbGetQuery(MyDataBase, "select * from CountryLanguage")
names(DataDB)
which.max(SP)

paises_español <- DataDB %>% filter(Language == "Spanish")
paises_español2 <- as.data.frame(SP) 

install.packages("ggplot2")
library(ggplot2)

paises_español2 %>% ggplot(aes( x = CountryCode, y=Percentage, fill = IsOfficial )) + 
  geom_bin2d() +
  coord_flip()

#Aqui probando



dbDisconnect(MyDataBase)
