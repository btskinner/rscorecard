#' @importFrom magrittr %>%
#' @export
magrittr::`%>%`

#' @importFrom httr GET
#' @importFrom httr content
#' @importFrom jsonlite fromJSON
#' @importFrom lazyeval interp

## paste pipes
`%+%`  <- function(a,b) paste(a, b, sep = '')
`%+|%` <- function(a,b) paste(a, b, sep = '|')
`%+&%` <- function(a,b) paste(a, b, sep = '&')

## add year
add_year <- function(string, year) {
    re <- '(^|=|,)(' %+%
        'academics' %+|%
        'admissions' %+|%
        'aid' %+|%
        'completion' %+|%
        'cost' %+|%
        'earnings' %+|%
        'programs' %+|%
        'repayment' %+|%
        'student' %+% '\\.)'
    gsub(re, '\\1' %+% year %+% '.' %+% '\\2', string)
}

## dev names to var names
dev_to_var <- function(x, debug = FALSE) {
    if (grepl('^.+\\$.+$', x)) {
        re <- '^(.+\\$)(.+)$'
        x <- gsub(re, '\\2', x)
    } else {
        re <- '^(latest|[0-9]{0,4})\\.?(' %+%
            'academics' %+|%
            'admissions' %+|%
            'aid' %+|%
            'completion' %+|%
            'cost' %+|%
            'earnings' %+|%
            'programs' %+|%
            'repayment' %+|%
            'root' %+|%
            'school' %+|%
            'student' %+% ')\\.(.+)$'
        x <- gsub(re, '\\3', x)
    }
    if (debug) x else sc_hash[[x]]
}

## repeated function to convert json --> tibble
convert_json_to_tibble <- function(json_str) {
    ## initial messy data frame
    df <- jsonlite::fromJSON(json_str, flatten = TRUE) %>%
        purrr::pluck('results')
    ## get rows
    df_nrow <- nrow(df)
    ## convert to nested tibble
    df <- purrr::map_if(df, is.data.frame, list) %>% tidyr::as_tibble()
    ## get nested column names (those of class <list>)
    unnest_cols <- dplyr::select_if(df, is.list) %>% names
    ## unnest
    df <- tidyr::unnest(df, cols = unnest_cols, names_sep = '.')
    ## return
    list('df' = df, 'df_nrow' = df_nrow)
}
