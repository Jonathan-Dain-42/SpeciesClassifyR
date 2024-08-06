## code to prepare `Species_Lookup_20240806.R` dataset goes here

library(devtools)

data("Species_Lookup_20240725")

#make a blank to copy further down:

# update_lookup(common.name = '',
#               type = 'NA',
#               scientific.name = '',
#               english.name.ebird = '',
#               order = '',
#               family = '',
#               domestic = 'wild',
#               lookup_table = new_lookup) -> new_lookup

#begin with making the first update:
update_lookup(common.name = 'Ruff',
              type = 'NA',
              scientific.name = 'Calidris pugnax',
              english.name.ebird = 'Ruff',
              order = 'Charadriiformes',
              family = 'scolopacidae (sandpipers and allies)',
              domestic = 'wild')->new_lookup
#now just build off of this new lookup sheet.
update_lookup(common.name = 'White Stork',
              type = 'NA',
              scientific.name = 'Ciconia ciconia',
              english.name.ebird = 'White Stork',
              order = 'Ciconiiformes',
              family = 'Ciconiidae (storks)',
              domestic = 'wild',lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'White-winged Widowbird',
              type = 'NA',
              scientific.name = 'Euplectes albonotatus',
              english.name.ebird = 'White-winged Widowbird',
              order = 'Passeriformes',
              family = 'Ploceidae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Egyptian Goose',
              type = 'NA',
              scientific.name = 'Alopochen aegyptiaca',
              english.name.ebird = 'Egyptian Goose',
              order = 'Anseriformes',
              family = 'anatidae (ducks, geese, and waterfowl)',
              domestic = 'wild',
              lookup_table = new_lookup) ->new_lookup

