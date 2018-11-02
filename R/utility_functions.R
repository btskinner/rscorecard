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
        'repayment' %+|%
        'student' %+% '\\.)'
    gsub(re, '\\1' %+% year %+% '.' %+% '\\2', string)
}

## dev names to var names
dev_to_var <- function(x, debug = FALSE) {
    re <- '^(latest|[0-9]{0,4})\\.?(' %+%
        'academics' %+|%
        'admissions' %+|%
        'aid' %+|%
        'completion' %+|%
        'cost' %+|%
        'earnings' %+|%
        'repayment' %+|%
        'root' %+|%
        'school' %+|%
        'student' %+% ')\\.'
    x <- gsub(re, '', x)
    if (debug) x else sc_hash[[x]]
}
