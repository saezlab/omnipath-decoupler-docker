#/usr/bin/env Rscript

install.packages("devtools", repos = "https://cloud.r-project.org/")

library(devtools)

devtools::install_github("saezlab/OmnipathR")
devtools::install_github("jalvesaq/colorout")

install.packages("IRkernel", repos = "https://cloud.r-project.org/")

IRkernel::installspec(user = FALSE)
