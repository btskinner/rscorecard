# More examples

``` r
library(rscorecard)
```

## Using area within zip code

``` r
## public schools within 50 miles of midtown Nashville, TN
df <- sc_init() |> 
    sc_filter(control == 1) |> 
    sc_select(unitid, instnm, stabbr) |> 
    sc_year(2013) |> 
    sc_zip(37203, 50) |>
    sc_get()
#> Request complete!
```

``` r
df
#> # A tibble: 10 × 4
#>    unitid instnm                                               stabbr  year
#>     <int> <chr>                                                <chr>  <dbl>
#>  1 219602 Austin Peay State University                         TN      2013
#>  2 219888 Columbia State Community College                     TN      2013
#>  3 219994 Tennessee College of Applied Technology-Dickson      TN      2013
#>  4 220279 Tennessee College of Applied Technology-Hartsville   TN      2013
#>  5 220978 Middle Tennessee State University                    TN      2013
#>  6 221102 Tennessee College of Applied Technology-Murfreesboro TN      2013
#>  7 221184 Nashville State Community College                    TN      2013
#>  8 221838 Tennessee State University                           TN      2013
#>  9 222053 Volunteer State Community College                    TN      2013
#> 10 248925 Tennessee College of Applied Technology Nashville    TN      2013
```

## Large pull

The College Scorecard will only return 100 results at a time. When there
are more than 100 results, the package will make multiple pulls and
append all results before returning.

``` r
## median earnings for students who first enrolled in a public
## college in the New England or Mid-Atlantic regions: 10 years later
df <- sc_init() |> 
    sc_filter(control == 1, region == 1:2, ccbasic == 1:24) |> 
    sc_select(unitid, instnm, md_earn_wne_p10) |> 
    sc_year(2009) |>
    sc_get()
#> Large request will require: 2 additional pulls.
#> Request additional chunk 1
#> Request additional chunk 2
#> Request complete!
```

``` r
df
#> # A tibble: 243 × 4
#>    unitid instnm                                     md_earn_wne_p10  year
#>     <int> <chr>                                                <int> <dbl>
#>  1 128771 Central Connecticut State University                 46400  2009
#>  2 128780 Charter Oak State College                               NA  2009
#>  3 129020 University of Connecticut                            54500  2009
#>  4 129215 Eastern Connecticut State University                 43600  2009
#>  5 129367 Connecticut State Community College                  34100  2009
#>  6 130493 Southern Connecticut State University                44300  2009
#>  7 130776 Western Connecticut State University                 44100  2009
#>  8 130907 Delaware Technical Community College-Terry           30900  2009
#>  9 130934 Delaware State University                            38100  2009
#> 10 130943 University of Delaware                               56300  2009
#> # ℹ 233 more rows
```
