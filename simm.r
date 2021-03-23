################################################################################
# H. McCaffery, University of Michigan
# started 10-16-2020
#
# This code was used for the analysis published in: 
#
# McCaffery et al. 
# 2021 "Paleodiet of Turkeys (Meleagris gallopavo) in the Early 
# Pueblo Period of the Northern Southwest" Kiva.
#
# Please cite our work if using this data and/or model
################################################################################

library(simmr)
library(tidyverse)


################################################################################
############################ Read in data ######################################
################################################################################

#turkey isotope data
turk <- read.csv('data/turkeys_hm2021.csv')

#dietary components
diet <- read.csv('data/diet.csv')

#diet to bone collagen fractionation
frac <- read.csv('data/frac.csv')




################################################################################
######################## Prepare data for mixing model #########################
################################################################################

#consumer data
mix <- turk[,c('d13C','d15N')] %>% as.matrix
rownames(mix) <- turk$USF.


#Turkey diet
#Nott(31:32) documented pollen in turkey coprolites
# maize
# juniper (28% of pollen in turkey coprolites but could be from wood)
# pinus (ponderosa and edulis)
# pocaceae (direct consumption evident, indian rice grass, close to 8% in coprolitets)
# Cheno-Am (6% of coprolite pollen)
# beeweed (4% of coprolite pollen) possibly ingesting
# prickly pear: only a few examples


#sensitivity analysis without low d13c specimen
#mix <- mix[-13,]


# check means and SDs of d15N and d13C by group
diet %>% 
  group_by(isotope, group)%>%
  summarize(mean=mean(corrected), 
            sd = sd(corrected))



#C4 plants d13C and d15N values
c4_d13c <- diet[diet$group=='C4' & diet$isotope=='d13C',]$corrected
c4_d15n <- diet[diet$group=='C4' & diet$isotope=='d15N',]$corrected



#C3 plants d13C and d15N values
c3_d13c <- diet[diet$group=='C3' & diet$isotope=='d13C',]$corrected
c3_d15n <- diet[diet$group=='C3' & diet$isotope=='d15N',]$corrected


# not using cam in model
#CAM plants: 
# cam_d13c <- diet[diet$group=='CAM' & diet$isotope=='d13C',]$corrected
# cam_d15n <- diet[diet$group=='CAM' & diet$isotope=='d15N',]$corrected


#C4 invertebrates d13C and d15N values
c4i_d13c <- diet[diet$group=='C4 Invertebrates' & diet$isotope=='d13C',]$corrected
c4i_d15n <- diet[diet$group=='C4 Invertebrates' & diet$isotope=='d15N',]$corrected



#C3 invertebrats d13C and d15N values
c3i_d13c <- diet[diet$group=='C3 Invertebrates' & diet$isotope=='d13C',]$corrected
c3i_d15n <- diet[diet$group=='C3 Invertebrates' & diet$isotope=='d15N',]$corrected




# for passing to arguments in simmr_load
s_names <- c("C4 plants", "C3 plants", "C4 invertebrates", "C3 invertebrates")
s_means <- matrix(c(mean(c4_d13c), mean(c3_d13c),mean(c4i_d13c), mean(c3i_d13c), 
                    mean(c4_d15n), mean(c3_d15n), mean(c4i_d15n), mean(c3i_d15n)), ncol=2)

s_sds <- matrix(c(sd(c4_d13c), sd(c3_d13c), sd(c4i_d13c), sd(c3i_d13c), 
                  sd(c4_d15n), sd(c3_d15n), sd(c4i_d15n), sd(c3i_d15n)),ncol=2)


# get means and SDs of fractionation values by isotope
(smry<-
frac %>% 
  group_by(isotope)%>%
  summarize(mean_frac=mean(diet_to_collagen), 
            sd_frac = sd(diet_to_collagen))
)

# for arguments in simmr_load
c_means <- matrix(c(rep(smry[[1,2]],4) , rep(smry[[2,2]], 4) ),ncol=2)
c_sds <- matrix(c(rep(smry[[1,3]],4) , rep(smry[[2,3]], 4) ),ncol=2)





################################################################################
############################# Run mixing model #################################
################################################################################

# create simmr object 
simmr_in <- simmr_load(mixtures = mix,
                      source_names = s_names,
                      source_means = s_means,
                      source_sds = s_sds,
                      correction_means = c_means,
                      correction_sds = c_sds)


# plot data with tracers
plot(simmr_in,
     xlab = expression(paste(delta^13, "C (\u2030)",
                                      sep = "")), 
     ylab = expression(paste(delta^15, "N (\u2030)",
                             sep = "")), 
     title = 'Isospace Plot of Sampled Turkeys', colour = F )



# Run SIMM
set.seed(6374)
out <- simmr_mcmc(simmr_in)


# diagnostics
summary(out, type='diagnostics')
plot(out,type='matrix')
post_pred = posterior_predictive(out)



# model summary
prior_viz(out)
summary(out, type = 'statistics')
summary(out, type = 'quantiles')



# plots
plot(out, type='density',title = "Posterior Distributions of Turkey Diet Proportions",alpha=0)+
  geom_density()+theme_bw()+facet_grid(rows = NULL,cols=NULL)

boxplot<-
plot(out, type='boxplot',title = "Posterior Distributions of Turkey Diet Proportions",alpha=0,
     ggargs = list(xlab('') , ylab('Proportion'), ylim(0,1.0), theme_bw(),theme(legend.position = 'none')))+
  geom_boxplot(fill='white',outlier.size = .85) 


#ggsave('Figure_2.pdf',plot = boxplot, width = 8, height=6, units='in')





