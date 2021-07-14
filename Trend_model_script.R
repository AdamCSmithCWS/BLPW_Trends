### estimating trends from BBS to compare to Migration Monitoring

library(bbsBayes)
library(tidyverse)




# stratifying BBS data ----------------------------------------------------

strat_data <- stratify(by = "bbs_usgs")


species = "Blackpoll Warbler"
species_file = gsub(species,pattern = " ",replacement = "_")

jags_data <- prepare_jags_data(strat_data = strat_data,
                               species_to_run = species,
                               model = "gamye",
                               heavy_tailed = TRUE,
                               min_n_routes = 2)


jags_mod <- run_model(jags_data = jags_data,
                      parameters_to_save = c("n","n3"),
                      n_iter = 20000,
                      n_burnin = 10000,
                      parallel = TRUE)


save(list = c("jags_data","jags_mod"),
     file = paste0("output/","full_model_full_time_series_",species_file,".RData"))




# alternate analysis that only includes information from 1995 onwa --------




jags_data_95 <- prepare_jags_data(strat_data = strat_data,
                               species_to_run = species,
                               model = "gamye",
                               heavy_tailed = TRUE,
                               min_n_routes = 2,
                               min_year = 1995)


jags_mod_95 <- run_model(jags_data = jags_data_95,
                      parameters_to_save = c("n","n3"),
                      n_iter = 20000,
                      n_burnin = 10000,
                      parallel = TRUE)


save(list = c("jags_data_95","jags_mod_95"),
     file = paste0("output/","full_model_1995_",species_file,".RData"))




