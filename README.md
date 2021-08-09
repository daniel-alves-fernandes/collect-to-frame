# Collect to Frame
Collect to Frame puts the information of the active collection onto a new Stata frame


## Example

```stata
sysuse auto

collect: reg mpg price

collect_to_frame results
frame change results
```

Frame `results` contains the following data:

cmdset|coleq|colname|program_class|result|result_type|value
--|--|--|--|--|--|--
1|mpg|_cons|eclass|_r_b|matrix|26.96417352322909
1|mpg|_cons|eclass|_r_df|matrix|72
1|mpg|_cons|eclass|_r_lb|matrix|24.18538092248592
1|mpg|_cons|eclass|_r_p|matrix|3.09403642424e-30
1|mpg|_cons|eclass|_r_se|matrix|1.393952037656927
1|mpg|_cons|eclass|_r_ub|matrix|29.74296612397225
1|mpg|_cons|eclass|_r_z|matrix|19.34368815770215
1|mpg|price|eclass|_r_b|matrix|-.0009191630534643
1|mpg|price|eclass|_r_df|matrix|72
1|mpg|price|eclass|_r_lb|matrix|-.0013262608947075
1|mpg|price|eclass|_r_p|matrix|.0000254613120514
1|mpg|price|eclass|_r_se|matrix|.0002042163438808
1|mpg|price|eclass|_r_ub|matrix|-.000512065212221
1|mpg|price|eclass|_r_z|matrix|-4.500927966866257
1|||eclass|F|scalar|20.25835256291883
1|||eclass|N|scalar|74
1|||eclass|cmd|macro|
1|||eclass|cmdline|macro|
1|||eclass|depvar|macro|
1|||eclass|df_m|scalar|1
1|||eclass|df_r|scalar|72
1|||eclass|estat_cmd|macro|
1|||eclass|ll|scalar|-225.2210496559824
1|||eclass|ll_0|scalar|-234.3943376482347
1|||eclass|marginsok|macro|
1|||eclass|model|macro|
1|||eclass|mss|scalar|536.5418070864664
1|||eclass|predict|macro|
1|||eclass|properties|macro|
1|||eclass|r2|scalar|.2195828561874973
1|||eclass|r2_a|scalar|.2087437291901014
1|||eclass|rank|scalar|2
1|||eclass|rmse|scalar|5.146354767606811
1|||eclass|rss|scalar|1906.917652372993
1|||eclass|title|macro|
1|||eclass|vce|macro|

Specify option `labels` to use the labels of dimension levels instead of their names:

```stata
collect_to_frame results2, labels
frame change results2
```

Frame `results2` contains the following data:

cmdset|coleq|colname|program_class|result|result_type|value
--|--|--|--|--|--|--
1|Mileage (mpg)|Intercept|eclass|Coefficient|Matrix|26.96417352322909
1|Mileage (mpg)|Intercept|eclass|df|Matrix|72
1|Mileage (mpg)|Intercept|eclass|__LEVEL__% lower bound|Matrix|24.18538092248592
1|Mileage (mpg)|Intercept|eclass|p-value|Matrix|3.09403642424e-30
1|Mileage (mpg)|Intercept|eclass|Std. error|Matrix|1.393952037656927
1|Mileage (mpg)|Intercept|eclass|__LEVEL__% upper bound|Matrix|29.74296612397225
1|Mileage (mpg)|Intercept|eclass|t|Matrix|19.34368815770215
1|Mileage (mpg)|Price|eclass|Coefficient|Matrix|-.0009191630534643
1|Mileage (mpg)|Price|eclass|df|Matrix|72
1|Mileage (mpg)|Price|eclass|__LEVEL__% lower bound|Matrix|-.0013262608947075
1|Mileage (mpg)|Price|eclass|p-value|Matrix|.0000254613120514
1|Mileage (mpg)|Price|eclass|Std. error|Matrix|.0002042163438808
1|Mileage (mpg)|Price|eclass|__LEVEL__% upper bound|Matrix|-.000512065212221
1|Mileage (mpg)|Price|eclass|t|Matrix|-4.500927966866257
1|||eclass|F statistic|Scalar|20.25835256291883
1|||eclass|Number of observations|Scalar|74
1|||eclass|Command|Macro|
1|||eclass|Command line as typed|Macro|
1|||eclass|Dependent variable|Macro|
1|||eclass|Model DF|Scalar|1
1|||eclass|Residual DF|Scalar|72
1|||eclass|Program used to implement estat|Macro|
1|||eclass|Log likelihood|Scalar|-225.2210496559824
1|||eclass|Log likelihood, constant-only model|Scalar|-234.3943376482347
1|||eclass|Predictions allowed by margins|Macro|
1|||eclass|Model|Macro|
1|||eclass|Model sum of squares|Scalar|536.5418070864664
1|||eclass|Program used to implement predict|Macro|
1|||eclass|Command properties|Macro|
1|||eclass|R-squared|Scalar|.2195828561874973
1|||eclass|Adjusted R-squared|Scalar|.2087437291901014
1|||eclass|Rank of VCE|Scalar|2
1|||eclass|RMSE|Scalar|5.146354767606811
1|||eclass|Residual sum of squares|Scalar|1906.917652372993
1|||eclass|Title of output|Macro|
1|||eclass|SE method|Macro|

## Note
This command calls a Python function to convert the data (stored in a .stjson file) into a readable format in Stata.
Please, check if Python is installed on your computer and set up within Stata. These modules are required: `json`, `re`, `pandas`.

*This command does not use the Stata Framework Interface (SFI). It can be called within any Python environment alongside `pystata`.*
