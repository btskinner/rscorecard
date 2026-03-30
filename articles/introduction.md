# Getting started

``` r
library(rscorecard)
```

Using [rscorecard](https://www.btskinner.io/rscorecard/) to download
data from the College Scorecard API requires two steps:

1.  Setting your API key
2.  Making a request

### 1. Setting your API key

If you don’t already have one, reqest your (free) API key from
<https://api.data.gov/signup>. It should only take a few moments to
register and receive your key.

Once you’ve gotten your key, you can store it usig
[`sc_key()`](https://www.btskinner.io/rscorecard/reference/sc_key.md).
In the absence of a key value argument,
[`sc_get()`](https://www.btskinner.io/rscorecard/reference/sc_get.md)
will search your R environment for `DATAGOV_API_KEY`. It will complete
the data request if found.
[`sc_key()`](https://www.btskinner.io/rscorecard/reference/sc_key.md)
command will store your key in `DATAGOV_API_KEY`, which will persist
until the R session is closed.

``` r
# NB: You must use a real key, of course... 
sc_key("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx")
```

If you want a more permanent solution, you can add the following line
(with your actual key, of course) to your `.Renviron` file. See this
[appendix](ftp://cran.r-project.org/pub/R/web/packages/httr/vignettes/api-packages.md)
for more information.

``` r
# NB: You must use a real key, of course... 
DATAGOV_API_KEY=xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
```

### 2. Simple request

Each request requires the following four commands piped together using
`|>`:

1.  [`sc_init()`](https://www.btskinner.io/rscorecard/reference/sc_init.md)
2.  [`sc_filter()`](https://www.btskinner.io/rscorecard/reference/sc_filter.md)
3.  [`sc_select()`](https://www.btskinner.io/rscorecard/reference/sc_select.md)
4.  [`sc_get()`](https://www.btskinner.io/rscorecard/reference/sc_get.md)

The command chain must begin with
[`sc_init()`](https://www.btskinner.io/rscorecard/reference/sc_init.md)
and end with `sc_get`. All other commands can come in any order.

The request belower should return a tibble with the name, IPEDS ID,
state, and degree-seeking undergrad enrollment of all primarily
Baccalaureate colleges in the Mid East region located in rural areas:

``` r
df <- sc_init() |> 
    sc_filter(region == 2, ccbasic == c(21,22,23), locale == 41:43) |> 
    sc_select(unitid, instnm, stabbr, ugds) |> 
    sc_get()
#> Request complete!
```

``` r
df
#> # A tibble: 10 × 5
#>    unitid instnm                                  stabbr  ugds year  
#>     <int> <chr>                                   <chr>  <int> <chr> 
#>  1 163912 St. Mary's College of Maryland          MD      1603 latest
#>  2 189088 Bard College                            NY      2414 latest
#>  3 190099 Colgate University                      NY      3180 latest
#>  4 191676 Houghton University                     NY       753 latest
#>  5 194392 Paul Smiths College of Arts and Science NY       579 latest
#>  6 196006 SUNY College of Technology at Alfred    NY      3563 latest
#>  7 196024 SUNY College of Technology at Delhi     NY      2843 latest
#>  8 196051 SUNY Morrisville                        NY      1923 latest
#>  9 211608 Cheyney University of Pennsylvania      PA       617 latest
#> 10 216807 Westminster College                     PA      1041 latest
```

Because we didn’t include a specific year, the `latest` data are
returned. We could have specifically asked for the latest data using
`sc_year("latest")`:

``` r
df <- sc_init() |> 
    sc_filter(region == 2, ccbasic == c(21,22,23), locale == 41:43) |> 
    sc_select(unitid, instnm, stabbr, ugds) |>
    sc_year("latest") |> 
    sc_get()
#> Request complete!
```

``` r
df
#> # A tibble: 10 × 5
#>    unitid instnm                                  stabbr  ugds year  
#>     <int> <chr>                                   <chr>  <int> <chr> 
#>  1 163912 St. Mary's College of Maryland          MD      1603 latest
#>  2 189088 Bard College                            NY      2414 latest
#>  3 190099 Colgate University                      NY      3180 latest
#>  4 191676 Houghton University                     NY       753 latest
#>  5 194392 Paul Smiths College of Arts and Science NY       579 latest
#>  6 196006 SUNY College of Technology at Alfred    NY      3563 latest
#>  7 196024 SUNY College of Technology at Delhi     NY      2843 latest
#>  8 196051 SUNY Morrisville                        NY      1923 latest
#>  9 211608 Cheyney University of Pennsylvania      PA       617 latest
#> 10 216807 Westminster College                     PA      1041 latest
```

For a prior year’s data, change the value in
[`sc_year()`](https://www.btskinner.io/rscorecard/reference/sc_year.md):

``` r
df <- sc_init() |> 
    sc_filter(region == 2, ccbasic == c(21,22,23), locale == 41:43) |> 
    sc_select(unitid, instnm, stabbr, ugds) |>
    sc_year(2005) |> 
    sc_get()
#> Request complete!
```

``` r
df
#> # A tibble: 10 × 5
#>    unitid instnm                                  stabbr  ugds  year
#>     <int> <chr>                                   <chr>  <int> <dbl>
#>  1 163912 St. Mary's College of Maryland          MD      1879  2005
#>  2 189088 Bard College                            NY      1831  2005
#>  3 190099 Colgate University                      NY      2743  2005
#>  4 191676 Houghton University                     NY      1368  2005
#>  5 194392 Paul Smiths College of Arts and Science NY       841  2005
#>  6 196006 SUNY College of Technology at Alfred    NY      3187  2005
#>  7 196024 SUNY College of Technology at Delhi     NY      2288  2005
#>  8 196051 SUNY Morrisville                        NY      2964  2005
#>  9 211608 Cheyney University of Pennsylvania      PA      1351  2005
#> 10 216807 Westminster College                     PA      1597  2005
```

#### Field of study data

In the fall of 2019, the College Scorecard released field of study-level
data elements (4 digit CIP code level). These data elements can be
requested alongside institution-level data:

``` r
df <- sc_init() |> 
    sc_filter(region == 2, ccbasic == c(21,22,23), locale == 41:43) |> 
    sc_select(unitid, instnm, stabbr, ugds, cipcode, cipdesc, debt_mdn) |>
    sc_year("latest") |> 
    sc_get()
#> Request complete!
```

``` r
## filter to show only those with non-NA values for median debt
df |> dplyr::filter(!is.na(debt_mdn))
#> # A tibble: 497 × 8
#>    unitid instnm                     stabbr  ugds cipcode cipdesc debt_mdn year 
#>     <int> <chr>                      <chr>  <int> <chr>   <chr>      <int> <chr>
#>  1 163912 St. Mary's College of Mar… MD      1603 0301    Natura…    17000 late…
#>  2 163912 St. Mary's College of Mar… MD      1603 0501    Area S…    17000 late…
#>  3 163912 St. Mary's College of Mar… MD      1603 1101    Comput…    17000 late…
#>  4 163912 St. Mary's College of Mar… MD      1603 1301    Educat…    17000 late…
#>  5 163912 St. Mary's College of Mar… MD      1603 1601    Lingui…    17000 late…
#>  6 163912 St. Mary's College of Mar… MD      1603 2301    Englis…    17000 late…
#>  7 163912 St. Mary's College of Mar… MD      1603 2601    Biolog…    17000 late…
#>  8 163912 St. Mary's College of Mar… MD      1603 2602    Bioche…    17000 late…
#>  9 163912 St. Mary's College of Mar… MD      1603 2615    Neurob…    17000 late…
#> 10 163912 St. Mary's College of Mar… MD      1603 2701    Mathem…    17000 late…
#> # ℹ 487 more rows
```

**Important note:**

The mapping scheme of data across years isn’t consistent across data
elements. From the [technical documentation for institution-level
data](https://collegescorecard.ed.gov/assets/FullDataDocumentation.pdf):

> The data contain diverse measures of institutional performance
> constructed both with an eye towards the type of information that
> would be most useful to prospective students, as well as towards how
> the measures might promote accountability for institutions. The
> measures require different definitions of cohorts. Users of the data
> should be aware of this, particularly when constructing analyses of
> the relationship between different measures. Moreover, reporting
> inaccuracies in some data elements used for cohort definitions are
> also important. (p. 37)

That is, while the *reporting* year (*e.g.*, `sc_year(2016)`) may be the
same, the *measurement* year may not directly align. The same holds true
when trying to align institution-level data with field of study-level
data (see the [technical documentation for field of study-level
data](https://collegescorecard.ed.gov/assets/FieldOfStudyDataDocumentation.pdf)
for more information).

The upshot is that [rscorecard](https://www.btskinner.io/rscorecard/)
will return data based on what the API call returns, but the user should
take care to ensure that returned data elements align with expectations
and project needs.

## More information and examples

For more information about each command, see
[Commands](https://www.btskinner.io/rscorecard/articles/commands.html).

For more examples, see [More
examples](https://www.btskinner.io/rscorecard/articles/more_examples.html).
