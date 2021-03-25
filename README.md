# About NRV

The goal of the NRV package is to help government personnel and consultants calculate baseline values for water quality parameters using the Natural Range of Variation (NRV) method developed by the Northwest Territories Cumulative Impact Monitoring Program (NWT CIMP). This NRV method calculates the lower and upper thresholds for individual water quality parameters using either the Tukey Inner Fence (TIF) method for parameters with ≤10% outlier and ≤77% results below the detection limit, or the Median±2MAD methods for parameters with ≤50% outlier and ≤50% results below the detection limit. 

The NRV package provides the NRV function that can be executed on data frames that contain  water quality results for one or more sites (see Data Frame Formatting below). The NRV function produces a table with the NRV thresholds and associated summary statistics, and box plots for each water quality parameter. 

The NRV function requires the CCME table (found in the packages git repository's ExampleData folder) to render the applicable guidelines on each box plot. Many CCME guidelines change based on site-specific water quality, such as hardness, so you must manually edit the CCME table. 

The NRV function requires you to format your data frame with specific column names. Please refer to the example data frame to see how to format yours. 

The NRV function allows you to read in a single data frame with all site results, or individual data frames for each site. Sites are the water body that you want to run the NRV calculation for, and not necessarily the name of the sampling locations (e.g., you may have SampleSite1 and SampleSite2 for WaterBodyA). 

By default, the function generates box plots for each water quality parameter in your data frame, but you can select the particular parameters you want box plots generated for (see Example Usage below). You can also choose to not render the guidelines, which may be helpful if the guideline value is much higher than your highest result value (which would make it difficult to visually interpret the plot; see Example Usage). 

# Install Instructions

## Build instructions for creating the NRV package from source

1. Download the source code and open "NRV.Rproj" in RStudio
2. In the console type `library("devtools")` to download the development toolkit
3. In the console type `check()` to build the package
4. In the console type `install()` to install the package

## Using the NRV package from your project

1. First, be sure to follow the steps above to create and install the package in your local environment
2. After editing the CCME.csv guidelines file in the "ExampleData" folder to match your site-specific requirements, import the file. For details on the file itself, see the section below under the heading **About the CCME Data Frame**. To Import the file:
3.1 From the "Environment" tab in RStudio click "Import Dataset"
3.2 Select "From Text (readr)"
3.3 Navigate to the "ExampleData"" folder and select "CCME.csv"
3.4 Set the data type on the "value" column to be "Character"
3.5 Click "Import"
3.6 Celebrate with beer.

# Data Frame Formatting
Your data frame **must** be formatted in a specific way. View example data frames "NRV_WC" and "NRV_TL" located in the ExampleData folder of the NRV project's git repository to see which columns are required and the type of data inputs for each column. The required columns are:

1. **Site**: A column that contains the labels for each individual waterbody that the NRV calculation will be generated for. 

**Note:** The NRV calculation is not run for individual sample locations, but on data collected from an individual water body or river reach. Ensure you have labelled your data appropriately and you identify the column with the water body label and not the sample location (unless there is only one sample location for each waterbody). 

**Ensure there are no duplicate samples** (i.e., results for the same parameter sampled on the same day) for any of the Site labels).

2. **Date**: A column that contains the date that the sample was collected.

3. **Parameter**: A column that contains the name of the parameter/variable that was analyzed (e.g., mercury, calcium, ph). The name should include the fraction identifier (e.g., total, dissolved) if applicable. Fraction identifier should be placed after the parameter name and separated with an underscore (e.g., mercury_dissolved, alkalinity_total). 

**Note:** acceptable characters for parameter names are limited to: lower case letters and undersores. Ensure none of your parameter names include periods or commas. 

**Units:** metal parameters need to be in ug/L (except mercury should be in ng/l), physical parameters and ions in mg/L, and hydrocarbons in ug/L to match with CCME guidelines. 

**Parameter Names**: refer to the CCME table to match the parameter names. The boxplot will only use the first part of the name (i.e., characters before the first "_") so will render the same guideline for different fractions of the same parameter (e.g., mercury_total and mercury_dissolved).

4. **ResultRaw**: A column with the analysis result. 

**Note:** This column should only contain the raw value of the result and not any units. This column should be empty/NA if the result was below the detection limit. 

5. **ResultCalc**: A column with the analysis result and the value of half the detection limit if the result was below the detection limit. 

**Note:** This column should not be empty for any of the analyzed samples. 

6. **DL**: Detection Limit: A column that identifies the detection limit for the parameter. 

**Note:** The DL column should not include any units.

7. **RDC**: Result Detection Condition: A column that identifies if the result is below the detection limit. 

**Note:** If the result is below the detection limit, the identifier must read *BDL*. If the result was not below the detection limit then the column should  read *DET*.


## Example Usage
If you have two (or more) data frames with site data (i.e.,one data frame for each site) and want box plots generated for each parameter and all applicable guidelines rendered.
`NRV(list(WC,TL))`

If you have only one data frame and you only want box plots generated for specific parameters
`NRV(list(WC),list("ph","alkalinity_total"))`

If you have only one data frame and you only want box plots generated for specific parameters and you don't want to guideline rendered (e.g., the guideline is much higher than your max value so it skews your box plot)
`NRV(list(WC),list("ph","alkalinity_total"), renderGuidline=False)`

If you have only one data frame and you do not want any box plots generated
`NRV(list(WC),list("ph", "alkalinity_total"), generateplots=False)`

## Known Issues

All issues and future enhancements are tracked using Git issues: https://github.com/J2Kidd/natual-range-of-variation-source/issues

## About the CCME Data Frame
*CCME water quality guidelines for the protection of aquatic life*

Access the CCME csv file in the NRV package's git repository in the "ExampleData" folder.
This file includes CCME guidelines for the majority of parameters. You may add any parameter you see is missing. You will have to edit the parameters that have site-specific guidelines (e.g., some are dependent on hardness or pH). Currently, you must access the CCME website (https://www.ccme.ca/en/resources/pollution_prevention.html#) for the site-specific calculations, but eventually the calculations will be included in the excel file. Once you have updated all of the guidelines, then upload the CCME file to R. The NRV function will pull the guideline data from this file to render the guideline on the box plots. Future versions will render the description of the guideline on the plot.


