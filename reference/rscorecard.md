# rscorecard: A Method to Download College Scorecard Data.

The rscorecard package provides a series of piped functions (a la
[dplyr](https://CRAN.R-project.org/package=dplyr)) to facilitate
downloading Department of Education College Scorecard data. In reality
it is simply a method for converting idiomatic R code into a properly
formatted URL string that is then queried. This package requires an API
key, which can be requested at <https://api.data.gov/signup/>.

## Details

All command pipes must start with
[`sc_init()`](https://www.btskinner.io/rscorecard/reference/sc_init.md),
end with
[`sc_get()`](https://www.btskinner.io/rscorecard/reference/sc_get.md),
and be linked with the base pipe, `|>`, or magrittr pipe function,
`%>%`. Internal commands,
[`sc_select`](https://www.btskinner.io/rscorecard/reference/sc_select.md),
[`sc_filter`](https://www.btskinner.io/rscorecard/reference/sc_filter.md),
[`sc_year`](https://www.btskinner.io/rscorecard/reference/sc_year.md),
[`sc_zip`](https://www.btskinner.io/rscorecard/reference/sc_zip.md), can
come in any order in the pipe chain. Only
[`sc_select`](https://www.btskinner.io/rscorecard/reference/sc_select.md)
is required.

## See also

Useful links:

- <https://www.btskinner.io/rscorecard/>

- Report bugs at <https://github.com/btskinner/rscorecard/issues>

## Author

**Maintainer**: Benjamin Skinner <ben@btskinner.io>
([ORCID](https://orcid.org/0000-0002-0337-7415))
