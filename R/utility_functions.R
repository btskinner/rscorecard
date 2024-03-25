
#' @importFrom httr GET
#' @importFrom httr content
#' @importFrom jsonlite fromJSON
#' @importFrom lazyeval interp

## paste pipes
`%+%`  <- function(a,b) paste(a, b, sep = "")
`%+|%` <- function(a,b) paste(a, b, sep = "|")
`%+&%` <- function(a,b) paste(a, b, sep = "&")

## add year
add_year <- function(string, year) {
  re <- "(^|=|,)(" %+%
    "academics" %+|%
    "admissions" %+|%
    "aid" %+|%
    "completion" %+|%
    "cost" %+|%
    "earnings" %+|%
    "programs" %+|%
    "repayment" %+|%
    "student" %+% "\\.)"
  gsub(re, "\\1" %+% year %+% "." %+% "\\2", string)
}

## dev names to var names
dev_to_var <- function(x, debug = FALSE) {
  if (grepl("^.+\\$.+$", x)) {
    re <- "^(.+\\$)(.+)$"
    x <- gsub(re, "\\2", x)
  } else {
    re <- "^(latest|[0-9]{0,4})\\.?(" %+%
      "academics" %+|%
      "admissions" %+|%
      "aid" %+|%
      "completion" %+|%
      "cost" %+|%
      "earnings" %+|%
      "programs" %+|%
      "repayment" %+|%
      "root" %+|%
      "school" %+|%
      "student" %+% ")\\.(.+)$"
    x <- gsub(re, "\\3", x)
  }
  if (debug) x else sc_hash[[x]]
}

## repeated function to convert json --> tibble
convert_json_to_tibble <- function(json_str) {
  ## initial messy data frame
  df <- jsonlite::fromJSON(json_str, flatten = TRUE) |>
    purrr::pluck("results")
  ## get rows
  df_nrow <- nrow(df)
  ## convert to nested tibble
  df <- purrr::map_if(df, is.data.frame, list) |> tidyr::as_tibble()
  ## get nested column names (those of class <list>)
  unnest_cols <- dplyr::select_if(df, is.list) |> names()
  ## unnest in steps
  df <- tidyr::unnest_wider(df, col = tidyselect::all_of(unnest_cols),
                            names_sep = ".")
  df <- dplyr::mutate(df, dplyr::across(tidyselect::where(is.list),
                                          ~ purrr::map(.x, as.character)))
  df <- tidyr::unnest(df, cols = tidyselect::everything())
  ## return
  list("df" = df, "df_nrow" = df_nrow)
}

## confirm that first argument is sccall list
confirm_chain <- function(x) {
  ## error message
  m <- "Chain not properly initialized. Be sure to start with sc_init()."
  ## must force() the chain so it works in order, but need to try() first
  ## and capture result
  res <- try(force(x), silent = TRUE)
  ## if try-error and any of following:
  ## 1. "sccall" is missing
  ## 2. error in filter (meaning no arguments at all in sc_filter())
  ## 3. object isn"t found (meaning sccall isn"t first)
  if (identical(class(res), "try-error")
      & (grepl("argument \"sccall\" is missing, with no default\n", res[1])
        | grepl("Error in filter .+ : subscript out of bounds\n", res[1])
        | grepl("object '.+' not found", res[1]))) {
    stop(m, call. = FALSE)
    ## if no try-error and:
    ## 1. is list
    ## 2. is longer than 1 element
    ## 3. contains "sc_init_list" == TRUE
  } else if (is.list(x) && length(x) > 1 && x[["sc_init_list"]]) {
    res
    ## if no try-error, but sc_year() is called, this will catch that
  } else if (is.numeric(x) | x == "latest") {
    stop(m, call. = FALSE)
  }
}


