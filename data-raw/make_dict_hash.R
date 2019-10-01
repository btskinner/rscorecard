## make_dict_hash.R

libs <- c('dplyr','readxl','zoo')
lapply(libs, require, character.only = TRUE)

## get latest XLSX data dictionary file
file <- 'CollegeScorecardDataDictionary.xlsx'
link <- paste0('https://collegescorecard.ed.gov/assets/', file)
download.file(link, file)

## create dictionary
df <- read_excel(file, sheet = 'data_dictionary') %>%
    ## lower names
    setNames(tolower(names(.))) %>%
    ## subset/rename
    select(description = `name of data element`,
           dev_category = `dev-category`,
           dev_friendly_name = `developer-friendly name`,
           varname = `variable name`,
           value,
           label) %>%
    ## lower name values for varname column
    mutate(varname = tolower(varname)) %>%
    ## remove extra \r\n from decription column
    mutate(description = gsub('^(.+)\r\n 0.*$', '\\1', description)) %>%
    ## roll values forward to fill NA
    mutate(description = na.locf(description),
           dev_category = na.locf(dev_category),
           dev_friendly_name = na.locf(dev_friendly_name),
           varname = na.locf(varname))

dict <- df %>% data.frame(.)

## create hash environment for quick conversion between varnames
## and developer-friendly names

sc_hash <- new.env(parent = emptyenv())

## (1) varname <- dev_friendly
## (2) varname_c <- root

tmp <- df %>% distinct(varname, .keep_all = TRUE)

for(i in 1:nrow(tmp)) {
    ## key/value pair (1)
    key <- tmp[['varname']][i]
    val <- tmp[['dev_friendly_name']][i]
    ## key/value pair (2)
    key_c <- paste0(key, '_c')
    val_c <- tmp[['dev_category']][i]
    ## assign
    sc_hash[[key]] <- val
    sc_hash[[key_c]] <- val_c
}

## (3) dev_friendly <- varname
## (4) dev_friendly_c <- root

tmp <- df %>% distinct(dev_friendly_name, .keep_all = TRUE)

for(i in 1:nrow(tmp)) {
    ## key/value pair (3)
    key <- tmp[['dev_friendly_name']][i]
    val <- tmp[['varname']][i]
    ## key/value pair (4)
    key_c <- paste0(key, '_c')
    val_c <- tmp[['dev_category']][i]
    ## assign
    sc_hash[[key]] <- val
    sc_hash[[key_c]] <- val_c
}

## save to sysdata.R
## devtools::use_data(dict, sc_hash, pkg = '..', overwrite = TRUE, internal = TRUE)
usethis::proj_set('..')
usethis::use_data(dict, sc_hash, overwrite = TRUE, internal = TRUE)




