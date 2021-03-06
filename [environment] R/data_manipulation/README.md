# Reference guide to data analysis
## Data munging (wrangling)

### Manipulation

A large amount of time we spend in data analysis usually concerns data manipulation. When we get our "hands dirty" with data analysis, one of the first things we realize is that data is never "clean". From the time of experimental design and data gathering to final analysis typos, different formatting, missing values, and several other issues are gathered on the way. Consequently, when we analyze data we have to spend time munging/wrangling that data in order to get to a stage where we may move forward in a more detailed analysis and be able to raise interpretations. Modeling, summarizing and plotting data depend on first having the data ready for so. R has several packages that might be used for this task.

### Inspection

Another important piece of every data analysis procedure is the diagnostics of variables and their relationships. Assessing summary statistics, plotting observations, and producing correlation matrices of variables can give us insights into sampling errors, data quality, and show us which sort of relationships are found among (predictor/response) variables. This step in data analysis may comprise up to 95% of the time we spend in data analysis (data collection may require almost 90-95% of the time for a whole study!). As Good & Hardy (2012) quoted in their book "Common Errors in Statistics (and How to Avoid Them)", it does not matter much the analysis and its reliability, if the data the analysis originated from is not of good quality in the first place. Therefore, it is very important to invest time in data inspection, not only to gather a better understanding of the data in question, but also to verify whether the data is of good quality and, if possible, "correct" it (ideally **post hoc** data correction is avoided, since data collection should be planed in advance to avoid any issue later on).

## Packages:
