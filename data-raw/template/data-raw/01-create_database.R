#############################################
# Create databases e tables in MySQL server #
#############################################

library(Rfuns)

dbn <- 'insert-here-database-name'
create_db(dbn)

## TABLE <table name> -----------------
x <- "
    `` INT UNSIGNED AUTO_INCREMENT NOT NULL,
    `` CHAR(12) NOT NULL,
    `` CHAR(7) NULL DEFAULT NULL,
    `` VARCHAR(50) NOT NULL,
    `` DECIMAL(10,8) NOT NULL,
    `` TINYINT UNSIGNED NOT NULL,
    PRIMARY KEY (``, ``),
    UNIQUE KEY `nome_key` (``),
    KEY `nome_key` (``)
"
create_table_db(dbn, 'table_name', x)


## END --------------------------------
rm(list = ls())
gc()
