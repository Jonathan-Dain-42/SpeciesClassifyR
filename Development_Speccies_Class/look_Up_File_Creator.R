#'''''''''''''''''''''''''
#' Welcome to this Script!
#'
#' Bird Name Lookup Script!
#'
#' @author Jonathan Dain
#' ''''''''''''''''''''''''

#### Goal of the Script ####
#' This script is meant to make a lookup file for the any bird data
#' I am combining the ebird clemment dataset with some additional information
#' from some other HILL lab ideas. Meaning the 'type' catagory.

#### Load your packages ####
pacman::p_load(tidyverse,janitor)


#### Load in Ebird/Clemments data ####
clem <- read_csv('DATA/NEW_Clements-Checklist-v2022-October-2022.csv')

# Let's trim down some columns
clem <- clem |>
  select(c(category,`English name`,`scientific name`,order,family))

#head(clem)
#' we need to remove the first row
clem <- clem[2:nrow(clem),]

# Let's remove the subspecies, and group catagories
#unique(test$category)

clean_clem <- clem |>
  mutate(`English name`=tolower(`English name`)) |>
  filter(category != c('subspecies')) |>
  filter(category != 'group (monotypic)') |>
  filter(category != 'group (polytypic)') |>
  mutate(English.name = `English name`) |>
  mutate(scientific.name = `scientific name`) |>
  mutate(order = order) |>
  mutate(family = family) |>
  mutate(English.name=tolower(English.name)) |>
  mutate(scientific.name=tolower(scientific.name)) |>
  mutate(order=tolower(order)) |>
  mutate(family=tolower(family)) |>
  select(c(English.name,scientific.name,order,family))

clean_clem
#### USDA Data ####
# Ok let's bring in our other USDA lookup file
usda <- read_csv(file = 'DATA/USDA_lookup.csv')
head(usda)

usda <- usda |>
  rename(number = ...1)

colnames(usda)

head(usda, n =10)

#Ok let's make a new table

#### Updating USDA table with Scientific Names ####

# I can join by the English.name that is common to both datasets.

temp_dataset<- left_join(x = usda,y = clean_clem,by = "English.name")
temp_dataset |>
  select(-scientific.name.x,-family.x,-order.x,-category) |>
  View()
  #write_csv(file = "DATA/temp_dataset_unclean.csv")

#' I will need to manually fix the following birds names because they do not have
#' a common name in the clemments dataset. See list of birds below.

temp_dataset |>
  mutate(scientific.name.y = replace_na(scientific.name.y,replace = "NA")) |>
  select(-scientific.name.x,-family.x,-order.x,-category) |>
  filter(scientific.name.y == "NA") -> NA_names

unique(NA_names$English.name)

#### Re-evaluating the clean dataset ####

name_index <- read_csv(file = "DATA/temp_dataset_clean.csv")

#make the names lowercase
name_index <- name_index |>
  mutate(English.name=tolower(English.name)) |>
  mutate(scientific.name.y=tolower(scientific.name.y)) |>
  rename(order=order.y) |>
  rename(family=family.y) |>
  rename(scientific.name=scientific.name.y) |>
  mutate(order=tolower(order)) |>
  mutate(family=tolower(family))
  select(c(number,English.name,scientific.name,type,order,family))

name_index |>
  select(c(-number)) ->name_index

#test the intersect again.
#See what is common between both
found <- intersect(name_index,clean_clem)
found_names <- found$scientific.name
#see what is missing in my index
name_index |>
  filter(!scientific.name %in% found_names)

#' Ok so what is missing is that I need to do another left_join again to make the file work.

left_join(x = name_index, y = clean_clem, by = "scientific.name") |>
  select(c(-order.x,-family.x)) -> Species_Name_Lookup

#' Ok this is a pretty good list it has both the alternative english name and
#' the "ture" english name because it linked to the ebird dataset.
#'
#' Some of the "unidentified" species are a little harder so they are currently
#' just NA's in the dataset. I am going to turn them into character NA's and then
#' save it as a RDS object.


Species_Name_Lookup <- Species_Name_Lookup |>
  mutate_all(~replace_na(.,"NA")) |>
  rename(alt.common.name=English.name.x) |>
  rename(enlish.name.ebird=English.name.y) |>
  rename(order=order.y) |>
  rename(family=family.y)

saveRDS(object = Species_Name_Lookup,file = "DATA/Species_Name_Lookup.rds")

#' Now you have a saved species lookup file that you can use. Good Job dude.

#### Adding New Rows ####

#open the file
Species_Lookup <- readRDS(file = "DATA/Species_Name_Lookup.rds")

#' There is a chance that you will need to add new rows to the data set.
#' I made a section here fore that. Please help yourself and place a
#' Date, Author and Reson for each change to the file.

#' 07DEC2023, JBD, adding rows to allow for extra species as part of my BIO607
#' final project where I am working with sequence data from GISAID.

