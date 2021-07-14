#' Get scorecard data.
#'
#' This function gets the College Scorecard data by compiling and
#' converting all the previous piped output into a single URL string
#' that is used to get the data.
#'
#' @param sccall Current list of parameters carried forward from prior
#'     functions in the chain (ignore)
#' @param api_key Personal API key requested from
#'     \url{https://api.data.gov/signup} stored in a string. If you
#'     first set your key using \code{sc_key}, then you may omit this
#'     parameter. A key set here will take precedence over any set in
#'     the environment (DATAGOV_API_KEY).
#' @param debug Set to true to print and return API call (URL string)
#'     rather than make actual request. Should only be used when
#'     debugging calls.
#' @param print_key_debug Only used when \code{debug == TRUE}. Default
#'     masks the \code{api_key} value. Set to \code{TRUE} to print the
#'     full API call string with the \code{api_key} unmasked.
#' @param return_json Return data in JSON format rather than as a
#'     tibble.
#'
#' @examples
#' \dontrun{
#' sc_get('<API KEY IN STRING>')
#' key <- '<API KEY IN STRING>'
#' sc_get(key)
#' }
#'
#' @section Obtain a key:
#' To obtain an API key, visit \url{https://api.data.gov/signup}

#' @export
sc_get <- function(sccall, api_key, debug = FALSE, print_key_debug = FALSE,
                   return_json = FALSE) {
    suppressWarnings({
        ## check first argument
        confirm_chain(sccall)

        ## check if missing sc_select()
        if (is.null(sccall[['select']])) {
            stop('No variables selected. Use sc_select() to choose variables.',
                 call. = FALSE)
        }

        ## add year
        sccall[['select']] <- add_year(sccall[['select']], sccall[['year']])
        sccall[['filter']] <- add_year(sccall[['filter']], sccall[['year']])

        ## create url for call
        url <- 'https://api.data.gov/ed/collegescorecard/v1/schools.json?' %+%
            sccall[['filter']] %+% sccall[['select']] %+% sccall[['zip']]

        ## check for key
        if (missing(api_key)) {
            api_key <- Sys.getenv('DATAGOV_API_KEY')
            if (identical(api_key, '')) {
                stop('Missing API key; ?sc_key for details', call. = FALSE)
            }
        }

        ## init connection call
        con <- url %+% '&_page=0&_per_page=100&api_key=' %+% api_key

        ## if debug == TRUE, don't call but return the call
        if (debug) {

            ## hide API key by default
            if (!print_key_debug) {
                con <- gsub('api_key=.+$', 'api_key=<...HIDDEN...>', con)
            }

            ## print to stdout
            message('\n', paste(rep('', 70), collapse = '-'))
            message('API call string')
            message(paste(rep('', 70), collapse = '-'), '\n')
            message(con)
            message('\n', paste(rep('', 70), collapse = '-'))

            ## return
            return(con)
        }

        ## make first GET
        resp <- httr::GET(con)

        ## check for error
        if (httr::http_error(con)) {
            ## get error
            content <- httr::content(resp, as = 'text', encoding = 'UTF-8')
            text <- jsonlite::fromJSON(content)$errors
            if (is.data.frame(text) && text[['error']][1] == 'field_not_found') {
                miss_year <- c()
                miss_name <- c()
                for (i in 1:nrow(text)) {
                    ## get row
                    var <- text[['input']][i]
                    ## split on dot
                    var_spl <- strsplit(var, '.', fixed = TRUE)
                    ## get year of variable request
                    year <- var_spl[[1]][1]
                    ## get dev.friendly variable name
                    name <- paste(var_spl[[1]][3:length(var_spl[[1]])],collapse='.')
                    ## convert to acutal name if not using dev.friendly names
                    if (!sccall[['dfvars']]) {
                        name <- sc_hash[[name]]
                    }
                    ## store
                    miss_year[i] <- year
                    miss_name[i] <- name
                }
                ## message with missing variables
                out <- c()
                for (i in 1:length(miss_name)) {
                    out[i] <- ' - (' %+% miss_year[i] %+% ') ' %+% miss_name[i] %+% '\n'
                }
                stop('Unsuccessful request:\n',
                     'The following variables were not found in the dataset:\n\n',
                     out, '\n',
                     'Check that the variables are available in the selected (year).',
                     call. = FALSE)
            } else {
                stop('Unsuccessful request:\n',
                     '[ Message from httr ] ',
                     httr::http_status(resp)[['message']],
                     call. = FALSE)
            }
        }

        ## ---------------
        ## initial pull
        ## ---------------

        ## get content
        init_content <- httr::content(resp, as = 'text', encoding = 'UTF-8')
        ## get metadata
        init_meta <- jsonlite::fromJSON(init_content)[['metadata']]
        ## get data and rows
        init_list <- convert_json_to_tibble(init_content)

        ## return if no options
        if (init_meta[['total']] == 0) {
            stop('No results! Broaden your search or try different variables.',
                 call. = FALSE)
        }

        ## if there are more rows than return, then need to pull in chunks
        if (init_meta[['total']] > init_list[['df_nrow']]) {

            ## get number of pages needed
            pages <- floor(init_meta[['total']] / 100)

            message('Large request will require: ' %+% pages %+% ' additional pulls.')

            ## download data in chunks and bind
            page_list <- vector('list', pages)
            for (i in 1:pages) {
                message('Request additional chunk ' %+% i)
                con <- url %+% '&_page=' %+% i %+% '&_per_page=100&api_key=' %+% api_key
                content <- httr::content(httr::GET(con), as = 'text', encoding = 'UTF-8')
                if (return_json) {
                    page_list[[i]] <- content
                } else {
                    page_list[[i]] <- convert_json_to_tibble(content)[['df']]
                }
            }

            ## return_json ? return(<json_st>) : bind tbl_dfs into one
            if (return_json) {
                return(c(init_content, unlist(page_list, use.names = FALSE)))
            } else {
                df <- dplyr::bind_rows(init_list[['df']], page_list)
            }

        } else {

            ## return_json ? return(<json_st>) : return single tbl_df pull
            if (return_json) {
                return(init_content)
            } else {
                df <- init_list[['df']]
            }
        }

        ## drop flotsam variables that weren't requested in call
        for (i in names(df)) {
            if (is.null(dev_to_var(i))) { df[,i] <- NULL }
        }

        ## convert names back to non-developer-friendly names and return
        if (!sccall[['dfvars']]) {
            names(df) <- vapply(names(df), dev_to_var, character(1),
                                USE.NAMES = FALSE)
        }

        ## add year column
        df[['year']] <- sccall[['year']]

        ## put in order of variable request
        df <- dplyr::select(df, dplyr::one_of(sccall[['select_order']], 'year'))

        ## message and return
        message('Request complete!')
        df
    })

}



