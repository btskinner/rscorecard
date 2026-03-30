# Select scorecard data variables.

This function is used to select the variables returned in the final
dataset.

## Usage

``` r
sc_select(sccall, ...)

sc_select_(sccall, vars)
```

## Arguments

- sccall:

  Current list of parameters carried forward from prior functions in the
  chain (ignore)

- ...:

  Desired variable names separated by commas (not case sensitive)

- vars:

  Character string of variable name or vector of character string
  variable names

## Functions

- `sc_select_()`: Standard evaluation version of `sc_select` (`vars`
  must be string or vector of strings when using this version)

## Examples

``` r
if (FALSE) { # \dontrun{
sc_select(UNITID)
sc_select(UNITID, INSTNM)
sc_select(unitid, instnm)
} # }
if (FALSE) { # \dontrun{
sc_select_("UNITID")
sc_select_(c("UNITID", "INSTNM"))
sc_select_(c("unitid", "instnm"))

## stored in object
vars_to_pull <- c("unitid","instnm")
sc_select(vars_to_pull)
} # }
```