Species_Lookup <- Species_Lookup |>
  rbind(c("common eiders","Seaduck","Somateria mollissima","common eider","anseriformes","anatidae (ducks, geese, and waterfowl)")) |>
  rbind(c("blue winged teal","Dabbling duck","Spatula discors","blue-winged teal","anseriformes","anatidae (ducks, geese, and waterfowl)")) |>
  rbind(c("gadwall duck","Dabbling duck","Mareca strepera","Gadwall","anseriformes","anatidae (ducks, geese, and waterfowl)")) |>
  rbind(c("green winged teal","Dabbling duck","anas crecca","green-winged teal","anseriformes","anatidae (ducks, geese, and waterfowl)")) |>
  rbind(c("mallard duck","Dabbling duck","anas platyrhynchos","mallard","anseriformes","anatidae (ducks, geese, and waterfowl)")) |>
  rbind(c("redhead","Seaduck","aythya americana",'redhead',"anseriformes","anatidae (ducks, geese, and waterfowl)")) |>
  rbind(c("mergus","Seaduck","merganser spp",'merganser',"anseriformes","anatidae (ducks, geese, and waterfowl)")) |>
  rbind(c("merganser","Seaduck","merganzer spp",'merganser',"anseriformes","anatidae (ducks, geese, and waterfowl)")) |>
  rbind(c("gull","Seabird","gull spp","gull","charadriiformes","laridae (gulls, terns, and skimmers)"))|>
  rbind(c("duck","Dabbling duck","duck spp","duck","anseriformes","anatidae (ducks, geese, and waterfowl)")) |>
  mutate(scientific.name=tolower(scientific.name))


#' Save a new RDS object.

saveRDS(object = Species_Lookup,file = "DATA/Species_Lookup_20231207.rds")


#### Updating the Lookup Sheet 21FEB2024 ####

#' 21FEB2024, JBD, adding species as they come up during a North American Phylodynamics Paper
#pull up the data sheet!

Species_Lookup <- readRDS(file="Species_Lookup_20231207.rds")

Species_Lookup <- Species_Lookup |>
  rbind(c('goose species','Goose/Swan','goose spp','NA','anseriformes','anatidae (ducks, geese, and waterfowl)')) |>
  rbind(c('turkey','Other','meleagris gallopavo','wild turkey','galliformes','phasianidae (pheasants, grouse, and allies)')) |>
  rbind(c('lesser snow goose white','Goose/Swan','anser caerulescens','snow goose','anseriformes','anatidae (ducks, geese, and waterfowl)')) |>
  rbind(c('eagle','Raptor/Owl/Falcon','eagle spp','NA','accipitriformes','accipitridae (hawks, eagles, and kites)')) |>
  rbind(c('guineafowl','Other','guinea fowl spp','NA','galliformes','numididae (guinea fowl)')) |> rbind(c('cormorant','Seabird','cormorant spp','NA','suliformes','phalacrocoracidae (cormorants and shags)')) |>
  rbind(c('backyard bird','Other','bird spp','NA','NA','NA')) |>
  rbind(c('black swift','Other','cypseloides niger','black swift','Apodiformes','Apodidae (swifts)')) |>
  rbind(c('guinea fowl','Other','guinea fowl spp','NA','galliformes','numididae (guinea fowl)')) |>
  rbind(c("lady amhert's pheasant",'Other','chrysolophus amherstiae','lady amherst pheasant','galliformes','phasianidae (pheasants, grouse, and allies)')) |>
  rbind(c('american pelican','Seabird','pelecanus erythrorhynchos','american white pelican','pelecaniformes','pelecanidae (pelicans)')) |>
 rbind(c('hawk','Raptor/Owl/Falcon','hawk spp','NA','NA','NA'))


#' backyard bird
#' black swift
#' guinea fowl
#' lady amherst's pheasant
#' american pelican

#save it as a new object and finish the below later.
saveRDS(object = Species_Lookup,file = "Species_Lookup_20240223.rds")

#read in the new file to edit and add in the new rows.
Species_Lookup <- readRDS(file = "Species_Lookup_20240223.rds")

# Remember the format is:
# name, type, scientific name, english name ebird, order, family

