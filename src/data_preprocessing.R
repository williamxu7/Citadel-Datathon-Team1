# authors: Haoyuan Li, Jingyi Tang, William Xu
# date: 2021-02-20

"This script preprocess the missing data from the original dataset owid-covid-data using the mice pacakge in R.

Usage: data_preprocessing.R --file_path=<file_path> --file_output=<file_out>

Options:
--file_path=<file_path>   Path to the data file
--file_output=<file_out>  Path to the output processed data file (eg., ../data/preprocessed/owid_world.csv)
" -> doc

library(tidyverse)
library(mice)
library(docopt)

opt <- docopt(doc)

main <- function(file_path, file_out) {
  
  # read in data
  data <- read_csv(file_path)
  
  # set a random seed
  set.seed(123)
  
  # multiple imputation
  owid_mult_imp <- mice(data, method = "cart", m = 10, printFlag = FALSE, seed = 10)
  owid_data <- complete(owid_mult_imp, 3)
  
  # Export the dataframe out to the customized location
  write_csv(owid_data, file_out)
}

main(opt$file_path, opt$file_out)