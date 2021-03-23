# Stable isotope mixing model for turkey diet

This project uses the R package simmr (Parnell 2020) to estimate proportions of diet components in ancient turkeys.

## How to use this code

1. Download and install R (https://www.r-project.org/) and R studio (https://rstudio.com/products/rstudio/).
2. Download from this repository the r script (simm.r), and the datasets (diet.csv, frac.csv).
3. Install and load tidyverse and simmr packages.
4. Run the **simm.r** code.

## About the datasets

These data were compiled from existing literature for use with a study of the paleodiet of ancient turkeys in northwestern New Mexico. 

**diet.csv** contains published and estimated 15N and 13C ratios for various dietary components. These are used to input the source means and SDs into the model. "value" is the published value, "corrected" is the published value +1.65 permil if the value is 13C ratio from a modern sample, to correct for recent amospheric depletion of 13C.
Corrected values assigned to groups "C4 Invertebrates" and "C3 invertebrates" were estimated by shifting the corresponding plant values by the average enrichment of herbivorous insects: +1.88 for 15N and -0.53 permil for 13C. 

**frac.csv** contains published fractionation values for animals. These are be used to input the fractionation correction means and SDs into the model.

<<<<<<< HEAD
**turkeys_hm2021.csv and turkeys_hm2014.csv contains original data from McCaffery et al. (2021) and McCaffery et al. (2014)


## References

Andrew Parnell (2020). simmr: A Stable Isotope Mixing Model. R package version 0.4.2. https://CRAN.R-project.org/package=simmr
McCaffery, Miller and Tykot (2021). Paleodiet of Turkeys (Meleagris gallopavo) in the Early Pueblo Period of the Northern Southwest. Kiva.
McCaffery, Tykot, Gore, and DeBoer (2014). Stable Isotope Analysis of (Meleagris gallopavo) diet from Pueblo II and Pueblo III sites, middle San Juan region, northwest New Mexico. American Antiquity.
=======
**turkeys_hm2014.csv** contains stable isotope data from McCaffery et al. 2014. Note this excludes one specimen in the published paper (1042.1) which was found to be erroneous after a second test. It also includes bone apatite isotope values from one Archaic specimen from Fresnal Rock Shelter that was not included in the published study.

## References

McCaffery H, Tykot R, Gore K, DeBoer B (2014). Stable Isotope Analysis of Turkey (Meleagris gallopavo) Diet from Pueblo II and Pueblo III Sites, Middle San Juan Region, Northwest New Mexico. American Antiquity 79: 337-352.

Parnell A (2020). simmr: A Stable Isotope Mixing Model. R package version 0.4.2. https://CRAN.R-project.org/package=simmr
>>>>>>> a4e663eaaf927ee0479a19f14fb9b9da19a5ac51
