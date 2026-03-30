# Search data dictionary.

This function is used to search the College Scorecard data dictionary.

## Usage

``` r
sc_dict(
  search_string,
  search_col = c("all", "description", "varname", "dev_friendly_name", "dev_category",
    "label", "source"),
  ignore_case = TRUE,
  limit = 10,
  confirm = FALSE,
  print_dev = FALSE,
  print_notes = FALSE,
  return_df = FALSE,
  print_off = FALSE,
  can_filter = FALSE,
  filter_vars = FALSE
)
```

## Arguments

- search_string:

  Character string for search. Can use regular expression for search.
  Must escape special characters, `. \ | ( ) [ { ^ $ * + ?`, with a
  doublebackslash `\\`.

- search_col:

  Column to search. The default is to search all columns. Other options
  include: "varname", "dev_friendly_name", "dev_category", "label".

- ignore_case:

  Search is case insensitive by default. Change to `FALSE` to restrict
  search to exact case matches.

- limit:

  Only the first 10 dictionary items are returned by default. Increase
  to return more values. Set to `Inf` to return all items matched in
  search'

- confirm:

  Use to confirm status of variable name in dictionary. Returns `TRUE`
  or `FALSE`.

- print_dev:

  Set to `TRUE` if you want to see the developer friendly name and
  category used in the API call.

- print_notes:

  Set to `TRUE` if you want to see the notes included in the data
  dictionary (if any).

- return_df:

  Return a tibble of the subset data dictionary.

- print_off:

  Do not print to console; useful if you only want to return a tibble of
  dictionary values.

- can_filter:

  Use to confirm that a variable can be used as a filtering variable.
  Returns `TRUE` or `FALSE`

- filter_vars:

  Use to print variables that can be used to filter calls. Use with
  argument `return_df = TRUE` to return a tibble of these variables in
  addition to console output.

## Examples

