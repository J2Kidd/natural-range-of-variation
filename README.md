#About NRV#

The goal of NRV is to help government personnel and consultants calculate baseline values for water quality parameters using the Natural Range of Variation (NRV) method developed by the Northwest Territories Cumulative Impact Monitoring Program (NWT CIMP). This NRV method calculates the lower and upper thresholds for individual water quality parameters using either the Tukey Inner Fence (TIF) method for parameters with ≤10% outlier and ≤77% results below the detection limit, or the Median±2MAD methods for parameters with ≤50% outlier and ≤50% results below the detection limit. 

The NRV package provides a the NRV function that reads in a data frame with water quality results for one or more sites and produces a table with the NRV thresholds and associated summary statistics, and boxplots for each water quality parameter and site. 

The NRV function requires the CCME table (found on git) to render the guidelines on each boxplot. Many CCME guidelines change based on site-specific water quality, such as hardness, so you must manually edit the CCME table. 

The NRV function requires you to format your data frame with specific column names. Please refer to the example data frame to see how to format yours. The function NRV_summ_df allows you to read in your data frame and identifty the matching columns and then produce a data frame that will work with the NRV function. 

The NRV function allows you to read in a single data frame with all site results, or individual data frames for each site. 


#Install Instructions#

Build instructions
Import dev tools, check and install the package from source code
> library("devtools")
> check()
> install()

How to use NRV in your project

> install.packages("NRV")

#Data Frame Formatting#
Your data frame **must** be formatted in a specific way. View example data frames "NRV_WC" and "NRV_TL" to see which columns are required and the type of data inputs for each column. The required columns are:
**Site**: A column that contains the labels for each individual waterbody that the NRV calculation will be generated for. **Note:** The NRV calculation is not run for individual sample locations, but on data collected from an individual water body or river reach. Ensure you have labelled your data appropriately and you identify the column with the water body label and not the sample location (unless there is only one sample location for each waterbody). **Ensure there are no duplicate samples** (i.e., results for the same parameter sampled on the same day) for any of the Site labels).
**Date**: A column that contains the date that the sample was collected.
**Parameter**: A column that contains the name of the parameter/variable that was analyzed (e.g., mercury). The name should include the fraction identifier (e.g., total, dissolved) if applicable. Fraction identifier should be placed after the parameter name and separated with an "_". For example: mercury_dissolved. **Note:** acceptable characters for parameter names are limited to: lower case letters and undersores ("_"). Ensure none of your parameter names include periods (".") or commas (","). **Units:** metal parameters need to be in ug/L (except mercury should be in ng/l), physical parameters and ions in mg/L, and hydrocarbons in ug/L to match with CCME guidelines. **Parameter Names**: refer to the CCME table to match the parameter names. The boxplot will only use the first part of the name (i.e., characters before the first "_") so will render the same guideline for different fractions of the same parameter (e.g., mercury_total and mercury_dissolved).
**Result**: A column with the analysis result. **Note:** This column should only contain the raw value of the result and not any units. This column should be empty/NA if the result was below the detection limit. 
**DL**: Detection Limit: A column that identifies the detection limit for the parameter. **Note:** The DL column should not include any units.
**RDC**: Result Detection Condition: A column that identifies if the result is below the detection limit. **Note:** If the result is below the detection limit, the identifier must read *BDL*. If the result was not below the detection limit then the column should  read *NUM*.


**Example Usage**
If you have two (or more) data frames with site data (i.e.,one data frame for each site) and want box plots generated for each parameter and all applicable guidelines rendered.
> NRV(list(WC,TL))

If you have only one data frame and you only want box plots generated for specific parameters
> NRV(list(WC),"ph","alkalinity_total")

If you have only one data frame and you only want box plots generated for specific parameters and you don't want to guideline rendered (e.g., the guideline is much higher than your max value so it skews your box plot)
> NRV(list(WC),"ph","alkalinity_total", renderGuidline=False)

If you have only one data frame and you do not want any box plots generated
> NRV(list(WC),"ph","alkalinity_total", generateplots=False)

**Known Issues**
1. Warnings on install

Warning messages:
1: replacing previous import ‘dplyr::filter’ by ‘stats::filter’ when loading ‘NRV’ 
2: replacing previous import ‘dplyr::lag’ by ‘stats::lag’ when loading ‘NRV’ 

These are completely normal, but will be address in a future version.

**About the CCME Data Frame**
*CCME water quality guidelines for the protection of aquatic life*

Access the CCME csv file in the NRV package's git repository here:
This file includes CCME guidelines for the majority of parameters. You may add any parameter you see is missing. You will have to edit the parameters that have site-specific guidelines (e.g., some are dependent on hardness or pH). Currently, you must access the CCME website (https://www.ccme.ca/en/resources/pollution_prevention.html#) for the site-specific calculations, but eventually the calculations will be included in the excel file. Once you have updated all of the guidelines, then upload the CCME file to R. The NRV function will pull the guideline data from this file to render the guideline on the box plots. Future versions will render the description of the guideline on the plot.


