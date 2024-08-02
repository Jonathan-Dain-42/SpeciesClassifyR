
<!-- README.md is generated from README.Rmd. Please edit that file -->

# SpeciesClassifyR

<!-- badges: start -->
<!-- badges: end -->

<img src="Development_Speccies_Class/Untitled-1.png"
data-fig-align="center" />

The goal of SpeciesClassifier is to make the process of dealing with
avian species data less of a headache. This package contains several
functions that aim to replace common species names with latin species
names. In addition the functions will also add order and family
taxonomic labels.

## Installation

You can install the development version of SpeciesClassifyR from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github("Jonathan-Dain-42/SpeciesClassifyR")
```

## Example

This is a basic example in which we take common names and add in a latin
name column, a family column, and an order column.

``` r
library(SpeciesClassifyR)

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

## Additional Information:

A full tutorial on the other functions that this package contains can be
found on my academic blog [here]()
