# Select scorecard data year.

This function is used to select the year of the data.

## Usage

``` r
sc_year(sccall, year)
```

## Arguments

- sccall:

  Current list of parameters carried forward from prior functions in the
  chain (ignore)

- year:

  Four-digit year or string `latest` for latest data.

## Important notes

1.  Not all variables have a year option.

2.  At this time, only one year at a time is allowed.

3.  The year selected is not necessarily the year the data were
    produced. It may be the year the data were collected. For data
    collected over split years (fall to spring), it is likely the year
    represents the fall data (*e.g.,* 2011 for 2011/2012 data).

Be sure to check with the College Scorecard [data documentation
report](https://collegescorecard.ed.gov/data/data-documentation/) when
choosing the year.

## Examples

``` r
if (FALSE) { # \dontrun{
sc_year() # latest
sc_year("latest")
sc_year(2012)
} # }
```
