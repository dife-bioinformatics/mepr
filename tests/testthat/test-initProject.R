

test_that("project setup structure", {

  tmp_path_to_proj <- AnalysisMEP::initProject(location = fs::file_temp(pattern = "testproj"))
  tmp_path <- tail(stringr::str_split(string = tmp_path_to_proj,
                                      pattern = "/")[[1]], n = 1)

  file_structure_top <- fs::dir_ls(path = tmp_path_to_proj,
                                   all = TRUE)

  expect_elements <- c(".gitignore",
                       ".Renviron",
                       ".Rprofile",
                       "config.yml",
                       "data",
                       "data-raw",
                       "R",
                       "renv",
                       "renv.lock",
                       "results",
                       paste0(tmp_path, ".Rproj"))

  expected_paths <- paste0(tmp_path_to_proj, "/", expect_elements)


  testthat::expect_setequal(file_structure_top,
                            expected_paths)



})


