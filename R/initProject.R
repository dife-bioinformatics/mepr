#'
#' @title Function to initiate a new project
#' @description The function will create a new analysis project with pre-specified folders and files
#' @details The function initiates folders and files that demonstrate good practise, such as R folder with R files
#' in them. Furthermore, for the data, data-raw, results/figures and results/tables folders dummy files have been added
#' to keep the folder structure when collaborating with others on GitHub because those folders have otherwise been set to
#' be ignored by git (see .gitignore file). In the README.md file a very brief description of the project should be provided.
#' @param path defaults to "home". The function uses the `fs::path_expand()` functionality to find the path
#' to the home directory using the tilde expression. When this argument is changed, it
#' should be replaced with an absolute path.
#' @param name name of the new R project (and folder)
#' @return A new project will be set up at the specified location (path + name) by the user.
#' @author Florian Schwarz
#' @import renv
#' @import fs
#' @import usethis
#' @export
#'

initProject <- function(path = "home", name = NULL){

  if(is.null(name)){
    stop("Please provide a path name for the project to be created.", call. = FALSE)
  }

  if(path == "home"){

      new_project_path <- paste0(fs::path_expand("~"),"/",name)

  } else {

      new_project_path <- paste0(path,"/", name)

  }

  if(fs::dir_exists(new_project_path)){
    stop(paste0("The path and name you have provided would overwrite an existing directory (", new_project_path , "). Setup aborted."), call. = FALSE)
  }

  #### sets up normal R Project
  usethis::create_project(new_project_path,
                          open = FALSE,
                          rstudio = TRUE)

  #### creates additional folder structure
  dir.create(paste0(new_project_path, "/data"))
  dir.create(paste0(new_project_path, "/data-raw"))
  dir.create(paste0(new_project_path, "/results"))
  dir.create(paste0(new_project_path, "/results/tables"))
  dir.create(paste0(new_project_path, "/results/figures"))

  #### copies over standardised R scripts for start
  file.copy(from = find_script("scripts/main.R"),
            to = paste0(new_project_path, "/R/main.R"))
  file.copy(from = find_script("scripts/01_dataManagement.R"),
            to = paste0(new_project_path, "/R/01_dataManagement.R"))
  file.copy(from = find_script("scripts/02_qualityCheck.R"),
            to = paste0(new_project_path, "/R/02_qualityCheck.R"))
  file.copy(from = find_script("scripts/custom_functions.R"),
            to = paste0(new_project_path, "/R/custom_functions.R"))

  #### copies over README.md file to have a small description of the project / repo
  file.copy(from = find_script("utils/README.md"),
            to = paste0(new_project_path, "/README.md"))

  #### copies over placeholder files to keep folder structure in place for GitHub
  #### for folders that should not be shared (e.g. results)
  file.copy(from = find_script("utils/placeholder.txt"),
            to = paste0(new_project_path, "/results/tables/placeholder.txt"))
  file.copy(from = find_script("utils/placeholder.txt"),
            to = paste0(new_project_path, "/results/figures/placeholder.txt"))
  file.copy(from = find_script("utils/placeholder.txt"),
            to = paste0(new_project_path, "/data/placeholder.txt"))
  file.copy(from = find_script("utils/placeholder.txt"),
            to = paste0(new_project_path, "/data-raw/placeholder.txt"))

  #### copies over initial config.yml file
  #### not sure if we should keep this but it is extremely helpful for checking out to improve figures
  #### could be used to determine the theme in ggplot e.g.
  #### could also be used in connection with how to flexibly merge plots together into one figure
  #### schriftarten
  file.copy(from = find_script("utils/config.yml"),
            to = paste0(new_project_path, "/config.yml"))


  #### modify .gitignore file
  gitignore_lines <- c("",
                       ".Renviron",
                       " ",
                       "data/*",
                       "!data/placeholder.txt",
                       "  ",
                       "data-raw/*",
                       "!data-raw/placeholder.txt",
                       "   ",
                       "results/plots/*",
                       "!results/plots/placeholder.txt",
                       "    ",
                       "results/tables/*",
                       "!results/tables/placeholder.txt")

  usethis::write_union(path = paste0(new_project_path, "/.gitignore"),
                       lines = gitignore_lines)


  #### initiate and fill standard .Renviron file

  r_environ_lines <- c("R_CONFIG_ACTIVE = 'default'")

  usethis::write_over(path = paste0(new_project_path, "/.Renviron"),
                      lines = r_environ_lines)

  r_profile_lines <- c("source(\"renv/activate.R\")",
                       "source(\"R/custom_functions.R\")")

  usethis::write_over(path = paste0(new_project_path, "/.Rprofile"),
                      lines = r_profile_lines)

  renv::init(project = new_project_path,
             load = FALSE)


}
