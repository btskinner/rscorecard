#' Search data dictionary.
#'
#' This function is used to search the College Scorecard
#' data dictionary.
#'
#' @param search_string Character string for search. Can use regular
#'     expression for search. Must escape special characters,
#'     \code{. \ | ( ) [ \{ ^ $ * + ?}, with a doublebackslash
#'     \code{\\\\}.
#' @param search_col Column to search. The default is to search all
#'     columns.  Other options include: "varname",
#'     "dev_friendly_name", "dev_category", "label".
#' @param ignore_case Search is case insensitive by default. Change to
#'     \code{FALSE} to restrict search to exact case matches.
#' @param limit Only the first 10 dictionary items are returned by
#'     default. Increase to return more values. Set to \code{Inf} to
#'     return all items matched in search'
#' @param confirm Use to confirm status of variable name in
#'     dictionary. Returns \code{TRUE} or \code{FALSE}.
#' @param print_dev Set to \code{TRUE} if you want to see the
#'     developer friendly name and category used in the API call.
#' @param print_notes Set to \code{TRUE} if you want to see the notes
#'     included in the data dictionary (if any).
#' @param return_df Return a tibble of the subset data dictionary.
#' @param print_off Do not print to console; useful if you only want
#'     to return a tibble of dictionary values.
#' @param can_filter Use to confirm that a variable can be used as a
#'     filtering variable. Returns \code{TRUE} or \code{FALSE}
#' @param filter_vars Use to print variables that can be used to
#'     filter calls. Use with argument \code{return_df = TRUE} to
#'     return a tibble of these variables in addition to console
#'     output.
#'
#' @examples
#' ## simple search for 'state' in any part of the dictionary
#' sc_dict('state')
#'
#' ## variable names starting with 'st'
#' sc_dict('^st', search_col = 'varname')
#'
#' ## return full dictionary (only recommended if not printing and
#' ## storing in object)
#' df <- sc_dict('.', limit = Inf, print_off = TRUE, return_df = TRUE)
#'
#' ## print list of variables that can be used to filter
#' df <- sc_dict('.', filter_vars = TRUE, return_df = TRUE)

#' @export
sc_dict <- function(search_string,
                    search_col = c('all',
                                   'description',
                                   'varname',
                                   'dev_friendly_name',
                                   'dev_category',
                                   'label',
                                   'source'),
                    ignore_case = TRUE, limit = 10, confirm = FALSE,
                    print_dev = FALSE, print_notes = FALSE,
                    return_df = FALSE, print_off = FALSE,
                    can_filter = FALSE, filter_vars = FALSE) {

    ## only for confirm
    if (confirm) {
        return(!is.null(sc_hash[[search_string]]))
    }

    ## only for can_filter
    if (can_filter) {
        ## NB: using any() to be TRUE if any TRUE
        return(any(dict[["can_filter"]][dict[["varname"]] == search_string] == 1))
    }

    ## print filter variables
    if (filter_vars) {
        out <- dict[dict[["can_filter"]] == 1,]
        uniqv <- sort(unique(out[["varname"]]))
        ## console table
        cat('\n' %+% paste(rep('', 70), collapse = '-') %+% '\n')
        cat('The following variables can be used in sc_filter():')
        cat('\n' %+% paste(rep('', 70), collapse = '-') %+% '\n\n')
        for (i in 1:length(uniqv)) {
            cat(' - ' %+% uniqv[i] %+% '\n')
        }
        if (return_df) {
            cat('\n')
            var_order <- c('varname', 'value', 'label', 'description', 'source',
                           'dev_friendly_name', 'dev_category', 'notes', 'can_filter')
            out <- tidyr::as_tibble(out) %>%
                dplyr::select(dplyr::one_of(var_order))
            return(out)
        } else {
            return(cat('\n'))
        }
    }

    ## get values
    if (match.arg(search_col) == 'all') {
        rows <- rep(FALSE, nrow(dict))
        for (col in c('description',
                      'varname',
                      'dev_friendly_name',
                      'dev_category',
                      'label',
                      'source')) {
            tmp_rows <- grepl(search_string,
                              dict[[col]],
                              ignore.case = ignore_case)
            rows <- rows | tmp_rows     # promote to TRUE either TRUE
        }
    } else {
        rows <- grepl(search_string,
                      dict[[match.arg(search_col)]],
                      ignore.case = ignore_case)
    }

    if (all(rows == FALSE)) {
        return(cat('\nNo matches! Try again with new string or column.\n\n'))
    }

    ## pull data
    out <- dict[rows,]

    ## get unique varnames
    uniqv <- unique(out[['varname']])

    ## pretty print
    if (!print_off) {
        for (i in 1:min(length(uniqv), limit)) {

            ## subset
            d <- out[out[['varname']] == uniqv[i],]

            ## console table
            cat('\n' %+% paste(rep('', 70), collapse = '-') %+% '\n')
            cat('varname: ' %+% d[['varname']][1])
            ## cat(rep('', 51 - nchar(d[['varname']][1]) -
            ##             nchar(d[['dev_category']][1])))
            ## cat('category: ' %+% d[['dev_category']][1])
            cat(rep('', 53 - nchar(d[['varname']][1]) -
                        nchar(d[['source']][1])))
            cat('source: ' %+% d[['source']][1])
            cat('\n' %+% paste(rep('', 70), collapse = '-') %+% '\n')
            if (print_dev) {
                cat('\nDEVELOPER FRIENDLY NAME:\n\n')
                cat(d[['dev_friendly_name']][1] %+% '\n')
                cat('\nDEVELOPER CATEGORY:\n\n')
                cat(d[['dev_category']][1] %+% '\n\n')
            }
            cat('DESCRIPTION:\n\n')
            cat(strwrap(d[['description']][1], 70) %+% '\n')
            if (print_notes) {
                cat('\nNOTES:\n\n')
                cat(strwrap(d[['notes']][1], 70) %+% '\n')
            }
            cat('\n')
            cat('VALUES: ')
            if (is.na(d[['value']][1])) {
                cat('NA\n\n')
            } else {
                cat('\n\n')
                for (j in seq(nrow(d))) {

                    cat(d[['value']][j] %+% ' = ' %+% d[['label']][j] %+% '\n')

                }
                cat('\n')
            }
            cat('CAN FILTER? ')
            if (d[['can_filter']][[1]] == 1) {
                cat('Yes\n\n')
            } else {
                cat('No\n\n')
            }
        }

        cat(paste(rep('', 70), collapse = '-') %+% '\n')
        cat('Printed information for ' %+% min(length(uniqv), limit) %+% ' of out ')
        cat(length(uniqv) %+% ' variables.\n')
        if (limit < length(uniqv)) cat('Increase limit to see more variables.\n')
        cat('\n')
    }

    ## return_df ? return (out) : <>
    if (return_df) {
         var_order <- c('varname', 'value', 'label', 'description', 'source',
                        'dev_friendly_name', 'dev_category', 'notes', 'can_filter')
         out <- tidyr::as_tibble(out) %>%
             dplyr::select(dplyr::one_of(var_order))
         return(out)
    }


}
