#About NRV#

The goal of NRV is to help government personnel and consultants calculate baseline values for water quality parameters using the Natural Range of Variation (NRV) method developed by the Northwest Territories Cumulative Impact Monitoring Program (NWT CIMP). This NRV method calculates the lower and upper thresholds for individual water quality parameters using either the Tukey Inner Fence (TIF) method for parameters with ≤10% outlier and ≤77% results below the detection limit, or the Median±2MAD methods for parameters with ≤50% outlier and ≤50% results below the detection limit. 

The NRV package provides a the NRV function that reads in a data frame with water quality results for one or more sites and produces a table with the NRV thresholds and associated summary statistics, and boxplots for each water quality parameter and site. 

The NRV function requires the CCME table (found on git) to render the guidelines on each boxplot. Many CCME guidelines change based on site-specific water quality, such as hardness, so you must manually edit the CCME table. 

The NRV function requires you to format your data frame with specific column names. Please refer to the example data frame to see how to format yours. The function NRV_summ_df allows you to read in your data frame and identifty the matching columns and then produce a data frame that will work with the NRV function. 

The NRV function allows you to read in a single data frame with all site results, or individual data frames for each site. 


#Install Instructions#

install.packages("NRV")

#Data Frame Formatting#
Your data frame must be formatted in a specific way. View example data frame "WC"" for an example of the minimum data requirements (i.e., the specific columns/data your data frame must contain). The columns do not need to have these exact headings, but **must** contain the required data. These columns/data are:
**Site**: A column that contains the labels for each individual waterbody that the NRV calculation will be generated for. **Note:** The NRV calculation is not run for individual sample locations, but on data collected from an individual water body or river reach. Ensure you have labelled your data appropriately and you identify the column with the water body label and not the sample location (unless there is only one sample location for each waterbody). **Ensure there are no duplicate samples** (i.e., results for the same parameter sampled on the same day) for any of the Site labels).
**Date**: A column that contains the date that the sample was collected.
**Parameter**: A column that contains the name of the parameter/variable that was analyzed (e.g., mercury).
**Fraction**: A column that identifies the fraction that was analyzed (e.g., total, dissolved). 
**Result**: A column with the analysis result. **Note:** This column should only contain the raw value of the result and not any units. This column should be empty/NA if the result was below the detection limit. 
**Detection Limit**: A column that identifies the detection limit for the parameter. 
**Detection Condition**: A column that identifies if the result is below the detection limit. **Note:** If the result is below the detection limit, the identifies must read *below detection limit*. See example 1 for converting your original identifier to the required format. If the result was not below the detection limit then the column should be blank.


##Example: Data frame formatting with function NRV_summ_df##
I read in my data frame "WC_original" and check that is has all of the required columns/data for the NRV_summ_df function:
**Site**: Column MonitoringLocationName has the label for the waterbody I want to generate the NRV calculation for.
**Date**: Column Activity Start Date has the date the samples were collected.
**Parameter**: Column CharacteristicName has the names for each of the parameters that were analyzes.
**Fraction**: Column ResultSampleFraction identifies the fraction that was analyzed.
**Detection Limit**: Column ResultDetectionQuantitationLimitMeasure has the detection limit for each parameter. 
**Detection Condition**: Column ResultDetectionCondition identifies if the result was below the detection limit. **Warning** This column uses the identifier *below detection/quantification limit* and needs to be converted to *below detection limit* prior to running the NRV_summ_df function
**Result**: Column ResultValue has the results.

Step 1: Change to labels in the ResultDetectionCondition column from *below detection/quantification limit* to *below detection limit*
library("dplyr"")
WC<-WC_original %>%
+     mutate(DetectionCondition=ifelse(ResultDetectionCondition=='below detection/quantification limit', "below detection limit", NA))

Step 2: Convert the WC data frame to one that can be used by the NRV function
#The function requires that you identify each of the appropriate columns from your original data frame
library("NRV")
WC_NRV<-NRV_summ_df(WC_original$S)


In addition, and example data frame "WCTL" to see how your data frame columns have to be formatted before running the NRV function

If your data frame has the minimum data requirements presented in example data frame "WC" then you can use the function "NRV_summ_df" to format your data frame for the NRV analysis. The "NRV_summ_df" function will then generate a data frame that has the same columns as "WCTL" 


#Data frame formatting notes#
##Units##
metals parameters must be in ug/L (except methylmercury [ng/L]), physical parameters and ions in mg/L, hydrocarbons in ng/L

##Parameter names##
must match exactly as presented in the CCME guideline (if applicable guideline exists)

##RDC##
Column represents "Result Detection Condition", identifies if the result was below the detection limit. Must be either BDL for Below Detection Limit or NUM for raw value (i.e., the result was not below the detection limit)

**Example Usage**
> NRV(list(WCTL))

**Known Issues**
1. Warnings on install

`Warning: replacing previous import ‘dplyr::recode’ by ‘expss::recode’ when loading ‘NRV’
Warning: replacing previous import ‘dplyr::first’ by ‘expss::first’ when loading ‘NRV’
Warning: replacing previous import ‘dplyr::vars’ by ‘expss::vars’ when loading ‘NRV’
Warning: replacing previous import ‘dplyr::last’ by ‘expss::last’ when loading ‘NRV’
Warning: replacing previous import ‘dplyr::na_if’ by ‘expss::na_if’ when loading ‘NRV’
Warning: replacing previous import ‘dplyr::compute’ by ‘expss::compute’ when loading ‘NRV’
Warning: replacing previous import ‘dplyr::between’ by ‘expss::between’ when loading ‘NRV’
Warning: replacing previous import ‘dplyr::contains’ by ‘expss::contains’ when loading ‘NRV’
Warning: replacing previous import ‘expss::vars’ by ‘ggplot2::vars’ when loading ‘NRV’
Warning: replacing previous import ‘expss::regex’ by ‘stringr::regex’ when loading ‘NRV’
Warning: replacing previous import ‘expss::fixed’ by ‘stringr::fixed’ when loading ‘NRV’
Warning: replacing previous import ‘expss::nest’ by ‘tidyr::nest’ when loading ‘NRV’
Warning: replacing previous import ‘expss::contains’ by ‘tidyr::contains’ when loading ‘NRV’`

These are completely normal, but will be address in a future version.

**About the CCME dataframe**
