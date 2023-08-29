.libPaths(c("/usr/local/lib/R/site-library", "/usr/local/lib/R/library"))
source("R/utils_messages.R")

chap("Step 1: Download input data")
source("in/get_data.R")

chap("Step 2: Combine input data")
source("scripts/01_prepare_mun_data.R")

chap("Step 3: Rebuild vignette and generate output files")
system('quarto render "notebooks/Modeling the French presidential elections of 2022 with CoDa tools.qmd"')
