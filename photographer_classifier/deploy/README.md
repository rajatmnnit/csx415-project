This file contains deployment and running instructions for Project photographer_classifier.


## Deployment
### Pre-requisites
1.    Must have R(3.4.4 tested, should work with higher versions) and RStudio installed.
2.    Must have packrat installed. If not, install using `install.packages('packrat')` inside RStudio.
3.    This package was built, tested and bundled on Mac. In theory, it should work on Windows or Unix as well. However, it has not been tested so.

### Steps to Deploy 
1.    Download the installer bundle from this link: https://drive.google.com/open?id=1dsLLmwLSA2zuaVlLtPRkimlSybEfrKtf
2.    From RStudio run `packrat::unbundle()` to deploy the app. It expectes two parameters, the first parameter is the location of the downloaded .tar.gz installer bundle file, and second parameter is the destination location under which you would like to deploy the application. Illustration:

  ```
  setwd("~/Downloads/")
  getwd()
  [1] "/Users/rajatj/Downloads"

  packrat::unbundle("photographer_classifier-2018-05-29.tar.gz", "./", restore=TRUE)

  - Untarring 'photographer_classifier-2018-05-29.tar.gz' in directory '/Users/rajatj/Downloads'...
  - Restoring project library...
  Installing BH (1.66.0-1) ... 
  	OK (downloaded binary)
  Installing DEoptimR (1.0-8) ... 
	OK (downloaded binary)
    ...
	OK (built source)
  Done! The project has been unbundled and restored at:
  - "/Users/rajatj/Downloads/photographer_classifier"
  ```

3.    If you see the success message mentioned above, you are all set!
4.    If you see packrat errors like

  ```
  Installing ggplot2 (2.2.1) ... 
  Error: package ‘ggplot2’ is required by ‘caret’ so will not be detached
  ```

detach packages manually and retry.

  ```
  detach("package:caret", unload=TRUE)  
  detach("package:ggplot2", unload=TRUE)  
  ```

If you are unbundelling in a clean installation, you should not see any of these errors.
    


## Execution

### Mac

1.    **Go to the directory** where you extracted the package contents. __Do not run it from any other directory__.
2.    A few test data sets have been provided to test-run the application under [tests/data](https://github.com/rajatmnnit/csx415-project/tree/master/photographer_classifier/tests/data) directory.
3.    **Run the app** - by using the command `app/photographer_classifier.R` from this directory. The app requires a few mandatory arguments. Run it with --help option to find more. Example:

  ```
  $ app/photographer_classifier.R --help
  Usage: app/photographer_classifier.R [options]
  
  
  Options:
  	-i /PATH/TO/INPUT/DATA/FILE, --infile=/PATH/TO/INPUT/DATA/FILE
  		Input data file path. Input file must be in CSV format. [Required]
  
  	-o /PATH/TO/OUTPUT/FILE, --outfile=/PATH/TO/OUTPUT/FILE
  		Output file path. If it is supplied, output is written to this file as CSV, otherwise, printed on console.
  
  	--no-header
  		Use this option if the input file does not contain header. Order of features must be maintained.
  
  	--model-id=MODEL-ID
  		Select model to use for scoring [value: gbm|rf|svm], [default: gbm]. Can be used to A/B test or switch out models in Production easily.
  
  	-v, --verbose
  		Print extra output which could be helpful in debuging [default: FALSE]
  
  	-h, --help
  		Show this help message and exit
  
  ```

4.    **Input File** - All the data points to be scored must be written to a CSV file and passed as argument with option -i. Example:

  ```
  $ app/photographer_classifier.R -i tests/data/test_data.csv 
  [1] "Output:"
  "member_guid" "class"
  "U001" "OTHER"
  "U002" "OTHER"
  "U003" "OTHER"
  "U004" "OTHER"
  "U005" "OTHER"
  "U006" "PHOTOGRAPHER"
  ```

In this case, the optput is generated on the console.

5.    **Order of columns** - inside CSV file does not matter as long as the headers are correct. Example:

  ```
  $ app/photographer_classifier.R -i tests/data/test_data_reordered.csv 
  [1] "Output:"
  "member_guid" "class"
  "U001" "OTHER"
  "U002" "OTHER"
  "U003" "OTHER"
  "U004" "OTHER"
  "U005" "OTHER"
  "U006" "PHOTOGRAPHER"
  ```

6.    **Missing Header** - If the header in the input file is missing, use --no-header option. However, if this case the order has to be strictly this: member_guid,lr_cc_usage,lr_cl_usage,lr_mo_usage,storage_usage,ps_usage,stock_usage. Example:

  ```
  $ app/photographer_classifier.R -i tests/data/test_data_noheader.csv --no-header
  [1] "Output:"
  "member_guid" "class"
  "U001" "OTHER"
  "U002" "OTHER"
  "U003" "OTHER"
  "U004" "OTHER"
  "U005" "OTHER"
  "U006" "PHOTOGRAPHER"
  ```

7.    **Output File** - Output from the app can be written to a CSV output file by providing -o option. Example:

  ```
  $ app/photographer_classifier.R -i tests/data/test_data.csv -o tests/output.csv
  [1] "6 records written to tests/output.csv"

  $ cat tests/output.csv 
  "member_guid","class"
  "U001","OTHER"
  "U002","OTHER"
  "U003","OTHER"
  "U004","OTHER"
  "U005","OTHER"
  "U006","PHOTOGRAPHER"
  ```

8.    **Overriding Model** - You can also override the default model at the runtime by providing the --model-id option. This can be very useful for running A/B tests using two fifferent kind of models. Example:

  ```
  $ app/photographer_classifier.R -i tests/data/test_data_A.csv 
  [1] "Output:"
  "member_guid" "class"
  "U001" "OTHER"
  "U003" "OTHER"
  "U005" "OTHER"

  $ app/photographer_classifier.R -i tests/data/test_data_B.csv --model-id=rf
  [1] "Output:"
  "member_guid" "class"
  "U002" "OTHER"
  "U004" "PHOTOGRAPHER"
  "U006" "PHOTOGRAPHER"
  ```

### Windows
Currently the application is only tested on Mac. However, it should be able to run on Windows as well using 
  ```
  Rscript app\photographer_classifier.R ...
  ```
