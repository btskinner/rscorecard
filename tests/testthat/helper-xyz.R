
check_api <- function() {
    skip_on_cran()
    skip_if(identical(Sys.getenv('DATAGOV_API_KEY'), ''),
            'No API available')
}
