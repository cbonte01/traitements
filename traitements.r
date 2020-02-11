# Chargement des packages et librairies

#install.packages("RPostgreSQL", repos='http://cran.us.r-project.org')
library(RPostgreSQL)

# Connexion a la base de donnees Postgres

drv <- dbDriver("PostgreSQL")
con <- dbConnect(drv, dbname = "lizmap",
				host = "localhost", port = 5432,
				user = "postgres", password = "postgres")

# Recuperation des colonnes de la table en BDD

data_sel <- dbGetQuery(con,
	"
	SELECT fclass, occupation from poi84 where fclass IN (
	SELECT fclass FROM poi84 GROUP BY fclass HAVING COUNT(fclass)>100)
	")

# afficher les 10 premieres lignes de resultat de la requete
# head(data_sel, n=10)

# Analyse de variance
variance <- aov(occupation ~ fclass, data=data_sel)
summary(variance)
