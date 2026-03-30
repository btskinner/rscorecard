# Initialize chained request.

This function initializes the data request. It should always be the
first in the series of piped functions.

## Usage

``` r
sc_init(dfvars = FALSE)
```

## Arguments

- dfvars:

  Set to `TRUE` if you would rather use the developer-friendly variable
  names used in actual API call.

## Examples

``` r
if (FALSE) { # \dontrun{
sc_init()
sc_init(dfvars = TRUE)
} # }
```
