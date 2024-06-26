## Rtemplate

`Rtemplate` provides a folder structure and some template files to render an empty *RStudio* project as an *R* package project. 

The content is geared towards my personal needs. If you want to use it, and use it on a periodic basis, you should probably fork the repo, then add, delete, or tinker with the files in the `data-raw/template` depending on your situation, and finally run the (internal) function `prepare_zip` to renew the core zip file `inst/extdata/template.zip` before (re)installing the package.

I encourage every $R$ user to write packages (or at least start writing $R$ scripts as *RStudio* projects, ready to be *enhanced* as $R$ packages), there are many reasons to do that:
- to distribute $R$ code and documentation, from colleagues to anyone throughout the official *CRAN* repository or any `git` hub website.   
- to keep track of all the $R$ functions that you write and hopefully reuse
- to distribute [shiny](https://github.com/rstudio/shiny) apps to be deployed on your own [Shiny server](https://docs.posit.co/shiny-server/) website or to be run by other [RStudio IDE](https://posit.co/products/open-source/rstudio/) users
- to share (relatively small) data with some added functionality on them  


### *R* Package Worflow

- Create a [GitHub](https://github.com/lvalnegri/) repository whose name equals the package name. Remember that a package name must begin with a letter and contain only letters, numbers, and the dot `.` (you can not use dash `-` or underscore `_`, allegedly for old $S+$ consistency). In any case, the `dot` is discouraged to avoid confusion with classes' methods.

- Create a new `RStudio` project as *Version Control* \> *git* using the previous repository address (the project name can be different from the package name, but to avoid possible problems afterwards I'd keep the same writings for both).

- Call `Rtemplate::create_package()`

- Ignore *dot* files `.Rbuildignore` and `.Rproj`, then `commit`. 

- Modify as needed the package *metadata* stored in the `DESCRIPTION` file. Specifically, fill the following fields:
  - `Package` the name of the package
  - `Date` a date using the standard `yyyy-mm-dd` format
  - `Authors@R` There should be at list one `cre` (creator/maintainer, with the email) and one `aut` (author or big contributor), possibly the same person, `ctb` (small contributor) is optional (to list multiple authors use `c`). It is possible to add a `comment` field to each person.
  - `Title` must be less than 100 characters!!
  - `Version` try to follow the *major.minor.patch[.dev]* scheme (starting from `0.0.0.9000`)
  - `Description` should have at least two sentences (but you can just include a dot at the end to allow the `check` process to proceed)
  - `Imports` list all packages you use to build *exported* functionalities (these are the packages needed to be installed to run the package, you can set each package version)
  - `Suggests` list other packages used to build the package
  - `Remotes` list packages that should be installed from sources different from `CRAN` (in the form *owner/repo*)
  - `Depends` check the *R* version needed to run the package (be careful here not to constrain the user to update $R$ core unnecessarily)
  - `RoxygenNote` check installed `roxygen` version
  - `Roxygen: list(markdown = TRUE)` To turn on *markdown* support for the whole package
  - `URL` usually the package *GitHub* webpage
  - `BugReports` usually the package *GitHub* *Issues* webpage
  - `LazyData` you can drop this field if there's no data shared with the package. I always use `true`.
  - `LazyDataCompression: gzip` if you use, as I do, a different compression method than the default `xz`. You should always try which method is better for your use case. I use `gzip` because is faster,even if tends to be less efficient in saving space, but storage is usually much cheaper than time!


- Modify as needed the file `LICENSE` (keep the `MIT` licence if you can)

- Modify name and content of the file `pkgname.R` in `/R`, used to describe in detail the scope of the package

- `Commit` all of the above, then `push`

- As a general rule, create at least a secondary `dev` branch (or whatever name suits you best) to separate the code in *development* from the code deployed in *production*. It's possible to use either the GUI controls on the top right of the `Git` pane of the *RStudio* interface, or the native `git` shell as follows (prepend each command with `git`):
  - `branch dev` create the branch `dev`
  - `checkout dev` move to the `dev` branch, and work on your code
  - `add *` when files are ready, add them to *stage* area
  - `commit -m 'message'` commit with comment
  - `push -u origin dev` send committed files in `dev` branch to GitHub repo
  - `merge main` (while on `dev` branch) merge the current `main` branch to `dev` (so that potential conflicts can be solved in `dev` beforehand)
  - `checkout main` move to the `main` branch
  - `merge dev` merge the `dev` branch to the `main` branch (at a local level)
  - `push -u origin main` send committed files in `main` branch  to GitHub repo
  - go back to `checkout dev` and repeat obsessively

  Other `git` commands that could be useful are the following:
  - `git reset HEAD~1 --soft` remove the last commit, without modifying the files, in case you did *not* push yet
  - `...`

  As a curiosity, to calculate the total count of lines of *R* code in a package, run the following command from inside its project:
  ```
  git ls-files | grep 'R/.*\.R$' | xargs wc -l
  ```

- Modify (or delete if not needed) the file `zzz.R` in `/R` used as *storage* for any small piece of code, usually short *hashes* or *lookups* vectors of lists, that can not get organized anywhere else. 

- Modify (or delete if not needed) the file `zzzGV.R` to include all the columns of all `data.table`s directly mentioned in the package functions.

- Modify (or delete if not needed) the template file `data.R` in `/R` needed to export datasets. Be sure the datasets mentioned here have actually been *conveniently* saved in the `data` folder

- Write down your functions, storing them one for file, named in the same way as the function, if they are relatively few, or organized by *concept* files; it's completely up to you the way the functions are saved, as soon as they work as intended.

- Remember to add the dependencies used in the *roxygen* header with `@import` and `@importFrom`, or using the form `pkg::fun` in the function body for any external function call. All of the external packages mentioned must be also included in the `import` field in the `DESCRIPTION` file.

- Try not to postpone writing down the documentation, at least for the *exported* functions (the ones with a `@export` roxygen tag). Add ASAP at least a general description, meaning of parameters with `@param` and `@inheritParams`, the class and structure of the returned object(s), if any, with `@return`. Later you should also add one or more examples with `@examples`. 

- You can avoid all of the above docs if the function is not exported (the ones with no roxygen header or with a `@noRD` tag), but I suggest for your own sake you add at least some description of the reason the function is there at all. 

- Use `load_all()` as much as you can, after even any small change, to test the validity of what you've done, before it's too late...

- Run `document()` to renew `NAMESPACE` after any documentation `roxygen` tags changes

- When exporting datasets or other objects, first modify the file `include_datasets.R` in `/data-raw`, whose job is to convert the objects in *rda* format and save them in the `/data` sub folder, then add documentation to the `/R/data.R` script. Remember, if needed for sharing with people outside the *R* env, to save also a copy as text in *csv* format or *shapefile* if digital boundaries (but only to be uploaded on *GitHub*), eventually zipped if the original file is above your *hub* limits (100MB for *GitHub*).

- Files to be downloaded and copied *as is* when users install the package must be stored in the `inst` folder. Remember that once the package has been installed, these files can be accessed using the `system.file` function, which will look for a file setting the package folder (including its *library* folder) as *root*, so that:
  ```
  system.file('path', 'to', 'filename', package = 'pkgname')
  ``` 
  will return the file `<r_library>/<pkgname>/path/to/filename`. 
  
  It's good style to allows for sub folders inside the `inst` folder to avoid confusion with other files, but you should at all cost avoid *reserved* names like: 
  
  `build`, `data`, `demo`, `exec`, `help`, `html`, `inst`, `libs`, `Meta`, `man`, `po`, `R`, `src`, `tests`, `tools`, `vignettes`.
  
  In general, try to use a sub folder `extdata` to store *as is* files you don't know how to organize. 
  
  Finally, if files are related to a specific programming language use the name of that language as sub folder.

- When ready: 
  ```
  document()
  check()
  build()
  install('./pkgname')
  ```

### Keep also in mind that...

- The code in a package is run when the package is built, thus dependent among other things on the particular point in time and the specific hardware. Most if not all the code should therefore be written as a function, which is instead evaluated at run-time, with the package correctly installed on the specific machine. 
  > Any $R$ code outside of a function is suspicious and should be carefully reviewed.

- Be weary of any changes in the global env and undo all of it when exiting, or inform the end user if that's not possible. In particular:
  - try to never use in your functions the following statements: `library`, `require`, `setwd`, `source`, `Sys.setenv()`, `Sys.setlocale`, `set.seed`. 
  - modifications in `options` and `par` can be rewinded when exiting, using the `on.exit` statement, if the initial state is stored . 
  - temporary objects, like files and paths, usually created with respectively `tempfile` and `tempdir`, should be deleted using the `unlink` statement.

- There can not be non-ASCII characters in any code. Use instead the special Unicode escape format `\uxxxx`. 