update_lookup(common.name = 'Blacksmith Lapwing',
              type = 'NA',
              scientific.name = 'Vanellus armatus',
              english.name.ebird = 'Blacksmith Lapwing',
              order = 'Charadriiformes',
              family = 'charadriidae (plovers and lapwings)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Collared Pratincole',
              type = 'NA',
              scientific.name = 'Glareola pratincola',
              english.name.ebird = 'Collared Pratincole',
              order = 'Charadriiformes',
              family = 'Glareolidae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Long-tailed Cormorant',
              type = 'NA',
              scientific.name = 'Microcarbo africanus',
              english.name.ebird = 'Long-tailed Cormorant',
              order = 'Suliformes',
              family = 'phalacrocoracidae (cormorants and shags)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'African Spoonbill',
              type = 'NA',
              scientific.name = 'Platalea alba',
              english.name.ebird = 'African Spoonbill',
              order = 'Pelecaniformes',
              family = 'threskiornithidae (ibises and spoonbills)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Blue-cheeked Bee-eater',
              type = 'NA',
              scientific.name = 'Merops persicus',
              english.name.ebird = 'Blue-cheeked Bee-eater',
              order = 'Coraciiformes',
              family = 'Meropidae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Black-winged Pratincole',
              type = 'NA',
              scientific.name = 'Glareola nordmanni',
              english.name.ebird = 'Black-winged Pratincole',
              order = 'Charadriiformes',
              family = 'Glareolidae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Gull-billed Tern',
              type = 'NA',
              scientific.name = 'Gelochelidon nilotica',
              english.name.ebird = 'Gull-billed Tern',
              order = 'Charadriiformes',
              family = 'laridae (gulls, terns, and skimmers)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Common Ringed Plover',
              type = 'NA',
              scientific.name = 'Charadrius hiaticula',
              english.name.ebird = 'Common Ringed Plover',
              order = 'Charadriiformes',
              family = 'charadriidae (plovers and lapwings)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'African Darter',
              type = 'NA',
              scientific.name = 'Anhinga rufa',
              english.name.ebird = 'African Darter',
              order = 'Suliformes',
              family = 'Anhingidae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Greater Flamingo',
              type = 'NA',
              scientific.name = 'Phoenicopterus roseus',
              english.name.ebird = 'Greater Flamingo',
              order = 'Phoenicopteriformes',
              family = 'phoenicopteridae (flamingos)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Great White Pelican',
              type = 'NA',
              scientific.name = 'Pelecanus onocrotalus',
              english.name.ebird = 'Great White Pelican',
              order = 'Pelecaniformes',
              family = 'pelecanidae (pelicans)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Curlew Sandpiper',
              type = 'NA',
              scientific.name = 'Calidris ferruginea',
              english.name.ebird = 'Curlew Sandpiper',
              order = 'Charadriiformes',
              family = 'scolopacidae (sandpipers and allies)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Yellow Bishop',
              type = 'NA',
              scientific.name = 'Euplectes capensis',
              english.name.ebird = 'Yellow Bishop',
              order = 'Passeriformes',
              family = 'Ploceidae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Spur-winged Goose',
              type = 'NA',
              scientific.name = 'Plectropterus gambensis',
              english.name.ebird = 'Spur-winged Goose',
              order = 'Anseriformes',
              family = 'anatidae (ducks, geese, and waterfowl)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Blue-billed Teal',
              type = 'NA',
              scientific.name = 'Spatula hottentota',
              english.name.ebird = 'Blue-billed Teal',
              order = 'Anseriformes',
              family = 'anatidae (ducks, geese, and waterfowl)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'African Green-Pigeon',
              type = 'NA',
              scientific.name = 'Treron calvus',
              english.name.ebird = 'African Green-Pigeon',
              order = 'Columbiformes',
              family = 'columbidae (pigeons and doves)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Yellow-throated Sandgrouse',
              type = 'NA',
              scientific.name = 'Pterocles gutturalis',
              english.name.ebird = 'Yellow-throated Sandgrouse',
              order = 'Pterocliformes',
              family = 'Pteroclidae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Black-winged Stilt',
              type = 'NA',
              scientific.name = 'Himantopus himantopus',
              english.name.ebird = 'Black-winged Stilt',
              order = 'Charadriiformes',
              family = 'Recurvirostridae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Lesser Jacana',
              type = 'NA',
              scientific.name = 'Microparra capensis',
              english.name.ebird = 'Lesser Jacana',
              order = 'Charadriiformes',
              family = 'Jacanidae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'African Openbill',
              type = 'NA',
              scientific.name = 'Anastomus lamelligerus',
              english.name.ebird = 'African Openbill',
              order = 'Ciconiiformes',
              family = 'Ciconiidae (storks)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Chestnut-backed Sparrow-Lark',
              type = 'NA',
              scientific.name = 'Eremopterix leucotis',
              english.name.ebird = 'Chestnut-backed Sparrow-Lark',
              order = 'Passeriformes',
              family = 'Alaudidae',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Helmeted Guineafowl',
              type = 'NA',
              scientific.name = 'Numida meleagris',
              english.name.ebird = 'Helmeted Guineafowl',
              order = 'Galliformes',
              family = 'numididae (guinea fowl)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Caspian Plover',
              type = 'NA',
              scientific.name = 'Anarhynchus asiaticus',
              english.name.ebird = 'Caspian Plover',
              order = 'Charadriiformes',
              family = 'charadriidae (plovers and lapwings)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Caspian Tern',
              type = 'NA',
              scientific.name = 'Hydroprogne caspia',
              english.name.ebird = 'Caspian Tern',
              order = 'Charadriiformes',
              family = 'laridae (gulls, terns, and skimmers)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = 'Southern Pochard',
              type = 'NA',
              scientific.name = 'Netta erythrophthalma',
              english.name.ebird = 'Southern Pochard',
              order = 'Anseriformes',
              family = 'anatidae (ducks, geese, and waterfowl)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

update_lookup(common.name = "Swainson's Spurfowl",
              type = 'NA',
              scientific.name = 'Pternistis swainsonii',
              english.name.ebird = "Swainsons Spurfowl",
              order = 'Galliformes',
              family = 'phasianidae (pheasants, grouse, and allies)',
              domestic = 'wild',
              lookup_table = new_lookup) -> new_lookup

#make it lowercase
new_lookup |>
  dplyr::mutate_all(.funs=tolower)->new_lookup
#rename to Species_Lookup_20240806
Species_Lookup_20240806 <- new_lookup

usethis::use_data(Species_Lookup_20240806, overwrite = TRUE)
