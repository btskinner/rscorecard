# Commands

There are two basic types of commands:

1.  **Bookend commands** that start and stop the API request
2.  **Subsetting commands** that filter the specific data elements
    requested

The third command,
[`sc_dict()`](https://www.btskinner.io/rscorecard/reference/sc_dict.md),
may be used to explore the College Scorecard data dictionary.

## Bookend commands

### `sc_init()`

Use
[`sc_init()`](https://www.btskinner.io/rscorecard/reference/sc_init.md)
to start the command chain. The only real option is whether you want to
use standard variable names (as they are found in IPEDS) or the new
developer-friendly variable names developed for the Scorecard API.
Unless you have good reason for doing so, I recommend using the default
standard names. If you want to use the developer-friendly names, set
`dfvars = TRUE`. Whichever you choose, you’re stuck with that option for
the length of piped command chain; no switching from one type to
another.

### `sc_get()`

Use
[`sc_get()`](https://www.btskinner.io/rscorecard/reference/sc_get.md) as
the last command in the chain. If you haven’t used `sc_key` to store
your data.gov API key in the system environment, then you must supply
your key as an argument.

## Subsetting commands

The following commands are structured to behave like
[`dplyr`](https://CRAN.R-project.org/package=dplyr). They can be placed
in any order in the piped command chain and each one relies (for the
most part) on [non-standard
evaluation](https://cran.r-project.org/package=dplyr/vignettes/programming.html)
for its arguments. This means that you don’t have to quote variable
names.

### `sc_select()`

Use
[`sc_select()`](https://www.btskinner.io/rscorecard/reference/sc_select.md)
to select the variables (columns) you want in your final dataframe.
These variables do not have to be the same as those used to filter the
data and are case insensitive. Separate the variable names with commas.
The Scorecard API requires that most of the variables be prepended with
their category.
[`sc_select()`](https://www.btskinner.io/rscorecard/reference/sc_select.md)
uses a hash table to do this automatically for you so you do not have to
know or include those (and in fact should not). This command is the only
one of the subsetting commands that is required to pull data.

### `sc_filter()`

Use
[`sc_filter()`](https://www.btskinner.io/rscorecard/reference/sc_filter.md)
to filter the rows you want in your final dataframe. Its main job is to
convert idiomatic R code into the format required by the Scorecard API.
Like
[`sc_select()`](https://www.btskinner.io/rscorecard/reference/sc_select.md),
`sc_filter` prepends variable categories automatically and variables are
case insensitive. Like with
[`dplyr::filter()`](https://dplyr.tidyverse.org/reference/filter.html),
separate each filtering expression with a comma.There are a few points
to note owing to the idiosyncracies of the Scorecard API. First, there
are the conversions between R and the Scorecard, shown in the table
below.

| Scorecard      | R                                      | R example                           | Conversion                           |
|:---------------|:---------------------------------------|:------------------------------------|:-------------------------------------|
| `,`            | [`c()`](https://rdrr.io/r/base/c.html) | `sc_filter(stabbr == c("KY","TN"))` | `school.state=KY,TN`                 |
| `__not`        | `!=`                                   | `sc_filter(stabbr != "KY")`         | `school.state__not=KY`               |
| `__range`,`..` | `#:#`                                  | `sc_filter(ccbasic==10:14)`         | `school.carnegie_basic__range=1..14` |
| spaces (`%20`) | ” ”                                    | `sc_filter(instnm == "New York")`   | `school.name=New%20York`             |

A few notes:

1.  While R can handle a mixture of discrete and ranged values of a
    single variable (`c(1,2,5:10)`), it does not appear that Scorecard
    API can. You will either have to overselect and then filter the
    downloaded dataframe or list every value discretely.
2.  The Scorecard API does not appear to handle `>` or `<` symbols. This
    means that if you want to select a range of values above a certain
    threshold (*e.g.,* enrollments above 10,000 students), you may have
    to give a range of from 10001 to an artifically large number. Same
    thing but reversed for values under a certain threshold.
3.  Ranged values are inclusive so `1:10` will convert to
    `__range=1..10` and include both 1 and 10.

### `sc_year()`

All Scorecard variables except those in the root and school categories
take a year option. Simply set the data year you want. For the latest
data, you can either use `sc_year("latest")` or leave out
[`sc_year()`](https://www.btskinner.io/rscorecard/reference/sc_year.md)
entirely, which will default to the latest data.

**Two important points:**

1.  There is not a consistent scheme mapping data to year. In some
    cases, data year is the year of collection. In school-year spans
    (*e.g.,* 2010-2011), the data year is 2010. In some cases, the
    Scorecard data are defaulted to a different year. You should consult
    the [Scorecard
    Documentation](https://collegescorecard.ed.gov/assets/FullDataDocumentation.pdf)
    to be sure you are getting what you expect.
2.  At this time is only possible to pull down a single year of data at
    a time.

### `sc_zip()`

Use
[`sc_zip()`](https://www.btskinner.io/rscorecard/reference/sc_zip.md) to
subset the sample to those institutions within a certain distance around
a given zip code. Only one zip code may be given. The default is
distance is 25 miles, but both the distance and metric (miles or
kilometers) can be changed.

## Data dictionary

Users can search data elements in the College Scorecard data dictionary
using
[`sc_dict()`](https://www.btskinner.io/rscorecard/reference/sc_dict.md).

``` r
library(rscorecard)
```

``` r
## simple search for "state" in any part of the dictionary
sc_dict("stabbr")
#> 
#> ---------------------------------------------------------------------
#> varname: stabbr                                         source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> State postcode
#> 
#> VALUES: NA
#> 
#> CAN FILTER? Yes
#> 
#> ---------------------------------------------------------------------
#> Printed information for 1 of out 1 variables.
```

You can also search using regular expressions and limit the search to
only one dictionary column. For example, the search below only looks for
**varnames** starting with “st”:

``` r
## variable names starting with "st"
sc_dict("^st", search_col = "varname")
#> 
#> ---------------------------------------------------------------------
#> varname: stabbr                                         source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> State postcode
#> 
#> VALUES: NA
#> 
#> CAN FILTER? Yes
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: st_fips                                        source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> FIPS code for state
#> 
#> VALUES: 
#> 
#> 1 = Alabama
#> 2 = Alaska
#> 4 = Arizona
#> 5 = Arkansas
#> 6 = California
#> 8 = Colorado
#> 9 = Connecticut
#> 10 = Delaware
#> 11 = District of Columbia
#> 12 = Florida
#> 13 = Georgia
#> 15 = Hawaii
#> 16 = Idaho
#> 17 = Illinois
#> 18 = Indiana
#> 19 = Iowa
#> 20 = Kansas
#> 21 = Kentucky
#> 22 = Louisiana
#> 23 = Maine
#> 24 = Maryland
#> 25 = Massachusetts
#> 26 = Michigan
#> 27 = Minnesota
#> 28 = Mississippi
#> 29 = Missouri
#> 30 = Montana
#> 31 = Nebraska
#> 32 = Nevada
#> 33 = New Hampshire
#> 34 = New Jersey
#> 35 = New Mexico
#> 36 = New York
#> 37 = North Carolina
#> 38 = North Dakota
#> 39 = Ohio
#> 40 = Oklahoma
#> 41 = Oregon
#> 42 = Pennsylvania
#> 44 = Rhode Island
#> 45 = South Carolina
#> 46 = South Dakota
#> 47 = Tennessee
#> 48 = Texas
#> 49 = Utah
#> 50 = Vermont
#> 51 = Virginia
#> 53 = Washington
#> 54 = West Virginia
#> 55 = Wisconsin
#> 56 = Wyoming
#> 60 = American Samoa
#> 64 = Federated States of Micronesia
#> 66 = Guam
#> 69 = Northern Mariana Islands
#> 70 = Palau
#> 72 = Puerto Rico
#> 78 = Virgin Islands
#> 
#> CAN FILTER? Yes
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: stufacr                                        source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> Undergraduate student to instructional faculty ratio
#> 
#> VALUES: NA
#> 
#> CAN FILTER? No
#> 
#> ---------------------------------------------------------------------
#> Printed information for 3 of out 3 variables.
```

You can also return the data dictionary as a tibble. When storing the
dictionary in an object, it may be useful to set `print_off = TRUE` so
that the dictionary results don”t print to the console:

``` r
dict_df <- sc_dict("stabbr", print_off = TRUE, return_df = TRUE)
dict_df
#> # A tibble: 1 × 9
#>   varname value label description    source dev_friendly_name dev_category notes
#>   <chr>   <dbl> <chr> <chr>          <chr>  <chr>             <chr>        <chr>
#> 1 stabbr     NA NA    State postcode IPEDS  state             school       NA   
#> # ℹ 1 more variable: can_filter <dbl>
```

If you want the full data dictionary, simply search for `"."`:

``` r
dict_df <- sc_dict(".", print_off = TRUE, return_df = TRUE)
dict_df
#> # A tibble: 3,755 × 9
#>    varname   value label description source dev_friendly_name dev_category notes
#>    <chr>     <dbl> <chr> <chr>       <chr>  <chr>             <chr>        <chr>
#>  1 unitid       NA NA    Unit ID fo… IPEDS  id                root         NA   
#>  2 opeid        NA NA    8-digit OP… IPEDS  ope8_id           root         NA   
#>  3 opeid6       NA NA    6-digit OP… IPEDS  ope6_id           root         NA   
#>  4 instnm       NA NA    Institutio… IPEDS  name              school       NA   
#>  5 city         NA NA    City        IPEDS  city              school       NA   
#>  6 stabbr       NA NA    State post… IPEDS  state             school       NA   
#>  7 zip          NA NA    ZIP code    IPEDS  zip               school       NA   
#>  8 accredag…    NA NA    Accreditor… FSA    accreditor        school       NA   
#>  9 insturl      NA NA    URL for in… IPEDS  school_url        school       NA   
#> 10 npcurl       NA NA    URL for in… IPEDS  price_calculator… school       NA   
#> # ℹ 3,745 more rows
#> # ℹ 1 more variable: can_filter <dbl>
```
