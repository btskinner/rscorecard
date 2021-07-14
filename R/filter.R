#' Filter scorecard data by variable values.
#'
#' This function is used to filter the downloaded scorecard data. It
#' converts idiomatic R into the format required by the API call.
#'
#' @param sccall Current list of parameters carried forward from prior
#'     functions in the chain (ignore)
#' @param ... Expressions to evaluate
#'
#' @examples
#' \dontrun{
#' sc_filter(region == 1) # New England institutions
#' sc_filter(stabbr == c('TN','KY')) # institutions in Tennessee and Kentucky
#' sc_filter(control != 3) # exclude private, for-profit institutions
#' sc_filter(control == c(1,2)) # same as above
#' sc_filter(control == 1:2) # same as above
#' sc_filter(stabbr == 'TN', control == 1, locale == 41:43) # TN rural publics
#' }

#' @export
sc_filter <- function(sccall, ...) {

    ## confirm ...
    if (missing(...)) {
        confirm_chain(sccall)
        stop('Incomplete sc_filter()! You must include a filter expression if using sc_filter().',
             call. = FALSE)
    }

    ## get expressions
    filter <- unlist(lapply(lazyeval::lazy_dots(...),
                            function(x) deparse(bquote(.(x[['expr']])))),
                     use.names = FALSE)

    ## pass to _ function
    sc_filter_(sccall, filter_string = filter)

}

#' @describeIn sc_filter Standard evaluation version of
#'     \code{\link{sc_filter}} (\code{filter_string} must be a string
#'     or vector of strings when using this version)
#'
#' @param filter_string Filter as character string or vector of
#'     filters as character strings
#'
#' @examples
#' \dontrun{
#' sc_filter_('region == 1')
#' sc_filter_('control != 3')
#'
#' ## With internal strings, you must either use both double and single quotes
#' ## or escape internal quotes
#' sc_filter_("stabbr == c('TN','KY')")
#' sc_filter_('stabbr == c(\'TN\',\'KY\')')
#'
#' ## stored in object
#' filters <- c('control == 1', 'locale == 41:43')
#' sc_filter_(filters)
#' }

#' @export
sc_filter_ <- function(sccall, filter_string) {
    suppressWarnings({
        ## check first argument
        confirm_chain(sccall)

        ## confirm filter_string
        if (missing(filter_string)) {
            stop('Incomplete sc_filter()! You must include a filter expression if using sc_filter().',
                 call. = FALSE)
        }

        ## get expressions
        filter <- lapply(filter_string, function(x) as.list(parse(text = x)[[1]]))

        ## error handling
        for (i in 1:length(filter)) {
            ## illegal operators
            if (!identical(filter[[i]][[1]], as.symbol('=='))
                && !identical(filter[[i]][[1]], as.symbol('!='))
                && !identical(filter[[i]][[1]], as.symbol('%in%'))) {
                stop('Must use either \"==\", \"!=\", or \"%in%\" in sc_filter().',
                     call. = FALSE)
            }
            ## variable not found in the dictionary
            if (!sc_dict(tolower(as.character(filter[[i]][[2]])), confirm = TRUE)) {
                stop('Variable \"' %+% filter[[i]][[2]]
                     %+% '\" not found in dictionary. '
                     %+% 'Please check your spelling or search dictionary: '
                     %+% '?sc_dict()', call. = FALSE)
            }
            ## variable cannot allowed as filtering variable
            if (!sc_dict(tolower(as.character(filter[[i]][[2]])), can_filter = TRUE)) {
                stop('The variable \"' %+% filter[[i]][[2]]
                     %+% '\" cannot be used as filter. '
                     %+% 'Use sc_dict(filter_vars = TRUE) to see available filters.',
                 call. = FALSE)
            }
        }

        ## convert to developer-friendly names
        if (!sccall[['dfvars']]) {
            for (i in 1:length(filter)) {
                filter[[i]][[2]] <- sc_hash[[tolower(as.character(filter[[i]][[2]]))]]
            }
        }

        ## grab categories
        cats <- vapply(filter, function(x) { sc_hash[[as.character(x[[2]]) %+% '_c']] },
                       character(1), USE.NAMES = FALSE)

        ## convert idiomatic R to scorecard API style
        filter <- vapply(filter, api_convert, character(1))

        ## paste, clean, and return
        filter <- paste(cats %+% '.' %+% filter, collapse = '&')
        filter <- gsub('root.', '', filter, fixed = TRUE)
        sccall[['filter']] <- filter
        sccall
    })

}


