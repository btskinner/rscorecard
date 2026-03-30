# Changelog

## rscorecard v0.33.0

- update dictionary for 30 March 2026 release of data

## rscorecard v0.32.0

CRAN release: 2025-05-12

- update dictionary for 23 April 2025 release of data

## rscorecard v0.31.0

CRAN release: 2025-04-09

- update dictionary for 16 January 2025 release of data

## rscorecard v0.30.0

CRAN release: 2024-10-23

- update dictionary for 10 October 2024 release of data

## rscorecard v0.29.0

CRAN release: 2024-08-30

- update dictionary for 13 June 2024 release of data

## rscorecard v0.28.1

CRAN release: 2024-05-28

- fix to the way columns have their types changed that takes into
  account column names since not all subsequent data pulls have the same
  columns

## rscorecard v0.28.0

- update to fix error
  [\#17](https://github.com/btskinner/rscorecard/issues/17)
- converted single quotes to double throughout
- converted old magrittr pipe to new base R pipe
- now require at least R version 4.1 (current version is 4.3.3)

## rscorecard v0.27.0

- update dictionary for 10 October 2023 release of data

## rscorecard v0.26.0

CRAN release: 2023-04-28

- update dictionary for 25 April 2023 release of data

## rscorecard v0.25.0

- update dictionary for 14 September 2022 release of data

## rscorecard v0.24.0

CRAN release: 2022-10-20

- update dictionary for 12 September 2022 release of data

## rscorecard v0.23.0

CRAN release: 2022-07-05

- update dictionary for 2 May 2022 release of data

## rscorecard v0.22.0

CRAN release: 2022-03-23

- update dictionary for 14 March 2022 release of data

## rscorecard v0.21.0

CRAN release: 2022-02-08

- update dictionary for 7 February 2022 release of data

## rscorecard v0.20.0

CRAN release: 2021-07-28

- update dictionary for 20 July 2021 release of data

## rscorecard v0.19.1

CRAN release: 2021-07-20

### Bug fix

- corrected for changes to magrittr 2.0 function evaluation order (last
  to first) that meant error messages weren’t correctly displaying

### Updates

- new error messages for missing
  [`sc_select()`](https://www.btskinner.io/rscorecard/reference/sc_select.md)
  function
- updated error messages
- additional tests for new base R pipe `|>`

## rscorecard v0.19.0

- update to only allow filtering on variables allowed due to API changes
  on 4 April 2021

## rscorecard v0.18.0

CRAN release: 2021-01-13

- update dictionary for 12 January 2021 release of data

## rscorecard v0.17.0

CRAN release: 2020-12-05

- update dictionary for 2 December 2020 release of data

## rscorecard v0.16.0

CRAN release: 2020-06-03

- update dictionary for 1 June 2020 release of data

## rscorecard v0.15.0

CRAN release: 2020-04-09

- update dictionary for 30 March 2020 release of data

## rscorecard v0.14.0

CRAN release: 2020-01-08

- update dictionary for 12 December 2019 release of data

- users can now request field of study-level data elements

- updates to
  [`sc_dict()`](https://www.btskinner.io/rscorecard/reference/sc_dict.md)
  command:

  - can now return tibble with dictionary information using `return_df`
    argument
  - can turn off printing with `print_off` argument
  - console-printed dictionary:
    - now returns data element source
    - does not return developer-friendly names by default; turn on using
      `print_dev == TRUE` argument
    - can return notes from data dictionary (if they exist) by setting
      `print_notes == TRUE`

- users can now request JSON version of returned data by using
  `return_json == TRUE` in
  [`sc_get()`](https://www.btskinner.io/rscorecard/reference/sc_get.md)

- returned data frame now puts variables in order requested in
  [`sc_select()`](https://www.btskinner.io/rscorecard/reference/sc_select.md)

- some new tests

## rscorecard v0.13.0

CRAN release: 2019-10-01

- update dictionary for 30 September 2019 release of data

## rscorecard v0.12.0

CRAN release: 2019-05-21

- update dictionary for 21 May 2019 release of data

## rscorecard v0.11.1

CRAN release: 2018-11-05

### Bug fix

- correct error in regular expression that converted dev-friendly names
  back to variable names in `sc_get` (h/t
  [@nguyentr17](https://github.com/nguyentr17))
- moved regular expression conversions to
  `utility_functions::dev_to_var`

### Updates

- added tests for conversion

## rscorecard v0.11.0

CRAN release: 2018-10-30

- update dictionary for 30 October 2018 release of data

## rscorecard v0.10.0

CRAN release: 2018-10-01

- update dictionary for 28 September 2018 release of data

## rscorecard v0.9.0

CRAN release: 2018-09-10

### Potentially breaking changes

- default value for
  [`sc_year()`](https://www.btskinner.io/rscorecard/reference/sc_year.md)
  is now `'latest'` rather than 2013. With continued data updates, this
  makes more sense than keeping an old year. Existing scripts that
  relied on the default for data from 2013 will need to be updated.  
- also note that the `year` column will be a character column with
  `latest` as the value when the most recent data are choosen. The
  College Scorecard doesn’t clearly note which data are the latest, so I
  have left the string. When building a panel dataset across multiple
  years, it will be best to use numeric year values for all years so
  that the resulting tibbles can be bound together cleanly.

### Other changes

- add support for using some tidyselect helper functions when selecting
  variables with
  [`sc_select()`](https://www.btskinner.io/rscorecard/reference/sc_select.md):
  `starts_with()`, `ends_with()`, `contains()`, and `matches()` should
  now be available.
- update dictionary for 6 September 2018 release of data

## rscorecard v0.8.0

CRAN release: 2018-08-26

### Changes

- improved error handling when submitting bad request
- added
  [`sc_select_()`](https://www.btskinner.io/rscorecard/reference/sc_select.md)
  and
  [`sc_filter_()`](https://www.btskinner.io/rscorecard/reference/sc_filter.md),
  which allow users to select and filter variables using strings stored
  in environment variable

## rscorecard v0.7.1

CRAN release: 2018-03-29

### Changes

- update dictionary for March 2018 release of scorecard data

## rscorecard v0.7.0

CRAN release: 2018-03-08

### Changes

- update dictionary for 19 December 2017 release of scorecard data

## rscorecard v0.6.0

CRAN release: 2017-12-12

### Changes

- allow
  [`sc_zip()`](https://www.btskinner.io/rscorecard/reference/sc_zip.md)
  to take zip codes that start with zero (h/t
  [@nateaff](https://github.com/nateaff)), either with string value or
  by returning leading zeros to numeric values that R drops

## rscorecard v0.5.0

CRAN release: 2017-10-20

### Changes

- changed way API call is made (now using
  [`httr`](https://CRAN.R-project.org/package=httr) to make call rather
  than `jsonlite` directly) in order to improve parsing on bad lines
- added `debug` option to
  [`sc_get()`](https://www.btskinner.io/rscorecard/reference/sc_get.md)
  so that the API URL string could be returned when debugging call
- removed old namespace import/exports no longer being used

## rscorecard v0.4.0

CRAN release: 2017-09-28

- update dictionary for 28 September 2017 release of scorecard data
- update link in introduction vignette
- change contact information
- read data dictionary sheet by name instead of sheet number when making
  `sysdata.rda` in `./data-raw/make_dict_hash.R`
- correct
  [`sc_get()`](https://www.btskinner.io/rscorecard/reference/sc_get.md)
  to use [`floor()`](https://rdrr.io/r/base/Round.html) instead of
  [`ceiling()`](https://rdrr.io/r/base/Round.html) so that it doesn’t
  make unnecessary API request/pull (h/t
  [@jjchern](https://github.com/jjchern))

## rscorecard v0.3.3

### Bug fix

- allow
  [`sc_filter()`](https://www.btskinner.io/rscorecard/reference/sc_filter.md)
  to use subset object vectors

## rscorecard v0.3.2

- allow
  [`sc_filter()`](https://www.btskinner.io/rscorecard/reference/sc_filter.md)
  to use vectors stored in objects
- allow
  [`sc_filter()`](https://www.btskinner.io/rscorecard/reference/sc_filter.md)
  to use `%in%` operator

## rscorecard v0.3.1

CRAN release: 2017-01-14

- update dictionary for 13 January 2017 release of scorecard data
- update
  [`sc_dict()`](https://www.btskinner.io/rscorecard/reference/sc_dict.md)
  to search all columns by default
- update internal hash lookup environment to have less generic name

## rscorecard v0.2.5

CRAN release: 2016-05-18

- fixed
  [`sc_dict()`](https://www.btskinner.io/rscorecard/reference/sc_dict.md)
  bug that wouldn’t allow for search by developer friendly names

## rscorecard v0.2.4

CRAN release: 2016-03-26

- initial release
