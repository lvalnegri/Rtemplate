system('rm ./inst/extdata/template.zip && cd ./data-raw/template/ && zip -r ../../inst/extdata/template.zip .')
unzip('./inst/extdata/template.zip', list = TRUE)
