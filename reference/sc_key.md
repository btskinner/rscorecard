# Store Data.gov API key in system environment.

This function stores your data.gov API key in the system environment so
that you only have to load it once at the start of the session. If you
set your key using `sc_key`, then you may omit `api_key` parameter in
the `sc_get` function.

## Usage

``` r
sc_key(api_key)
```

## Arguments

- api_key:

  Personal API key requested from <https://api.data.gov/signup> stored
  in a string.

## Obtain a key

To obtain an API key, visit <https://api.data.gov/signup>.

## Examples

``` r
if (FALSE) { # \dontrun{
sc_key('<API KEY IN STRING>')
} # }
```
