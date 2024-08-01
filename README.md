
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

classify_species.common(data = test_dat,species_col = "Species") |> head()
#> # A tibble: 6 × 6
#>   Species          Location     Collection_Date family     order scientific.name
#>   <chr>            <chr>        <date>          <chr>      <chr> <chr>          
#> 1 blue-winged teal texas        2022-09-01      anatidae … anse… spatula discors
#> 2 turkey           minnesota    2022-04-19      phasianid… gall… meleagris gall…
#> 3 turkey           minnesota    2022-04-19      phasianid… gall… meleagris gall…
#> 4 blue-winged teal texas        2022-10-01      anatidae … anse… spatula discors
#> 5 chicken          north_dakota 2022-04-19      phasianid… gall… gallus gallus  
#> 6 blue-winged teal minnesota    2022-09-15      anatidae … anse… spatula discors
```
