
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SpeciesClassifier

<!-- badges: start -->
<!-- badges: end -->

The goal of SpeciesClassifier is to make the process of dealing with
avian species data less of a headache. This package contains several
functions that aim to replace common species names with latin species
names. In addition the functions will also add order and family
taxonomic labels.

## Installation

You can install the development version of SpeciesClassifier from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Jonathan-Dain-42/SpeciesClassifier")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(SpeciesClassifier)

## basic example code
load("data/test_dat.rda")

head(test_dat) #Notice the common names are in the "Species" column
#>            Species     Location Collection_Date
#> 1 blue-winged teal        texas      2022-09-01
#> 2           turkey    minnesota      2022-04-19
#> 3           turkey    minnesota      2022-04-19
#> 4 blue-winged teal        texas      2022-10-01
#> 5          chicken north_dakota      2022-04-19
#> 6 blue-winged teal    minnesota      2022-09-15

classify_species.common(data = test_dat,species_col = "Species")
#>                Species                  Location Collection_Date
#> 1     blue-winged teal                     texas      2022-09-01
#> 2               turkey                 minnesota      2022-04-19
#> 3               turkey                 minnesota      2022-04-19
#> 4     blue-winged teal                     texas      2022-10-01
#> 5              chicken              north_dakota      2022-04-19
#> 6     blue-winged teal                 minnesota      2022-09-15
#> 7        black vulture                   georgia      2022-11-02
#> 8               turkey              north_dakota      2022-04-19
#> 9               turkey              north_dakota      2022-04-19
#> 10       black vulture                 louisiana      2023-02-07
#> 11             chicken              pennsylvania      2022-04-19
#> 12             chicken              pennsylvania      2022-04-19
#> 13    blue-winged teal                 minnesota      2022-09-01
#> 14       black vulture            north_carolina      2022-11-04
#> 15    blue-winged teal                 minnesota      2022-09-01
#> 16       black vulture                   georgia      2022-10-01
#> 17       black vulture                 louisiana      2023-02-08
#> 18    blue-winged teal                     texas      2022-10-01
#> 19              turkey                 minnesota      2022-04-19
#> 20             chicken              pennsylvania      2022-04-19
#> 21             chicken                   ontario      2022-04-07
#> 22             mallard                    quebec      2022-04-07
#> 23             chicken                   alberta      2022-04-06
#> 24              turkey                   alberta      2022-04-06
#> 25              turkey                   alberta      2022-04-06
#> 26             chicken                   alberta      2022-04-07
#> 27 american black duck newfoundland_and_labrador      2021-12-24
#> 28 american black duck newfoundland_and_labrador      2021-12-24
#> 29          bald eagle      prince_edward_island      2022-01-22
#> 30        canada goose               nova_scotia      2022-01-12
#> 31        herring gull newfoundland_and_labrador      2022-01-14
#> 32       american crow newfoundland_and_labrador      2022-01-18
#> 33              turkey                   ontario      2022-03-26
#> 34              turkey                   ontario      2022-03-26
#> 35              turkey                   ontario      2022-03-26
#> 36             mallard               nova_scotia      2022-01-27
#> 37              turkey                   ontario      2022-03-29
#> 38              turkey                   ontario      2022-03-29
#> 39              turkey                   ontario      2022-03-29
#> 40             chicken                   alberta      2022-04-06
#> 41              turkey                   ontario      2022-03-26
#> 42              turkey                   ontario      2022-03-26
#> 43              turkey                   ontario      2022-03-27
#> 44              turkey                   ontario      2022-03-29
#> 45       american crow newfoundland_and_labrador      2022-03-12
#> 46       american crow             new_brunswick      2022-03-09
#> 47        canada goose               nova_scotia      2022-03-09
#> 48       american crow             new_brunswick      2022-03-11
#> 49     red-tailed hawk                   ontario      2022-03-11
#> 50       american crow             new_brunswick      2022-03-17
#>                                         family           order
#> 1       anatidae (ducks, geese, and waterfowl)    anseriformes
#> 2  phasianidae (pheasants, grouse, and allies)     galliformes
#> 3  phasianidae (pheasants, grouse, and allies)     galliformes
#> 4       anatidae (ducks, geese, and waterfowl)    anseriformes
#> 5  phasianidae (pheasants, grouse, and allies)     galliformes
#> 6       anatidae (ducks, geese, and waterfowl)    anseriformes
#> 7             cathartidae (new world vultures)  cathartiformes
#> 8  phasianidae (pheasants, grouse, and allies)     galliformes
#> 9  phasianidae (pheasants, grouse, and allies)     galliformes
#> 10            cathartidae (new world vultures)  cathartiformes
#> 11 phasianidae (pheasants, grouse, and allies)     galliformes
#> 12 phasianidae (pheasants, grouse, and allies)     galliformes
#> 13      anatidae (ducks, geese, and waterfowl)    anseriformes
#> 14            cathartidae (new world vultures)  cathartiformes
#> 15      anatidae (ducks, geese, and waterfowl)    anseriformes
#> 16            cathartidae (new world vultures)  cathartiformes
#> 17            cathartidae (new world vultures)  cathartiformes
#> 18      anatidae (ducks, geese, and waterfowl)    anseriformes
#> 19 phasianidae (pheasants, grouse, and allies)     galliformes
#> 20 phasianidae (pheasants, grouse, and allies)     galliformes
#> 21 phasianidae (pheasants, grouse, and allies)     galliformes
#> 22      anatidae (ducks, geese, and waterfowl)    anseriformes
#> 23 phasianidae (pheasants, grouse, and allies)     galliformes
#> 24 phasianidae (pheasants, grouse, and allies)     galliformes
#> 25 phasianidae (pheasants, grouse, and allies)     galliformes
#> 26 phasianidae (pheasants, grouse, and allies)     galliformes
#> 27      anatidae (ducks, geese, and waterfowl)    anseriformes
#> 28      anatidae (ducks, geese, and waterfowl)    anseriformes
#> 29     accipitridae (hawks, eagles, and kites) accipitriformes
#> 30      anatidae (ducks, geese, and waterfowl)    anseriformes
#> 31        laridae (gulls, terns, and skimmers) charadriiformes
#> 32         corvidae (crows, jays, and magpies)   passeriformes
#> 33 phasianidae (pheasants, grouse, and allies)     galliformes
#> 34 phasianidae (pheasants, grouse, and allies)     galliformes
#> 35 phasianidae (pheasants, grouse, and allies)     galliformes
#> 36      anatidae (ducks, geese, and waterfowl)    anseriformes
#> 37 phasianidae (pheasants, grouse, and allies)     galliformes
#> 38 phasianidae (pheasants, grouse, and allies)     galliformes
#> 39 phasianidae (pheasants, grouse, and allies)     galliformes
#> 40 phasianidae (pheasants, grouse, and allies)     galliformes
#> 41 phasianidae (pheasants, grouse, and allies)     galliformes
#> 42 phasianidae (pheasants, grouse, and allies)     galliformes
#> 43 phasianidae (pheasants, grouse, and allies)     galliformes
#> 44 phasianidae (pheasants, grouse, and allies)     galliformes
#> 45         corvidae (crows, jays, and magpies)   passeriformes
#> 46         corvidae (crows, jays, and magpies)   passeriformes
#> 47      anatidae (ducks, geese, and waterfowl)    anseriformes
#> 48         corvidae (crows, jays, and magpies)   passeriformes
#> 49     accipitridae (hawks, eagles, and kites) accipitriformes
#> 50         corvidae (crows, jays, and magpies)   passeriformes
#>             scientific.name
#> 1           spatula discors
#> 2       meleagris gallopavo
#> 3       meleagris gallopavo
#> 4           spatula discors
#> 5             gallus gallus
#> 6           spatula discors
#> 7          coragyps atratus
#> 8       meleagris gallopavo
#> 9       meleagris gallopavo
#> 10         coragyps atratus
#> 11            gallus gallus
#> 12            gallus gallus
#> 13          spatula discors
#> 14         coragyps atratus
#> 15          spatula discors
#> 16         coragyps atratus
#> 17         coragyps atratus
#> 18          spatula discors
#> 19      meleagris gallopavo
#> 20            gallus gallus
#> 21            gallus gallus
#> 22       anas platyrhynchos
#> 23            gallus gallus
#> 24      meleagris gallopavo
#> 25      meleagris gallopavo
#> 26            gallus gallus
#> 27            anas rubripes
#> 28            anas rubripes
#> 29 haliaeetus leucocephalus
#> 30        branta canadensis
#> 31         larus argentatus
#> 32    corvus brachyrhynchos
#> 33      meleagris gallopavo
#> 34      meleagris gallopavo
#> 35      meleagris gallopavo
#> 36       anas platyrhynchos
#> 37      meleagris gallopavo
#> 38      meleagris gallopavo
#> 39      meleagris gallopavo
#> 40            gallus gallus
#> 41      meleagris gallopavo
#> 42      meleagris gallopavo
#> 43      meleagris gallopavo
#> 44      meleagris gallopavo
#> 45    corvus brachyrhynchos
#> 46    corvus brachyrhynchos
#> 47        branta canadensis
#> 48    corvus brachyrhynchos
#> 49        buteo jamaicensis
#> 50    corvus brachyrhynchos
```
