## make_dict_hash.R

libs <- c("dplyr","readxl","zoo")
sapply(libs, require, character.only = TRUE)

## get latest XLSX data dictionary file
file <- "CollegeScorecardDataDictionary.xlsx"
link <- paste0("https://collegescorecard.ed.gov/assets/", file)
download.file(link, file)

## sheet names
sheets <- c("Institution_Data_Dictionary",
            "FieldOfStudy_Data_Dictionary")

## read in each sheet, munge, and bind
df <- purrr::map(sheets,
                 ~ read_excel(file, sheet = .x) |>
                     ## lower names
                     rename_all(tolower) |>
                     ## subset/rename
                     select(description = `name of data element`,
                            dev_category = `dev-category`,
                            dev_friendly_name = `developer-friendly name`,
                            varname = `variable name`,
                            value,
                            label,
                            source,
                            notes,
                            can_filter = index) |>
                     ## lower name values for varname column
                     mutate(varname = tolower(varname)) |>
                     ## remove extra \r\n from description column
                     mutate(description = gsub("^(.+)\r\n 0.*$", "\\1", description)) |>
                     ## remove trailing characters from dev_friendly_name
                     mutate(dev_friendly_name = gsub("^(.+):$", "\\1",
                                                     dev_friendly_name)) |>
                     ## convert can_filter column to 1 if there's text there
                     mutate(can_filter = ifelse(!is.na(can_filter), 1, can_filter),
                            ## fix unitid can_filter to 1 since it works for filtering
                            can_filter = ifelse(varname == "unitid", 1, can_filter),
                            ## convert to integer
                            can_filter = as.integer(can_filter)) |>
                     ## roll values forward to fill NA
                     mutate(description = na.locf(description),
                            dev_category = na.locf(dev_category),
                            dev_friendly_name = na.locf(dev_friendly_name),
                            varname = na.locf(varname),
                            source = na.locf(source)) |>
                     ## roll values forward in can_filter, grouped by variable name
                     group_by(varname) |>
                     mutate(can_filter = na.locf(can_filter, na.rm = FALSE),
                            notes = na.locf(notes, na.rm = FALSE)) |>
                     ungroup() |>
                     mutate(can_filter = ifelse(is.na(can_filter), 0, can_filter),
                            notes_ibid = ifelse(grepl("ibid", notes), 1, 0),
                            notes_disc = ifelse(grepl("^Discontinued;", notes), 1, 0),
                            notes = ifelse(grepl("ibid", notes), NA, notes),
                            notes = ifelse(is.na(notes) & notes_ibid == 1,
                                           na.locf(notes),
                                           notes),
                            notes = ifelse(notes_disc == 1,
                                           paste("DISCONTINUED:", notes),
                                           notes)) |>
                     select(-notes_ibid, -notes_disc)
                 ) |>
    ## bind together
    bind_rows()

## make dictionary data frame
dict <- df |> data.frame()

## create hash environment for quick conversion between varnames
## and developer-friendly names

sc_hash <- new.env(parent = emptyenv())

## (1) varname <- dev_friendly
## (2) varname_c <- root

tmp <- df |> distinct(varname, .keep_all = TRUE)

for (i in 1:nrow(tmp)) {
    ## key/value pair (1)
    key <- tmp[["varname"]][i]
    val <- tmp[["dev_friendly_name"]][i]
    ## key/value pair (2)
    key_c <- paste0(key, "_c")
    val_c <- tmp[["dev_category"]][i]
    ## assign
    sc_hash[[key]] <- val
    sc_hash[[key_c]] <- val_c
}

## (3) dev_friendly <- varname
## (4) dev_friendly_c <- root

tmp <- df |> distinct(dev_friendly_name, .keep_all = TRUE)

for (i in 1:nrow(tmp)) {
    ## key/value pair (3)
    key <- tmp[["dev_friendly_name"]][i]
    val <- tmp[["varname"]][i]
    ## key/value pair (4)
    key_c <- paste0(key, "_c")
    val_c <- tmp[["dev_category"]][i]
    ## assign
    sc_hash[[key]] <- val
    sc_hash[[key_c]] <- val_c
}

## small adjustment for variables in both data locations; this will
## add special endings:

## _i := institution data source
## _p := field of study data source

## users can specifiy the data source for these variables; by default,
## the information will continue to come from the institution data
both_sources <- c("unitid", "opeid6", "control", "main", "instnm")

tmp <- df |>
    filter(varname %in% both_sources) |>
    distinct(dev_category, varname, .keep_all = TRUE)

for (i in 1:nrow(tmp)) {
    ## category == programs ? _f : _i
    end <- ifelse(tmp[["dev_category"]][i] == "programs", "_f", "_i")
    ## key/value pair (with endings on key)
    key <- paste0(tmp[["varname"]][i], end)
    val <- tmp[["dev_friendly_name"]][i]
    ## key/value pair for category (with endings on key)
    key_c <- paste0(key, "_c")
    val_c <- tmp[["dev_category"]][i]
    ## assign
    sc_hash[[key]] <- val
    sc_hash[[key_c]] <- val_c
}

## save
usethis::proj_set("..")
usethis::use_data(dict, sc_hash, overwrite = TRUE, internal = TRUE)
