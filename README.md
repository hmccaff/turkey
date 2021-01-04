# Stable isotope mixing model for turkey diet

This project uses the R package simmr (Parnell 2020) to estimate proportions of diet components in ancient turkeys.

## How to use this code

1. Download and install R (https://www.r-project.org/) and R studio (https://rstudio.com/products/rstudio/).
2. Download from this repository the r script (simm.r), and the datasets (diet.csv, frac.csv).
3. Install and load tidyverse and simmr packages.
4. Run the **simm.r** code.

## Information about the datasets

These data were compiled from existing literature for use with a study of the paleodiet of ancient turkeys in northwestern New Mexico. 

**diet.csv** contains published and estimated 15N and 13C ratios for various dietary components. These are used to input the source means and SDs into the model. "value" is the published value, "corrected" is the published value +1.65 permil if the value is 13C ratio from a modern sample, to correct for recent amospheric depletion of 13C.
Corrected values assigned to groups "C4 Invertebrates" and "C3 invertebrates" were estimated by shifting the corresponding plant values by the average enrichment of herbivorous insects: +1.88 for 15N and -0.53 permil for 13C. 

**frac.csv** contains published fractionation values for animals. These are be used to input the fractionation correction means and SDs into the model.

## References

Andrew Parnell (2020). simmr: A Stable Isotope Mixing Model. R package version 0.4.2. https://CRAN.R-project.org/package=simmr
