
test_that("find script", {

  package <- "AnalysisMEP"
  test_name <- "testproj-456"
  tmp_path <- fs::path_temp()
  tmp_path_to_proj <- AnalysisMEP::initProject(path = tmp_path, name = test_name)

  script_name1 <- "scripts/main.R"
  script_name2 <- "scripts/01_dataManagement.R"
  script_name3 <- "scripts/02_qualityCheck.R"
  script_name4 <- "scripts/custom_functions.R"
  script_name5 <- "utils/config.yml"
  script_name6 <- "utils/placeholder.txt"
  script_name7 <- "utils/README.md"

  testthat::expect_no_error(AnalysisMEP:::find_script(script_name = script_name1))
  testthat::expect_no_error(AnalysisMEP:::find_script(script_name = script_name2))
  testthat::expect_no_error(AnalysisMEP:::find_script(script_name = script_name3))
  testthat::expect_no_error(AnalysisMEP:::find_script(script_name = script_name4))
  testthat::expect_no_error(AnalysisMEP:::find_script(script_name = script_name5))
  testthat::expect_no_error(AnalysisMEP:::find_script(script_name = script_name6))
  testthat::expect_no_error(AnalysisMEP:::find_script(script_name = script_name7))

  #### Testing when pathing goes wrong to the scripts / files
  script_name_error <- "main.R"
  error_message <- testthat::expect_error(AnalysisMEP:::find_script(script_name = script_name_error))

  #### Testing that the error message is consistent
  testthat::expect_equal(error_message$message,
                         paste0("Could not find the file: ", script_name_error, ". Please contact the developer team."))


})