Species_Lookup <- Species_Lookup |>
  rbind(c('magpie','Other','magpie spp','NA','NA','NA')) |>
  rbind(c('pheasant','Other','pheasant spp','NA','NA','NA')) |>
  rbind(c('sebastopol goose','Goose/Swan','goose spp','NA','NA','NA')) |>
  rbind(c('amazon parrot','Other','parrot spp','NA','NA','NA')) |>
  rbind(c('catalina macaw','Other','parrot spp','NA','NA','NA')) |>
  rbind(c('fancy chicken','Other','chicken spp','NA','NA','NA')) |>
  rbind(c('graylang goose','Goose/Swan','anser anser','greylag goose','anseriformes','anatidae (ducks, geese, and waterfowl)')) |>
  rbind(c('bird sp.','Other','NA','NA','NA','NA')) |>
  rbind(c('swan','Goose/Swan','swan spp','NA','NA','NA')) |>
  rbind(c('gull species','Seabird','gull spp','NA','NA','NA')) |>
  rbind(c('wigeon','Dabbling duck','wigeon spp','NA','NA','NA')) |>
  rbind(c('songbird sp.','Other','songbird spp','NA','NA','NA')) |>
  rbind(c('common golden eye','Seaduck','bucephala clangula','common goldeneye','anseriformes','anatidae (ducks, geese, and waterfowl)')) |>
  rbind(c("cooper'shawk",'Raptor/Owl/Falcon','accipiter cooperii
',"cooper's hawk",'acciptriformes','accipitridae (hawks, eagles, and kites)'))


# Remember the format is: I am addig more on 13MAR2024
# name, type, scientific name, english name ebird, order, family
#read in the file.

Species_Lookup <- Species_Lookup |>
  rbind(c('bird sp.', 'Other', 'NA', 'bird spp', 'NA', 'NA'),
        c('swan', 'Goose/Swan', 'NA', 'swan spp', 'NA', 'NA'),
        c('gull species', 'Seabird', 'NA', 'gull spp', '', ''),
        c('wigeon', 'Dabbling Duck', 'NA', 'wigeon spp', '', ''),
        c('songbird sp.', 'Other', 'NA', 'songbird spp', '', ''),
        c('common golden eye', 'Seaduck', 'bucephala clangula', 'common goldeneye', 'anseriformes', 'anatidae (ducks, geese, and waterfowl)'),
        c("cooper'shawk", 'Raptor/Owl/Falcon', 'accipiter cooperii', "cooper's hawk", 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'), # Note the escaped apostrophe
        c('sharp shinned hawk', 'Raptor/Owl/Falcon', 'accipiter striatus', 'sharp-shinned hawk', 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'),
        c('red tailed hawk', 'Raptor/Owl/Falcon', 'buteo jamaicensis', 'red-tailed hawk', 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'),
        c('red shouldered hawk', 'Raptor/Owl/Falcon', 'buteo lineatus', 'red-shouldered hawk', 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'),
        c('call duck -drumlin farms', 'Other', 'domestic spp', '', '', ''),
        c('sparrow', 'Other', 'sparrow spp', '', '', ''),
        c('gbb gull', 'Seabird', 'larus marinus', 'great black-backed gull', 'charadriiformes', 'laridae (gulls, terns, and skimmers)'),
        c('e. screech owl', 'Raptor/Owl/Falcon', 'megascops asio', 'eastern screech owl', 'strigiformes', 'strigidae (owls)'),
        c('thick billed murre', 'Seabird', 'uria lomvia', 'thick-billed murre', 'charadriiformes', 'alcidae (auks, murres, and puffins)'),
        c('northern saw-whet', 'Raptor/Owl/Falcon', 'aegolius acadicus', 'northern saw-whet owl', 'strigiformes', '
strigidae (owls)'),
        c('dark eyed junco', 'Other', 'junco hyemalis', 'dark-eyed junco', 'passeriformes', 'passerellidae (new world sparrows)'),
        c('wild turkery', 'Other', 'meleagris gallopavo', 'wild turkey', 'galliformes', 'phasianidae (pheasants, grouse, and allies)'),
        c('red throated loon', 'Seabird', 'gavia stellata', 'red-throated loon', 'gaviiformes', 'gaviidae (loons)'),
        c('ring billed gull', 'Seabird', 'larus delawarensis', 'ring-billed gull', 'charadriiformes', 'laridae (gulls, terns, and skimmers)'),
        c('great black backed gull', 'Seabird', 'larus marinus', 'great black-backed gull', 'charadriiformes', 'laridae (gulls, terns, and skimmers)'),
        c('coopers hawk', 'Raptor/Owl/Falcon', 'accipiter cooperii', "cooper's hawk", 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'),
        c('red breasted merganzer', 'Seaduck', 'mergus serrator', 'red-breasted merganzer', 'anseriformes', 'anatidae (ducks, geese, and waterfowl)'),
        c('moruning dove', 'Other', 'zenaida macroura
', 'mourning dove', 'columbiformes', 'columbidae (pigeons and doves)'),
        c('canda goose', 'Goose/Swan', 'branta canadensis', 'canada goose', 'anseriformes', 'anatidae (ducks, geese, and waterfowl)'),
        c('red-shouldered', 'Raptor/Owl/Falcon', 'buteo lineatus', 'red-shouldered hawk', 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'),
        c('rooster', 'Other', 'rooster spp', 'NA', 'NA', 'NA'),
        c('wood duck, mallard', 'Dabbling duck', 'aix sponsa', 'wood duck', 'anseriformes', 'anatidae (ducks, geese, and waterfowl)'),
        c('virginial rail', 'Other', 'rallus limicola', 'virginia rail', 'gruiformes', 'rallidae (rails, gallinules, and coots)'),
        c('eastern screech','Raptor/Owl/Falcon', 'megascops asio', 'eastern screech owl', 'strigiformes', 'strigidae (owls)'),
        c('woodpecker', 'Other', 'woodpecker spp', 'NA', 'NA', 'NA'),
        c('swsp', 'Goose/Swan', 'swan spp', 'NA', 'NA', 'NA'),
        c('gbbg','Seabird', 'larus marinus', 'great black-backed gull', 'charadriiformes', 'laridae (gulls, terns, and skimmers)'),
        c('rtlo', 'Seabird', 'gavia stellata', 'red-throated loon', 'gaviiformes', 'gaviidae (loons)'),
        c('shearwater sp', 'Seabird', 'shearwater spp', 'NA', 'NA', 'NA'),
        c('great blue herron', 'Other', 'ardea herodias', 'great blue heron', 'pelecaniformes', 'lardeidae (herons, egrets, and bitterns)'),
        c('double crested cormorant', 'Seabird', 'nannopterum auritum', 'double-crested cormorant', 'suliformes', 'phalacrocoracidae (cormorants and shags)'),
        c('canadian goose', 'Goose/Swan', 'branta canadensis', 'canada goose', 'anseriformes', 'natidae (ducks, geese, and waterfowl)'),
        c('mallard ducklings', 'Dabbling duck', 'anas platyrhynchos', 'mallard', 'anseriformes', 'anatidae (ducks, geese, and waterfowl)'),
        c('redtailed hawk','Raptor/Owl/Falcon', 'buteo jamaicensis', 'red-tailed hawk', 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'),
        c('greathorned owl', 'Raptor/Owl/Falcon', 'bubo virginianus', 'great horned owl', 'strigiformes', 'strigidae (owls)'),
        c("corey's shearwater", 'Seabird', '
calonectris diomedea', "cory's shearwater", 'procellariiformes', 'procellariidae (shearwaters and petrels)'), # Note the escaped apostrophe
        c('herg', 'Seabird', 'larus argentatus', 'herring gull', 'charadriiformes', 'laridae (gulls, terns, and skimmers)'),
        c('wilsons storm petrel', 'Seabird', 'oceanites oceanicus', 'wilsons storm petrel', 'procellariiformes', 'procellariidae (shearwaters and petrels)'),
        c('dc cormorant', 'Seabird', 'nannopterum auritum', 'double-crested cormorant', 'suliformes', 'phalacrocoracidae (cormorants and shags)'),
        c('ww scoter', 'Seaduck', 'melanitta deglandi', 'white-winged scoter', 'anseriformes', 'anatidae (ducks, geese, and waterfowl)'),
        c('mall','Dabbling duck', 'anas platyrhynchos', 'mallard', 'anseriformes', 'anatidae (ducks, geese, and waterfowl)'),
        c('eregrine falcon', 'Raptor/Owl/Falcon', 'falco peregrinus', 'peregrine falcon', 'falconiformes', 'falconidae (falcons and caracaras)'),
        c('northern racoon', 'Mammal', 'Mammal spp', 'NA', 'NA', 'NA'),
        c('mississippi kite', 'Raptor/Owl/Falcon', 'ictinia mississippiensis
', 'mississippi kite', 'accipitriformes', 'accipitridae (hawks, eagles, and kites)'),
        c('whooper swan', 'Goose/Swan', 'cygnus cygnus', 'whooper swan', 'anseriformes', 'anatidae (ducks, geese, and waterfowl)'),
        c('barred-owl', 'Raptor/Owl/Falcon', 'strix varia', 'barred owl', 'strigiformes', ''),
c('eastern screen owl', 'Raptor/Owl/Falcon', 'megascops asio', 'eastern screech owl', 'strigiformes', 'strigidae (owls)'),
c('black crowned night heron', 'Other', 'nycticorax nycticorax', 'black-crowned night heron', 'pelecaniformes', 'ardeidae (herons, egrets, and bitterns)'),
c('great black-backed gulll', 'Seabird', 'larus marinus', 'great black-backed gull', 'charadriiformes', 'laridae (gulls, terns, and skimmers)'),
c('short eared owl', 'Raptor/Owl/Falcon', 'asio flammeus', 'short-eared owl', 'strigiformes', 'strigidae (owls)'),
c('white winged scoter', 'Seaduck', 'melanitta deglandi', 'white-winged scoter', 'anseriformes', 'anatidae (ducks, geese, and waterfowl)'),
c('semipalmated plover', 'Other', 'charadrius semipalmatus', 'semipalmated plover', 'charadriiformes', 'charadriidae (plovers and lapwings)'),
c('amerincan crow', 'Other', 'corvus brachyrhynchos', 'american crow', 'passeriformes', 'corvidae (crows, jays, and magpies)'),
c('red tail hawk', 'Raptor/Owl/Falcon', 'buteo jamaicensis', 'red-tailed hawk', 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'),
c('eastern screech-owl', 'Raptor/Owl/Falcon', 'megascops asio', 'eastern screech owl', 'strigiformes', 'strigidae (owls)'),
c('clapper rail', 'Other', 'rallus crepitans', 'clapper rail', 'gruiformes', 'rallidae (rails, gallinules, and coots)'),
c('black-legged kittiwake (blki)', 'Seabird', 'rissa tridactyla', 'black-legged kittiwake', 'charadriiformes', 'laridae (gulls, terns, and skimmers)'),
c('domestic dove', 'Other', 'dove spp', 'NA', 'NA', 'NA'),
c('common nighthawk', 'Other', 'chordeiles minor', 'common nighthawk', 'caprimulgiformes', 'caprimulgidae (nightjars and allies)'),
c('tube logged out for ecotarium mountain lion - sample not taken yet, exam rescheduled', 'Other', 'Mammal spp', 'NA', 'NA', 'NA'),
c('hawk sp.', 'Raptor/Owl/Falcon', 'hawk spp', 'NA', 'NA', 'NA'),
c('greater shearwater', 'Seabird', 'ardenna gravis', 'great shearwater', 'procellariiformes', 'procellariidae (shearwaters and petrels)'),
c('greater black backed gull', 'Seabird', 'larus marinus', 'great black-backed gull', 'charadriiformes', 'laridae (gulls, terns, and skimmers)'),
c('raccoon', 'Mammal', 'procyon lotor', 'raccoon', 'carnivora', 'procyonidae'),
c('unknown bird spp.', 'Other', 'bird spp', 'NA', 'NA', 'NA'),
c('gull spp.', 'Seabird', 'gull spp', 'NA', 'NA', 'NA'),
c('tern spp.', 'Seabird', 'tern spp', 'NA', 'NA', 'NA'),
c('bald ealge', 'Raptor/Owl/Falcon', 'haliaeetus leucocephalus', 'bald eagle', 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'))

#now save it as a updated file on 13MAR2024
saveRDS(object = Species_Lookup,file = "Species_Lookup_20240313.rds")

#need to add two more things.
Species_Lookup <- readRDS(file = "Species_Lookup_20240313.rds")

Species_Lookup <- Species_Lookup |>
  rbind(c("bird sp.",'Other','bird spp','NA','NA','NA'),
        c('ameroican crow', 'Other', 'corvus brachyrhynchos', 'american crow', 'passeriformes', 'corvidae (crows, jays, and magpies)'))

#need to fix the "bird sp." scientific name.
indexs <- which(Species_Lookup$alt.common.name=="bird sp.")
Species_Lookup$scientific.name[c(292,299,373)] <- 'bird spp'

saveRDS(object = Species_Lookup,file = "Species_Lookup_20240313.rds")

#another edit today
Species_Lookup <- readRDS(file = "Species_Lookup_20240313.rds")
indexs <- which(Species_Lookup$scientific.name=="larus marinus" & Species_Lookup$type=="Seabird")
Species_Lookup$type[indexs] <- 'Gull'

indexs <- which(Species_Lookup$scientific.name=="NA" & Species_Lookup$type=="Seabird")
Species_Lookup$scientific.name[indexs] <- 'gull spp'
Species_Lookup$type[indexs] <- 'Gull'

indexs <- which(Species_Lookup$scientific.name=="gull spp" & Species_Lookup$type=="Seabird")
Species_Lookup$type[indexs] <- 'Gull'

indexs <- which(Species_Lookup$scientific.name=="larus delawarensis" & Species_Lookup$type=="Seabird")
Species_Lookup$type[indexs] <- 'Gull'

indexs <- which(Species_Lookup$scientific.name=="larus argentatus" & Species_Lookup$type=="Seabird")
Species_Lookup$type[indexs] <- 'Gull'

saveRDS(object = Species_Lookup,file = "Species_Lookup_20240313.rds")

#another change but for astetic reasons.
Species_Lookup <- readRDS(file = "Species_Lookup_20240313.rds")

index <- which(Species_Lookup$scientific.name=="gull spp")
Species_Lookup$enlish.name.ebird[index]<-"unidentified gull spp"

saveRDS(object = Species_Lookup,file = "Species_Lookup_20240314.rds")


## Another change on 20240320 by JBD. This adding names from the NA flu paper.

Species_Lookup <- readRDS(file = "/Users/jonathandain/My_Files/My_Code/Species_Lookup_Sheet/Species_Lookup_20240314.rds")
#name, type, scientific name, english name ebird, order, family as a reminder of what I am adding.

Species_Lookup <- Species_Lookup |>
  rbind(c('chicken','Other','gallus gallus','chicken','galliformes','phasianidae'),
        c('avian','Other','avian spp','avian spp','NA','NA'),
        c('poultry','Other','poultry spp','poultry','NA','NA'),
        c('rhea','Other','rhea spp','rhea spp','NA','NA'),
        c('cape teal','Dabbling duck','anas capensis','cape teal','anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c("franklin's gull",'Gull','leucophaeus pipixcan','franklin gull','charadriiformes','laridae (gulls, terns, and skimmers)'),
        c('silkie chicken','Other','gallus gallus','chicken','galliformes','phasianidae'),
        c('peacock','Other','pavo cristatus','peacock','galliformes','phasianidae'),
        c('rt-hawk','Raptor/Owl/Falcon','buteo jamaicensis', 'red-tailed hawk', 'acciptriformes', 'accipitridae (hawks, eagles, and kites)'),
        c('broiler chicken','Other','gallus gallus','chicken','galliformes','phasianidae'),
        c('african goose','Goose/Swan','anser anser domesticus','african goose','anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('peafowl','Other','pavo cristatus','peacock','galliformes','phasianidae'),
        c('owl','Raptor/Owl/Falcon','olw spp','owl','NA','NA'),
        c('northwestern crow','Other','corvus caurinus','american crow','passeriformes','corvidae (crows, jays, and magpies)'),
        c('glaucous gull','Gull','larus hyperboreus','glaucous gull','charadriiformes','laridae (gulls, terns, and skimmers)'),
        c('vulture','Raptor/Owl/Falcon','vulture spp','vulture spp','NA','NA'),
        c('graylag goose','Goose/Swan','anser anser','greylag goose','anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('layer chicken','Other','gallus gallus','chicken','galliformes','phasianidae'),
        c('barrow s goldeneye','Seaduck','bucephala islandica',"barrow's goldeneye",'anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('indian runner duck','Dabbling duck','domestic spp','NA','NA','NA'),
        c('crested jay','Other','platylophus galericulatus','crested shrikejay','passeriformes','platylophidae'),
        c('long eared owl','Raptor/Owl/Falcon','asio otus','long-eared owl', 'strigiformes', 'strigidae (owls)'),
        c('crow','Other','crow spp','crow spp','NA','NA'),
        c("cooper's s hawk",'Raptor/Owl/Falcon','accipiter cooperii
',"cooper's hawk",'acciptriformes','accipitridae (hawks, eagles, and kites)'),
        c('heron','Other','heron spp','heron spp','NA','NA'),
        c('pelican','Seabird','pelican spp','pelican spp','NA','NA'),
        c('goose','Goose/Swan','goose spp','goose spp','anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('embden goose','Goose/Swan','goose spp','goose spp','anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('lesser snow goose','Goose/Swan','anser caerulescens','snow goose','anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('silver pheasant','Other','lophura nycthemera','silver pheasant','galliformes','phasianidae (pheasants, grouse, and allies)'),
        c("lady amherst's pheasant",'Other','chrysolophus amherstiae','lady amherst pheasant','galliformes','phasianidae (pheasants, grouse, and allies)'),
        c('waterfowl','Dabbling duck','waterfowl spp','waterfowl spp','NA','NA'),
        c('chinese ringneck pheasant','Other','phasianus colchicus','ring-neck pheasant','galliformes','phasianidae (pheasants, grouse, and allies)'),
        c('parrot','Other','parrot spp','parrot spp','NA','NA'),
        c('','','','','',''),
c('american buff goose','Goose/Swan','goose spp','american buff','NA','NA'),
c('quail','Other','quail spp','quail spp','NA','NA'),
c('falcon','Raptor/Owl/Falcon','falcon spp','falcon spp','NA','NA'),
c('manx shearwater','Seabird','puffinus puffinus','manx shearwater','procellariiformes', 'procellariidae (shearwaters and petrels)'),
c('lesser snow goose blue','Goose/Swan','anser caerulescens','snow goose','anseriformes','anatidae (ducks, geese, and waterfowl)'),
c('raven','Other','raven spp','raven spp','NA','NA'),
c('cooper s hawk','Raptor/Owl/Falcon','accipiter cooperii
',"cooper's hawk",'acciptriformes','accipitridae (hawks, eagles, and kites)'),
c('glaucous winged gull','Gull','larus glaucescens','glaucous-winged gull','charadriiformes','laridae (gulls, terns, and skimmers)'),
c('american raven','Other','Corvus corax','raven','passeriformes','corvidae (crows, jays, and magpies)'),
c('king vulture','Raptor/Owl/Falcon','sarcoramphus papa','king vulture','cathartiformes','cathartidae (new world vultures)'),
c('gryfalcon','Raptor/Owl/Falcon','falco rusticolus','gyrfalcon','falconiformes','falconidae (falcons and caracaras)'),
c('cascade duck','Dabbling duck','domestic spp','NA','NA','NA'),
c("cooper'ss hawk",'Raptor/Owl/Falcon','accipiter cooperii
',"cooper's hawk",'acciptriformes','accipitridae (hawks, eagles, and kites)'))

#save it as a new file
saveRDS(object = Species_Lookup,file = "/Users/jonathandain/My_Files/My_Code/Species_Lookup_Sheet/Species_Lookup_20240320.rds")


#another edit today 20MAR2024
Species_Lookup <- readRDS(file = "/Users/jonathandain/My_Files/My_Code/Species_Lookup_Sheet/Species_Lookup_20240320.rds")
which(Species_Lookup$alt.common.name=="gryfalcon")
Species_Lookup$alt.common.name[420]<-'gyrfalcon'
Species_Lookup$alt.common.name[420]
saveRDS(object = Species_Lookup,file = "/Users/jonathandain/My_Files/My_Code/Species_Lookup_Sheet/Species_Lookup_20240320.rds")

c('','','','','','')


#editing the file once again 23MAR2024
Species_Lookup <- readRDS(file = "/Users/jonathandain/My_Files/My_Code/Species_Lookup_Sheet/Species_Lookup_20240320.rds")
Species_Lookup <- Species_Lookup |>
  rbind(c('rhea (unidentified)','Other','rhea spp','NA','NA','NA'),
        c('warbler','Other','warbler spp','NA','NA','NA'),
        c('finch (unidentified)','Other','finch spp','NA','NA','NA'),
        c('brazilian teal','Dabbling duck','amazonetta brasiliensis','brazilian teal','anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('canvasback','Seaduck','aythya valisineria','canvasback','anseriformes','natidae (ducks, geese, and waterfowl)'),
        c('plush-crested jay','Other','cyanocorax chrysops','plush-crested jay','passeriformes','corvidae (crows, jays, and magpies)'),
        c('sparrow (unidentified)','Other','sparrow spp','NA','NA','NA'),
        c('black-bellied plover','Other','pluvialis squatarola','black-bellied plover','charadriiformes','charadriidae (plovers and lapwings)'),
        c('cattle egret','Other','bubulcus ibis','cattle egret','pelecaniformes','ardeidae (herons, egrets, and bitterns)'),
        c('gannet','Seabird','morus bassanus','Northern Gannet','suliformes','sulidae (boobies and gannets)'),
        c('lorikeet (unidentified)','Other','lorikeet spp','NA','NA','NA'),
        c('roseate spoonbill','Other','platalea ajaja','roseate spoonbill','pelecaniformes','threskiornithidae (ibises and spoonbills)'),
        c('ferruginous hawk','Raptor/Owl/Falcon','buteo regalis','ferruginous hawk','accipitriformes','accipitridae (hawks, eagles, and kites)'),
        c('scarlet ibis','Other','eudocimus ruber','scarlet ibis','pelecaniformes','threskiornithidae (ibises and spoonbills)'),
        c('mallard/black duck hybrid','Dabbling duck','hybrid spp','NA','NA','NA'),
        c('california quail','Other','callipepla californica','california quail','galliformes','Odontophoridae (quail)'),
        c('western sandpiper','Other','calidris mauri','western sandpiper','charadriiformes','scolopacidae (sandpipers and allies)'),
        c('black-neck swan','Goose/Swan','cygnus melancoryphus','black-neck swan','anseriformes','anatidae (ducks, geese, and waterfowl)'))

saveRDS(object = Species_Lookup,file = "/Users/jonathandain/My_Files/My_Code/Species_Lookup_Sheet/Species_Lookup_20240323.rds")


#### ANother edit
#' what if we merged the BV.clean data from my OG phytools thing and the
#' current species list to fix the avonet problem????


#### Another edit: 22APR2024

#' I found that the ring neck pheasant has two common names so I need to fix that.

Species_Lookup <- readRDS(file = "Species_Lookup_20240323.rds")
which(Species_Lookup$enlish.name.ebird=="ring-necked pheasant")
Species_Lookup$enlish.name.ebird[113] <- "ring-neck pheasant"
saveRDS(object = Species_Lookup,file = "Species_Lookup_20240422.rds")



#### Another edit: 24APR2024
#' Nichola suggested to actually adjust the "other" catagory to something more
#' biological so that we can see the details better.

Species_Lookup <- readRDS(file = "Species_Lookup_20240422.rds")
Species_Lookup <- Species_Lookup |>
  mutate_all(tolower)

#fix some family names:
sort(unique(Species_Lookup$order))
Species_Lookup$family[which(Species_Lookup$family=="\t\nstrigidae (owls)")] <-'strigidae (owls)'

Species_Lookup$family[which(Species_Lookup$family=="phasianidae")] <-'phasianidae (pheasants, grouse, and allies)'


Species_Lookup |>
  filter(type == "other") |>
  group_by(order) |>
  count() |> print(n=30)

#add passeriformes
Species_Lookup |>
  mutate(type=ifelse(order=="passeriformes","songbird",type))->Species_Lookup

Species_Lookup |>
  filter(type=="other",order=='na') |> print(n=42)

# replace NA with "unidentified"
Species_Lookup |>
  mutate(order=ifelse(order=="na","unidentified",order)) ->Species_Lookup

#add pheasants
Species_Lookup |>
  filter(type=="other",order=='galliformes') |> print(n=23)

#add chicken
Species_Lookup |>
  mutate(type=ifelse(enlish.name.ebird=="chicken","chicken",type)) -> Species_Lookup

write_rds(x = Species_Lookup,file = "Species_Lookup_20240427.rds")

#one more edit: 21APR2024
Species_Lookup <- readRDS(file = "Species_Lookup_20240427.rds")
which(Species_Lookup$scientific.name=="larus glaucoides thayeri")
Species_Lookup$enlish.name.ebird[135] <- "thayers gull"
Species_Lookup$order[135] <- "charadriiformes"
Species_Lookup$family[135] <- "laridae (gulls, terns, and skimmers)"

saveRDS(Species_Lookup,file = "Species_Lookup_20240427.rds")

# add. in the shore birds
Species_Lookup |>
  filter(type=="other") |>
  group_by(order) |>
  count()

Species_Lookup |>
  filter(type=="other",order=="charadriiformes")

Species_Lookup |>
  mutate(type=ifelse(type=="other" & order=="charadriiformes","shorebird",type))->Species_Lookup

saveRDS(Species_Lookup,file = "Species_Lookup_20240427.rds")


#another edit with the texas outbreak
Species_Lookup <- readRDS(file = "Species_Lookup_20240427.rds")

Species_Lookup <- Species_Lookup |>
  rbind(c('blackbird (unidentified)','songbird','blackbird spp','unidentified','unidentified','unidentified'),
        c('grackle (unidentified)','songbird','blackbird spp','unidentified','unidentified','unidentified'),
        c('pigeon (unidentified)','songbird','blackbird spp','unidentified','unidentified','unidentified'))

which(Species_Lookup$alt.common.name=="")
Species_Lookup[-which(Species_Lookup$alt.common.name==""),]->Species_Lookup

saveRDS(Species_Lookup,file = "Species_Lookup_20240427.rds")

c('','','','','','')



# another edit I need to make the "type" other that pertains to chickens actually chickens
Species_Lookup <- readRDS(file = "Species_Lookup_20240427.rds")

which(Species_Lookup$alt.common.name=="fancy chicken")
Species_Lookup$enlish.name.ebird[290] <- "chicken"
Species_Lookup$order[290] <- "galliformes"
Species_Lookup$scientific.name[290] <- "gallus gallus"
Species_Lookup$type[290] <- "chicken"
Species_Lookup$type[199] <- "chicken"

saveRDS(Species_Lookup,file = "Species_Lookup_20240501.rds")

#changing turkeys
Species_Lookup <- readRDS(file = "Species_Lookup_20240427.rds")

Species_Lookup |>
  filter(str_detect(alt.common.name,pattern="turkey")) |>
  select(alt.common.name,type,enlish.name.ebird)

Species_Lookup$enlish.name.ebird[which(Species_Lookup$alt.common.name=="turkey")] <- "domestic turkey"
Species_Lookup$type[which(Species_Lookup$alt.common.name=="turkey")] <- "domestic poultry"

colnames(Species_Lookup[,4]) <- "english.name.ebird"

#Lets also adjust the other domestic poultry while we are here.
Species_Lookup |>
  filter(str_detect(alt.common.name,pattern="duck") & type=="other") |>
  select(alt.common.name,type,enlish.name.ebird) |> pull(alt.common.name) -> dom_duck_idx

# adjust the
saveRDS(Species_Lookup,file = "Species_Lookup_20240501.rds")



### Update on 20240529
# need to add some new names based on the recent sequence dump that the GISAID had.

Species_Lookup <- readRDS(file = "Species_Lookup_20240501.rds")
c('','','','','','')

Species_Lookup <- Species_Lookup |>
  rbind(c('rosss goose','goose/swan','anser rossii',"ross's goose",'anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('swainsons hwak','raptor/owl/falcon','buteo swainsoni',"swainson's hawk",'accipitriformes','accipitridae (hawks, eagles, and kites)'),
        c('taiwanese chicken','chicken','gallus gallus','chicken','galliformes','phasianidae (pheasants, grouse, and allies)'),
        c('pintail','seaduck','anas acuta','northern pintail','anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('eider','seaduck','eider spp','eider spp','NA','NA'),
        c('thayers gull','gull','larus glaucoides thayeri','thayers gull','charadriiformes','laridae (gulls, terns, and skimmers)'),
        c('greater yellowlegs','shorebird','tringa melanoleuca','greater yellowlegs','charadriiformes','scolopacidae (sandpipers and allies)'),
        c('harriss hawk','raptor/owl/falcon','parabuteo unicinctus',"harris's hawk",'accipitriformes','accipitridae (hawks, eagles, and kites)'),
        c('grackle','songbird','grackle spp','grackle spp','NA','NA'),
        c('franklins gull','gull','leucophaeus pipixcan','franklin gull','charadriiformes','laridae (gulls, terns, and skimmers)'),
        c('blackbird','songbird','blackbird spp','blackbird spp','NA','NA'),
        c('broiler breeders chicken','chicken','gallus gallus','chicken','galliformes','phasianidae (pheasants, grouse, and allies)'),
        c('laridae','seabird','laridae spp','laridae spp','NA','NA'),
        c('multispecies','NA','NA','NA','NA','NA'),
        c('black brant','goose/swan','branta bernicla','brant','anseriformes','anatidae (ducks, geese, and waterfowl)'),
        c('domestic turkey','domestic poultry','meleagris gallopavo','domestic turkey','galliformes','phasianidae (pheasants, grouse, and allies)'),
        c('iceland gull','gull','larus glaucoides','iceland gull','charadriiformes','laridae (gulls, terns, and skimmers)'),
        c('great grey owl','raptor/owl/falcon','strix nebulosa','great grey owl','strigiformes','strigidae (owls)'),
        c('common barn owl','raptor/owl/falcon','tyto alba','barn owl','strigiformes','strigidae (owls)'),
        c('pigeon','other','columba livia','rock pigeon','columbiformes','columbidae (pigeons and doves)'))

Species_Lookup |>
  filter(alt.common.name=="pigeon (unidentified)")

which(Species_Lookup$alt.common.name=="pigeon (unidentified)")
Species_Lookup[-442,] -> Species_Lookup

Species_Lookup |>
  rbind(c('pigeon (unidentified)','other','pigeon spp','pigeon spp','NA','NA'))-> Species_Lookup

saveRDS(object = Species_Lookup,file = "Species_Lookup_20240529.rds")


## another fix on 29MAY2024
Species_Lookup <- readRDS(file = "Species_Lookup_20240529.rds")

Species_Lookup <- Species_Lookup |>
  rbind(c('mixed','NA','NA','NA','NA','NA'))

saveRDS(object = Species_Lookup,file = "Species_Lookup_20240529.rds")

### Another update on 29MAY2024
Species_Lookup <- readRDS(file = "Species_Lookup_20240529.rds")

Species_Lookup <- Species_Lookup |>
  rbind(c('swainsons hawk','raptor/owl/falcon','buteo swainsoni',"swainson's hawk",'accipitriformes','accipitridae (hawks, eagles, and kites)'))

saveRDS(object = Species_Lookup,file = "Species_Lookup_20240529.rds")


#### Udpating the other type in the dataset 30MAY2024 ####

Species_Lookup <- readRDS(file = "Species_Lookup_20240529.rds")

# fix the condor
Species_Lookup$type[which(Species_Lookup$enlish.name.ebird=="california condor")] <- "raptor/owl/falcon"

# fix domestic chicken and fancy chicken
Species_Lookup$type[which(Species_Lookup$alt.common.name=="domestic chicken")] <- "chicken"
Species_Lookup$type[which(Species_Lookup$alt.common.name=="fancy chicken")] <- "chicken"


Species_Lookup |>
  filter(type=="other") |>
  pull(order) |>
  unique()

Species_Lookup |>
  filter(type=="other") |>
  filter(order=="galliformes") |>
  group_by(enlish.name.ebird) |>
  count()


saveRDS(object = Species_Lookup,file = "Species_Lookup_20240530.rds")


### ADDING IN DOMESTIC VS WILD

Species_Lookup <- readRDS(file = "Species_Lookup_20240530.rds")

Species_Lookup |>
  filter(type=="other") |>
  pull(enlish.name.ebird) |> unique()

Species_Lookup |>
  mutate(domestic="NA") |>
  mutate(domestic=ifelse(type=="chicken",yes="domestic",domestic)) |>
  mutate(domestic=ifelse(type=="domestic poultry",yes="domestic",domestic)) |>
  mutate(domestic = ifelse(domestic=="NA",yes="wild",domestic))-> Species_Lookup

saveRDS(object = Species_Lookup,file = "Species_Lookup_20240531.rds")

### Adding in species from USDA Data 25JUL2024:
Species_Lookup <- readRDS(file = "Development/Species_Lookup_20240531.rds")

Species_Lookup <- Species_Lookup |>
  rbind(c('eurasian collared dove','other','streptopelia decaocto',"eurasian collard dove",'columbiformes','columbidae (pigeons and doves)','wild')) |>
  rbind(c('summer tanager','songbird','piranga rubra','summer tanager','passeriformes','cardinalidae (cardinals and allies)','wild')) |>
  rbind(c('northen pintail','seaduck','anas acuta','northern pintail','anseriformes','
anatidae (ducks, geese, and waterfowl)','wild')) |>
  rbind(c('warbler (unidentified)','songbird','warbler spp','na','unidentified','unidentified','wild'))

saveRDS(object = Species_Lookup,file = "Development/Species_Lookup_20240725.rds")
