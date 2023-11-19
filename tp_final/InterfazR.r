library(DBI)
library(RPostgres)
library(dplyr)

dsn_database <- "DVD_rental"
dsn_hostname <- "localhost"
dsn_port <- "5432"
dsn_uid <- "postgres"
dsn_pwd <- "alumno"

con <- dbConnect(
    RPostgres::Postgres(),
    host = dsn_hostname,
    port = dsn_port,
    dbname = dsn_database,
    user = dsn_uid,
    password = dsn_pwd
)

res <- dbSendQuery(con,
"SELECT co.country_id, co.country, COUNT(*) AS total_clientes
FROM customer AS cl
JOIN address AS a ON cl.address_id = a.address_id
JOIN city AS ct ON a.city_id = ct.city_id
JOIN country AS co ON ct.country_id = co.country_id
GROUP BY co.country_id, co.country
ORDER BY total_clientes DESC;"
)
clientes <- dbFetch(res)
dbClearResult(res)

clientes$total_clientes <- as.numeric(clientes$total_clientes)

paises_de_mas_clientes <- as.factor(
    c(
        rep("India", clientes[1, 3]),
        rep("China", clientes[2, 3]),
        rep("United States", clientes[3, 3]),
        rep("Japan", clientes[4, 3]),
        rep("Mexico", clientes[5, 3])

    )
)

barplot(
    table(paises_de_mas_clientes),
    main = "País de origen de la mayoría de clientes",
    col = c("#65b9fe", "#64fed7", "#ab8cfe", "#eef677", "#ffae57"),
    ylim = c(0, 70),
    ylab = "Clientes",
    border = "#ffffff00"
)

grid(nx = NA, ny = NULL, lwd = 1, lty = 1, col = "gray")

barplot(
    table(paises_de_mas_clientes),
    main = "País de origen de la mayoría de clientes",
    col = c("#65b9fe", "#64fed7", "#ab8cfe", "#eef677", "#ffae57"),
    ylim = c(0, 70),
    border = "#ffffff00",
    ylab = "Clientes",
    add = TRUE
)