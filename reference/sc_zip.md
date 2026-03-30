# Subset results to those within specified area around zip code.

Subset results to those within specified area around zip code.

## Usage

``` r
sc_zip(sccall, zip, distance = 25, km = FALSE)
```

## Arguments

- sccall:

  Current list of parameters carried forward from prior functions in the
  chain (ignore)

- zip:

  A 5-digit zipcode

- distance:

  An integer distance in miles or kilometers

- km:

  A boolean value set to `TRUE` if distance should be in kilometers
  (default is `FALSE` for miles)

## Note

Zip codes with leading zeros (Northeast) can be called either using a
string (`"02111"`) or as a numeric (`02111`). R will drop the leading
zero from the second version, but `sc_zip()` will add it back before the
call. The shortened version without the leading zero may also be used
(2111 and "2111" both become "02111"), but is not recommended for
clarity.

## Examples

``` r
if (FALSE) { # \dontrun{
sc_zip(37203)
sc_zip(37203, 50)
sc_zip(37203, 50, km = TRUE)
sc_zip("02111")              # 1. Using string
sc_zip(02111)                # 2. Dropped leading zero will be added
sc_zip(2111)                 # 3. Will become "02111" (not recommended)
} # }
```
