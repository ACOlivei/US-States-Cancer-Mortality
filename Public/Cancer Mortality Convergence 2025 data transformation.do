* Replication Files for "Convergence of Cancer Mortality Rates Across U.S. States: The Role of Socioeconomic and Behavioral Risk Factors" 
* by Alberto Carlo Olivei
*   Rogel Cancer Center, University of Michigan, 1500 E Medical Center Dr, Ann Arbor, MI 48109, USA. 
*   e-mail address: acolivei@umich.edu
*   This version: May 2025

clear

* You will need to replace "~" in the line below with your own directory
use "~\data_cancer_original.dta"

xtset fips year

* generate year dummies
forvalues t = 1995/2023  {
    gen y_`t' = 0
    replace y_`t' = 1 if year == `t'
}


* generate log cancer mortality rate and 4-year difference using age adjusted rate (death_aar)
gen ln_cancer = ln(death_aar)
gen df4_ln_cancer = f4.ln_cancer - ln_cancer

 
* generate log of risk factors and 4-year difference except per capita GDP
foreach var in tobacco obese manuf college poverty {
    gen ln_`var'= ln(`var')
	gen df4_ln_`var' = f4.ln_`var'- ln_`var'
    }

	
* generate log of per capita GDP and 4-year difference 
gen ln_gdp = ln(gdp/(pop_tot/1000))
gen df4_ln_gdp = f4.ln_gdp - ln_gdp	


* generate log of black population (as percent of total population)
gen ln_black = ln(100*pop_black/pop_tot)


* You will need to replace "~" in the line below with your own directory
save "~\data_cancer_transformed.dta" , replace