``` r
## simple search for 'state' in any part of the dictionary
sc_dict('state')
#> 
#> ---------------------------------------------------------------------
#> varname: stabbr                                         source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> State postcode
#> 
#> VALUES: NA
#> 
#> CAN FILTER? Yes
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: st_fips                                        source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> FIPS code for state
#> 
#> VALUES: 
#> 
#> 1 = Alabama
#> 2 = Alaska
#> 4 = Arizona
#> 5 = Arkansas
#> 6 = California
#> 8 = Colorado
#> 9 = Connecticut
#> 10 = Delaware
#> 11 = District of Columbia
#> 12 = Florida
#> 13 = Georgia
#> 15 = Hawaii
#> 16 = Idaho
#> 17 = Illinois
#> 18 = Indiana
#> 19 = Iowa
#> 20 = Kansas
#> 21 = Kentucky
#> 22 = Louisiana
#> 23 = Maine
#> 24 = Maryland
#> 25 = Massachusetts
#> 26 = Michigan
#> 27 = Minnesota
#> 28 = Mississippi
#> 29 = Missouri
#> 30 = Montana
#> 31 = Nebraska
#> 32 = Nevada
#> 33 = New Hampshire
#> 34 = New Jersey
#> 35 = New Mexico
#> 36 = New York
#> 37 = North Carolina
#> 38 = North Dakota
#> 39 = Ohio
#> 40 = Oklahoma
#> 41 = Oregon
#> 42 = Pennsylvania
#> 44 = Rhode Island
#> 45 = South Carolina
#> 46 = South Dakota
#> 47 = Tennessee
#> 48 = Texas
#> 49 = Utah
#> 50 = Vermont
#> 51 = Virginia
#> 53 = Washington
#> 54 = West Virginia
#> 55 = Wisconsin
#> 56 = Wyoming
#> 60 = American Samoa
#> 64 = Federated States of Micronesia
#> 66 = Guam
#> 69 = Northern Mariana Islands
#> 70 = Palau
#> 72 = Puerto Rico
#> 78 = Virgin Islands
#> 
#> CAN FILTER? Yes
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: tuitionfee_in                                  source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> In-state tuition and fees
#> 
#> VALUES: NA
#> 
#> CAN FILTER? Yes
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: tuitionfee_out                                 source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> Out-of-state tuition and fees
#> 
#> VALUES: NA
#> 
#> CAN FILTER? Yes
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: earn_in_state_1yr                           source: Treasury
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> Number of graduates working and not enrolled 1 year after completing
#>  who were employed within the same state as the institution
#> 
#> VALUES: NA
#> 
#> CAN FILTER? No
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: earn_in_state_4yr                           source: Treasury
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> Number of graduates working and not enrolled 4 years after completing
#>  who were employed within the same state as the institution
#> 
#> VALUES: NA
#> 
#> CAN FILTER? No
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: earn_in_state_5yr                           source: Treasury
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> Number of graduates working and not enrolled 5 years after completing
#>  who were employed within the same state as the institution
#> 
#> VALUES: NA
#> 
#> CAN FILTER? No
#> 
#> ---------------------------------------------------------------------
#> Printed information for 7 of out 7 variables.
#> 

## variable names starting with 'st'
sc_dict('^st', search_col = 'varname')
#> 
#> ---------------------------------------------------------------------
#> varname: stabbr                                         source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> State postcode
#> 
#> VALUES: NA
#> 
#> CAN FILTER? Yes
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: st_fips                                        source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> FIPS code for state
#> 
#> VALUES: 
#> 
#> 1 = Alabama
#> 2 = Alaska
#> 4 = Arizona
#> 5 = Arkansas
#> 6 = California
#> 8 = Colorado
#> 9 = Connecticut
#> 10 = Delaware
#> 11 = District of Columbia
#> 12 = Florida
#> 13 = Georgia
#> 15 = Hawaii
#> 16 = Idaho
#> 17 = Illinois
#> 18 = Indiana
#> 19 = Iowa
#> 20 = Kansas
#> 21 = Kentucky
#> 22 = Louisiana
#> 23 = Maine
#> 24 = Maryland
#> 25 = Massachusetts
#> 26 = Michigan
#> 27 = Minnesota
#> 28 = Mississippi
#> 29 = Missouri
#> 30 = Montana
#> 31 = Nebraska
#> 32 = Nevada
#> 33 = New Hampshire
#> 34 = New Jersey
#> 35 = New Mexico
#> 36 = New York
#> 37 = North Carolina
#> 38 = North Dakota
#> 39 = Ohio
#> 40 = Oklahoma
#> 41 = Oregon
#> 42 = Pennsylvania
#> 44 = Rhode Island
#> 45 = South Carolina
#> 46 = South Dakota
#> 47 = Tennessee
#> 48 = Texas
#> 49 = Utah
#> 50 = Vermont
#> 51 = Virginia
#> 53 = Washington
#> 54 = West Virginia
#> 55 = Wisconsin
#> 56 = Wyoming
#> 60 = American Samoa
#> 64 = Federated States of Micronesia
#> 66 = Guam
#> 69 = Northern Mariana Islands
#> 70 = Palau
#> 72 = Puerto Rico
#> 78 = Virgin Islands
#> 
#> CAN FILTER? Yes
#> 
#> 
#> ---------------------------------------------------------------------
#> varname: stufacr                                        source: IPEDS
#> ---------------------------------------------------------------------
#> DESCRIPTION:
#> 
#> Undergraduate student to instructional faculty ratio
#> 
#> VALUES: NA
#> 
#> CAN FILTER? No
#> 
#> ---------------------------------------------------------------------
#> Printed information for 3 of out 3 variables.
#> 

## return full dictionary (only recommended if not printing and
## storing in object)
df <- sc_dict('.', limit = Inf, print_off = TRUE, return_df = TRUE)

## print list of variables that can be used to filter
df <- sc_dict('.', filter_vars = TRUE, return_df = TRUE)
#> 
#> ---------------------------------------------------------------------
#> The following variables can be used in sc_filter():
#> ---------------------------------------------------------------------
#> 
#>  - aanapii
#>  - actcmmid
#>  - adm_rate
#>  - admcon7
#>  - annhi
#>  - c150_4_pooled
#>  - ccbasic
#>  - cipcode
#>  - city
#>  - cntover150_3yr
#>  - control
#>  - creddesc
#>  - credlev
#>  - curroper
#>  - debt_all_stgp_any_mdn
#>  - debt_all_stgp_any_mdn10yrpay
#>  - debt_all_stgp_eval_mdn
#>  - dolprovider
#>  - earn_mdn_4yr
#>  - earn_mdn_5yr
#>  - fedschcd
#>  - gt_25k_p6
#>  - gt_threshold_p6_supp
#>  - hbcu
#>  - hcm2
#>  - highdeg
#>  - hsi
#>  - instnm
#>  - insturl
#>  - ipedscount1
#>  - ipedscount2
#>  - locale
#>  - locale2
#>  - main
#>  - md_earn_wne_p10
#>  - mdcomp_all
#>  - mdcomp_pd
#>  - mdcost_all
#>  - mdcost_pd
#>  - mdearn_all
#>  - mdearn_pd
#>  - menonly
#>  - mn_earn_wne_inc1_p6
#>  - nanti
#>  - npt41_priv
#>  - npt41_pub
#>  - npt42_priv
#>  - npt42_pub
#>  - npt43_priv
#>  - npt43_pub
#>  - npt44_priv
#>  - npt44_pub
#>  - npt45_priv
#>  - npt45_pub
#>  - npt4_priv
#>  - npt4_pub
#>  - numbranch
#>  - opeid
#>  - opeid6
#>  - pbi
#>  - preddeg
#>  - region
#>  - relaffil
#>  - sat_avg
#>  - satmt25
#>  - satmt75
#>  - satmtmid
#>  - satvr25
#>  - satvr75
#>  - satvrmid
#>  - satwr25
#>  - satwr75
#>  - satwrmid
#>  - st_fips
#>  - stabbr
#>  - tribal
#>  - tuitionfee_in
#>  - tuitionfee_out
#>  - ugds
#>  - unitid
#>  - womenonly
#>  - zip
#> 
```
