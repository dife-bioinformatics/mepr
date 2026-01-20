
# Idea Section



## Project Initialisation

### Requirements
- should be standardised
- should prevent risk of disclosing confidential information (data, figures etc.)


### Nice to have
- important packages already delivered with initiation of project e.g. tidyverse (?)
- classic data management and / or data quality checks as script => or should this be a function?


## Analyses


## Figures

### config file
- using config file create default settings for good ggplots?
=> e.g. themes / font / sizes could be stored here
- when you want to try out a competing setting for ggplot, just add another config below and change parameters as intended
=> advantage of not losing original setting because that is saved in another (or default) configuration in the same file + not having
to copy-paste code trying out different sizes etc
=> disadvantage of having to change .Renviron file and re-load session (but this is typically just a couple of seconds)

### exclusions
- standardised figure for inclusions/exclusions
- has to be combined with a function (n exclusion reasons)
- metadata on study population for every collection event and type of study (full-cohort, case-cohort etc.) could be provided with the package as metadata

- 
