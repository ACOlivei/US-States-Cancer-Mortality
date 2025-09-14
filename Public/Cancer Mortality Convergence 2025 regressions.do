* Replication Files for "Convergence of Cancer Mortality Rates Across U.S. States: The Role of Socioeconomic and Behavioral Risk Factors" 
* by Alberto Carlo Olivei
*   Rogel Cancer Center, University of Michigan, 1500 E Medical Center Dr, Ann Arbor, MI 48109, USA. 
*   e-mail address: acolivei@umich.edu
*   This version: September 2025

clear

* You will need to replace "~" in the line below with your own directory
use "~\data_cancer_transformed.dta"

xtset fips year

**************************************************************************
* Table 1 Regressions

* absolute convergence (column (1))
reg df4_ln_cancer ln_cancer y_1997 y_2001 y_2005 y_2009 y_2013 y_2017  if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 , cluster(fips)

* conditional convergence (column (2))
reg df4_ln_cancer ln_cancer ln_tobacco ln_obese ln_manuf ln_gdp y_1997 y_2001 y_2005 y_2009 y_2013 y_2017  if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 , cluster(fips)

**************************************************************************

**************************************************************************
* Table 2 Regressions

* absolute convergence Tobacco  (column (1))
reg df4_ln_tobacco ln_tobacco y_1997 y_2001 y_2005 y_2009 y_2013 y_2017  if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 , cluster(fips)

* absolute convergence Obesity  (column (2))
reg df4_ln_obese ln_obese y_1997 y_2001 y_2005 y_2009 y_2013 y_2017  if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 , cluster(fips)

* absolute convergence Manufacturing  (column (3))
reg df4_ln_manuf ln_manuf y_1997 y_2001 y_2005 y_2009 y_2013 y_2017  if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 , cluster(fips)

*absolute convergence per capita GDP  (column (4))
reg df4_ln_gdp ln_gdp y_1997 y_2001 y_2005 y_2009 y_2013 y_2017  if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 , cluster(fips)

**************************************************************************

**************************************************************************
* Table 3 Regressions

* column (1) -- repeat of results in Table 1
reg df4_ln_cancer ln_cancer ln_tobacco ln_obese ln_manuf ln_gdp y_1997 y_2001 y_2005 y_2009 y_2013 y_2017  if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 | year == 2021 , cluster(fips)

* column (2) add black population, college share, poverty rate, rural population, and per-capita health care spending
reg df4_ln_cancer ln_cancer ln_tobacco ln_obese ln_manuf ln_gdp ln_black ln_college ln_poverty ln_rural ln_gdp_hc y_1997 y_2001 y_2005 y_2009 y_2013 y_2017  if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 | year == 2021 , cluster(fips)

**************************************************************************

* Appendix Plots Figure 1A
* 
* left panel 
reg df4_ln_cancer y_1997 y_2001 y_2005 y_2009 y_2013 y_2017 if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 , cluster(fips)
predict df4_ln_cancer_fit if e(sample) 
* generate portion of df4_ln_cancer not explained by all explanatory variables excluding initial cancer mortality rate (ln_cancer):
gen df4_ln_cancer_e1 = df4_ln_cancer - df4_ln_cancer_fit if e(sample)

reg ln_cancer y_1997 y_2001 y_2005 y_2009 y_2013 y_2017 if e(sample), cluster(fips)
predict ln_cancer_fit if e(sample)
* generate portion of ln_cancer not explained by all other explanatory variables:
gen ln_cancer_e1 = ln_cancer - ln_cancer_fit if e(sample)

* as a check, this regression will generate the same slope for ln_cancer as in table 1 column (1):
reg df4_ln_cancer_e1 ln_cancer_e1
* generate left hand plot 
graph twoway scatter df4_ln_cancer_e1 ln_cancer_e1 || lfit df4_ln_cancer_e1 ln_cancer_e1
*
*
*
*
* right panel 
drop df4_ln_cancer_fit ln_cancer_fit
reg df4_ln_cancer ln_tobacco ln_obese ln_manuf ln_gdp y_1997 y_2001 y_2005 y_2009 y_2013 y_2017 if year == 1997 | year == 2001 | year == 2005 | year == 2009 | year == 2013 | year == 2017 , cluster(fips)
predict df4_ln_cancer_fit if e(sample) 
* generate portion of df4_ln_cancer not explained by all explanatory variables excluding initial cancer mortality rate (ln_cancer):
gen df4_ln_cancer_e2 = df4_ln_cancer - df4_ln_cancer_fit if e(sample)

reg ln_cancer ln_tobacco ln_obese ln_manuf ln_gdp y_1997 y_2001 y_2005 y_2009 y_2013 y_2017 if e(sample), cluster(fips)
predict ln_cancer_fit if e(sample)
* generate portion of ln_cancer not explained by all other explanatory variables:
gen ln_cancer_e2 = ln_cancer - ln_cancer_fit if e(sample)

* as a check, this regression will generate the same slope for ln_cancer as in table 1 column (2):
reg df4_ln_cancer_e2 ln_cancer_e2
* generate right hand plot
graph twoway scatter df4_ln_cancer_e2 ln_cancer_e2 || lfit df4_ln_cancer_e2 ln_cancer_e2
