#' prepare_zip
#'
#' Create the template zip file in the `./inst/extdata` folder from the structure in `./data-raw/template/`
#'
#' @return None
#'
#' @author Luca Valnegri, \email{l.valnegri@datamaps.co.uk}
#' 
#' @importFrom utils unzip
#' 
#' @noRd
#' 
prepare_zip <- function(){
    system('rm ./inst/extdata/template.zip && cd ./data-raw/template/ && zip -r ../../inst/extdata/template.zip .')
    unzip('./inst/extdata/template.zip', list = TRUE)
}
