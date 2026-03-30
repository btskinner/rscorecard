# Filter scorecard data by variable values.

This function is used to filter the downloaded scorecard data. It
converts idiomatic R into the format required by the API call.

## Usage

``` r
sc_filter(sccall, ...)

sc_filter_(sccall, filter_string)
```

## Arguments

- sccall:

  Current list of parameters carried forward from prior functions in the
  chain (ignore)

- ...:

  Expressions to evaluate

- filter_string:

  Filter as character string or vector of filters as character strings

## Functions

- `sc_filter_()`: Standard evaluation version of `sc_filter`
  (`filter_string` must be a string or vector of strings when using this
  version)

## Examples

``` r
if (FALSE) { # \dontrun{
sc_filter(region == 1) # New England institutions
sc_filter(stabbr == c("TN","KY")) # institutions in Tennessee and Kentucky
sc_filter(control != 3) # exclude private, for-profit institutions
sc_filter(control == c(1,2)) # same as above
sc_filter(control == 1:2) # same as above
sc_filter(stabbr == "TN", control == 1, locale == 41:43) # TN rural publics
} # }
if (FALSE) { # \dontrun{
sc_filter_("region == 1")
sc_filter_("control != 3")

## With internal strings, you must either use both double and single quotes
## or escape internal quotes
sc_filter_("stabbr == c('TN','KY')")
sc_filter_('stabbr == c(\'TN\',\'KY\')')

## stored in object
filters <- c("control == 1", "locale == 41:43")
sc_filter_(filters)
} # }
```
