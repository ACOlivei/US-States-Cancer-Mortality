* Replication Files for "Convergence of Cancer Mortality Rates Across U.S. States: The Role of Socioeconomic and Behavioral Risk Factors" 
* by Alberto Carlo Olivei
*   Rogel Cancer Center, University of Michigan, 1500 E Medical Center Dr, Ann Arbor, MI 48109, USA. 
*   e-mail address: acolivei@umich.edu
*   This version: May 2025

clear

* You will need to replace "~" in the line below with your own directory
use "~\data_cancer_transformed.dta"

* Summarize log of cancer mortality rate in 1997 and 2021
summarize ln_cancer if year == 1997, detail
summarize ln_cancer if year == 2021, detail

* Box Plot of state-level log cancer mortality rate
graph box ln_cancer if year >= 1997 & year <= 2021 , over(year)

