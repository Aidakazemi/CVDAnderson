[![Build Status](https://travis-ci.org/resplab/CVDAnderson.svg?branch=master)](https://travis-ci.org/resplab/CVDAnderson)
[![CRAN Status](https://www.r-pkg.org/badges/version/CVDAnderson)](https://cran.r-project.org/web/packages/CVDAnderson/index.html)
[![Project Status: Active – The project has reached a stable, usable state and is being actively developed.](https://www.repostatus.org/badges/latest/active.svg)](https://www.repostatus.org/#active)

# CVDAnderson

R package for the prediction of developing Cardiovascular Disease (CVD) risk using Systolic Blood Pressure (SBP) and Diastolic Blood Pressure (DBP) described in [https://www.sciencedirect.com/science/article/pii/000287039190861B](https://www.sciencedirect.com/science/article/pii/000287039190861B). 

## Installation

The latest stable version can be downloaded from CRAN:  
`install.packages ('CVDAnderson')`

Alternatively, you can download the latest development version from GitHub:

```
install.packages("devtools")
devtools::install_github("resplab/CVDAnderson")
```

# Web App for CVDAnderson 

CHDWilson is also available as web app, accessible at [http://resp.core.ubc.ca/ipress/CVDAnderson](http://resp.core.ubc.ca/ipress/CVDAnderson)

# Cardiovascular Disease (CVD) Prediction Model

To get a prediction for Cardiovascular Disease (CVD), you will need to pass in patient's risk factors. For example: 

```
predictCVD (gender = 1, age = 33, Tchol = 230, HDLchol = 48, SBP = 135, DBP = 88, diabetes = 1, smoker = 1, ECG_LVH = 0, t = 10)
```

The ***predictCVD()*** function returns the risk Cardiovascular Disease (CVD) sing Systolic Blood Pressure (SBP) and Diastolic Blood Pressure (DBP).
The prediction based on SBP is recommended in the reference paper because the log likelihoods are slightly higher. The differences in otucome are not significant when comapring SBP estimation compared to DBP except for Stroke and to some extend CVD (which includes stroke). Definitions of risk factors and outcomes are based on Framingham study standard. Time interval of 4 to 12 years are recommended.

## Cloud-based API Access
The [PRISM platform](http://prism.resp.core.ubc.ca) allows users to access CFMortality through the cloud. A MACRO-enabled Excel-file can be used to interact with the model and see the results. To download the PRISM Excel template file for CFMortality please refer to the [PRISM model repository](http://resp.core.ubc.ca/ipress/prism).


## Citation

Please cite: 

```
Anderson, K. M., Odell, P. M., Wilson, P. W., & Kannel, W. B. (1991). Cardiovascular disease risk profiles. American heart journal, 121(1), 293-298.
```
