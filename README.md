## Rtemplate

`Rtemplate` provides a folder structure and some template files to render an empty *RStudio* project as an *R* package project. 

The content is geared towards my personal needs. If you want to use it, and use it on a periodic basis, you should probably fork the repo, then add, delete, or tinker with the files in the `data-raw/template` depending on your situation, and finally run the single line call in the `data-raw/prepare_zip.R` file to renew the core zip file `inst/extdata/template.zip` before (re)installing the package.

### *R* Package Worflow

- Create a [GitHub](https://github.com/lvalnegri/) repository whose name equals the package name. Remember that a package name must begin with a letter and contain only letters, numbers, and the dot `.` (you then can't use dash `-` or underscore `_`). In any case, the dot is discouraged to avoid confusion with classes' methods.

- Create a new `RStudio` project as *Version Control* \> *git* using the previous repository address (the project name can be different from the package name, but to avoid possible problems afterwards I'd keep the same writings for both).

- Call `Rtemplate::create_package()`

- Ignore *dot* files `.Rbuildignore` and `.Rproj`, then commit. 

- Modify as needed the `DESCRIPTION` file. Specifically, write down:
  - `Package`
  - `Date`
  - `Title` must be less than 100 characters!!
  - `Version` try to follow the *major.minor.patch* scheme
  - `Description` should have at least two sentences (insert a dot somewhere)
  - `Imports` list all packages you use to build exported functionalities (these are the packages needed to be installed to run the package, you can set each package version)
  - `Suggests` list other packages used to build the package
  - `Remotes` list packages that should be installed from sources different from `CRAN` (in the form *owner/repo*)
  - `Depends` check the *R* version needed to run the package (be careful here not to constrain the user)
  - `RoxygenNote` check installed `roxygen` version

- Modify as needed the file `LICENSE` (keep the `MIT` licence if you can)

- Modify the file `pkgname.R` in `/R` to describe the scope of the package

- Modify (or delete if not needed) the file `zzz.R` in `/R` used as *Storage* for any piece of code that can get organized anywhere else. Similarly for the file `zzzGV.R` that defines all the columns of all `data.table`s directly mentioned in the package.

- Modify (or delete if not needed) the template file  `data.R` in `/R` needed to export datasets.

- Write down your functions, storing them one for files, if reatively few, or organized by concepts.

- Use `load_all()` as much as you can, after even any small change, to test the validity of what you've done, before it's too late...

- Try not to postpone writing down the documentation! description, parameters, examples

- When exporting datasets or other objects, modify the file `include_datasets.R` in `/data-raw` to convert the objects in *rda* format and save them in the `/data` subfolder. Remember, if needed for sharing to people outside of the *R* env, to save also a copy as text in *csv* format or *shapefile* if digital boundaries, but only to be uploaded on *GitHub*

- When ready: `check()`, `build()`, `install('./pkgname')`

### Keep also in mind that...

- The code in a package is run when the package is built, thus dependent among other things on the particular point in time and the specific hardware. Most if not all the code should therefore be written as a function, which is instead evaluated at run-time. Any $R$ code outside of a function is suspicious and should be carefully reviewed.

- Be weary of changes in the global env and undo any of it when exiting, or inform the end user if that's not possible. Try not to use: `library`, `require`, `setwd`, `source`, `options`, `par`, `Sys.setenv()`, `Sys.setlocale`, `set.seed`. Modifications in `options` and `par` can be rewinded storing the previous state and using `on.exit` at the end of the function. Temporary objects, like files and paths, can be *unlinked*.

- There can not be non-ASCII characters in any code. Use instead the special Unicode escape format `\uxxxx`. 
