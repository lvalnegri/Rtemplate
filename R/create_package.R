#' create_package
#'
#' Create folder structures and template files to render an empty \emph{RStudio} project an $R$ package project
#'
#' @param x root folder for the project
#'
#' @return None
#'
#' @author Luca Valnegri, \email{l.valnegri@datamaps.co.uk}
#' 
#' @importFrom utils unzip
#' 
#' @export
#' 
create_package <- function(x = './'){
    if(!dir.exists(x)){
        if(toupper(readline('The folder does not exist. Should I create it? (y/Y to continue) ')) != 'Y') return()
        dir.create(x)
    }
    unzip(system.file('extdata', 'template.zip', package = 'masteRtemplate'), exdir = x)
    if(!file.exists(file.path(x, '.gitignore'))) message('Remember you now need to create a git repo in ', x)
    if(!file.exists(file.path(x, paste0(basename(x), '.Rproj')))) message('Remember you now need to create an RStudio project in ', x)
}
