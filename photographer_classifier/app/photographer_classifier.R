#!/usr/bin/env Rscript --vanilla

# Packrat is required to make sure right libraries are picked.
packrat::on()

# Library to Parse command line params.
library(optparse)
# For Pipe operators.
library(magrittr)
# Our Scoring (it automatically loads Model library).
library(PhotographerScoring)


# Specify the desired options in a list
# by default OptionParser will add an help option equivalent to
# make_option(c("-h", "--help"))
option_list <- list(
  make_option(c("-i", "--infile"), type="character", metavar="/path/to/input/data/file",
              help="Input data file path. Input file must be in CSV format. [Required]"),
  make_option(c("-o", "--outfile"), type="character", metavar="/path/to/output/file", default=NULL,
              help="Output file path. If it is supplied, output is written to this file as CSV, otherwise, printed on console."),
  make_option("--no-header", action="store_true", default=FALSE,
              help="Use this option if the input file does not contain header. Order of features must be maintained."),
  make_option("--model-id", type="character", default=NULL,
              help="Select model to use for scoring [value: gbm|rf|svm], [default: gbm]. Can be used to A/B test or switch out models in Production easily."),
  make_option(c("-v", "--verbose"), action="store_true", default=FALSE,
              help="Print extra output which could be helpful in debuging [default: %default]")
)

# Get command line options, if help option encountered print help and exit. Otherwise if options not found on command line then set defaults.
opt_parser <- OptionParser(option_list=option_list)
options <- parse_args(opt_parser)


## Validate input params.
if (is.null(options$infile)){
  print_help(opt_parser)
  stop("At least one argument must be supplied (input file path)", call.=FALSE)
}


## Read input data.
if (options$verbose == TRUE) {
  print(paste("Reading input CSV file", options$infile))
}
# Read input CSV file to a Dataframe.
new.data <- read.csv(file=options$infile, header=!options$`no-header`, sep=",")
# If noheader was set in CLI, explicitly set header.
if (options$`no-header` == TRUE) {
  col_headings <- c("member_guid", "lr_cc_usage", "lr_cl_usage", "lr_mo_usage", "storage_usage", "ps_usage", "stock_usage")
  names(new.data) <- col_headings
}
if (options$verbose == TRUE) {
  print(paste("Read", nrow(new.data), "rows."))
  head(new.data)
}


## Validate input data.
if (options$verbose == TRUE) {
  print("Validating input data.")
}
schema <- new.data[0,] %>% as.data.frame()
#str(schema)
# TODO - Add additional checks for vaildating input data.


## Predict.
if (options$verbose == TRUE) {
  print("Predicting output class for input data.")
}

# Supply model-id if provided. 
if (is.null(options$`model-id`)) {
  predicted <- classify(new.data)
} else {
  predicted <- classify(new.data, options$`model-id`)
}

if (options$verbose == TRUE) {
  predicted
}


## Generate output.
if (is.null(options$outfile)) {
  # Print to console if an output file path is NOT supplied.
  print("Output:")
  write.table(predicted, row.names=FALSE)
} else {
  # Write to output file otherwise.
  write.csv(predicted, file=options$outfile, row.names=FALSE)
  print(paste(nrow(predicted), "records written to", options$outfile))
}


packrat::off()