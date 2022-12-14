################################################################
# Copy datasets from PUBLIC REPO (or else) to PACKAGE DATA DIR #
################################################################

library(data.table)

fn <- 'table_name'
y <- fread('./data-raw/csv/filename.csv')
assign(fn, y)
save( list = fn, file = file.path('data', paste0(fn, '.rda')), version = 3, compress = 'gzip' )
Rfuns::dd_dbm_do('db_name', 'w', fn, y)
