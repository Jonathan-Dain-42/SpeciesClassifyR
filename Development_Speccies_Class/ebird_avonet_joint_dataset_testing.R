#'+++++++++++++++++++++++++++++++++++
#' Trying to make a joint avonet and eBird taxonomy list. 
#' 
#' @author Jonathan Dain
#' 
#' @date 08-07-2024
#' 
#' +++++++++++++++++++++++++++++++++

#### Packages and Data loading ####
pacman::p_load(SpeciesClassifyR,tidyverse)

data("Species_Lookup_20240806")

clements <- read_csv(file = "Downloads/eBird-Clements-v2023-integrated-checklist-October-2023.csv")

avonet_birdtree <- read_csv(file = "My_Files/My_Code/BIO607_Biostats/Final_Project/DATA/AVONET_Data/ELEData/TraitData/AVONET3_BirdTree.csv")

#### Initial Setup ####
avonet_birdtree |> 
  pull(Species3) -> avonet.names

ebid_avonet_names <- tibble(avonet_name=avonet.names,ebird_name="NA",catagory="NA",order="NA",family="NA")

 i=334

for (i in 1:nrow(avonet_birdtree)){
  hit.name <- avonet_birdtree$Species3[i]
  hit.name
  tmp <- str_split_1(string = hit.name,pattern = " ")
  hit.1 <- tmp[1]
  hit.2 <- tmp[2]
  clements %>%
    filter(str_detect(clements$`scientific name`, hit.2)&str_detect(clements$`scientific name`, hit.1)) |> 
    filter(category=="species") |> 
    filter(order==avonet_birdtree$Order3[i]) |> select(`scientific name`,order,family)->X
  X |> 
    pull(`scientific name`)
    
  check <- identical(X |> 
                       pull(`scientific name`),y = character(0))
  if (check == FALSE) {
    clements %>%
      filter(str_detect(clements$`scientific name`, hit.2)&str_detect(clements$`scientific name`, hit.1)) |> 
      filter(category=="species") |> 
      filter(order==avonet_birdtree$Order3[i]) |> select(`scientific name`,order,family,category)->row.tmp
    ebid_avonet_names$ebird_name[i] <- row.tmp[1]
    ebid_avonet_names$order[i] <- row.tmp[2]
    ebid_avonet_names$family[i] <- row.tmp[3]
    ebid_avonet_names$catagory[i] <- row.tmp[4]
  } else {
    ebid_avonet_names$ebird_name[i] <- "NEG"
    ebid_avonet_names$order[i] <- "NEG"
    ebid_avonet_names$family[i] <- "NEG"
    ebid_avonet_names$catagory[i] <- "NEG"
  }
}


# Lets see if it worked
 clements %>%
   filter(str_detect(clements$`scientific name`, hit.2)&str_detect(clements$`scientific name`, hit.1)) |> 
   filter(category=="species") |> 
   filter(order==avonet_birdtree$Order3[i]) |> select(`scientific name`,order,family)->X

dates <- ape::