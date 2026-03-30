# Get scorecard data.

This function gets the College Scorecard data by compiling and
converting all the previous piped output into a single URL string that
is used to get the data.

## Usage

``` r
sc_get(
  sccall,
  api_key,
  debug = FALSE,
  print_key_debug = FALSE,
  return_json = FALSE
)
```

## Arguments

- sccall:

  Current list of parameters carried forward from prior functions in the
  chain (ignore)

- api_key:

  Personal API key requested from <https://api.data.gov/signup> stored
  in a string. If you first set your key using `sc_key`, then you may
  omit this parameter. A key set here will take precedence over any set
  in the environment (DATAGOV_API_KEY).

- debug:

  Set to true to print and return API call (URL string) rather than make
  actual request. Should only be used when debugging calls.

- print_key_debug:

  Only used when `debug == TRUE`. Default masks the `api_key` value. Set
  to `TRUE` to print the full API call string with the `api_key`
  unmasked.

- return_json:

  Return data in JSON format rather than as a tibble.

## Obtain a key

To obtain an API key, visit <https://api.data.gov/signup>

## Examples

``` r
if (FALSE) { # \dontrun{
sc_get("<API KEY IN STRING>")
key <- "<API KEY IN STRING>"
sc_get(key)
} # }
```
