context('base pipe (|>)')

## test that base R pipe works -------------------

test_that('Base R pipe works', {

    ## Removing for now since skip_if() doesn't seem to work with
    ## github actions

    ## skip if R version is less than 4.1.0
    ## skip_if(getRversion() < "4.1.0", "R version too low")

    ## out <- list("sc_init_list" = TRUE,
    ##             "dfvars" = FALSE,
    ##             "select" = NULL,
    ##             "select_order" = NULL,
    ##             "filter" = "id=1000&school.name=MU",
    ##             "zip" = NULL,
    ##             "year" = "latest")

    ## expect_equal(sc_init() |>
    ##              sc_filter(unitid == 1000, instnm == "MU"), out)

    ## out <- list("sc_init_list" = TRUE,
    ##             "dfvars" = FALSE,
    ##             "select" = "&_fields=id,school.state,school.name",
    ##             "select_order" = c("unitid", "stabbr", "instnm"),
    ##             "filter" = "id=1000&school.name=MU",
    ##             "zip" = NULL,
    ##             "year" = "latest")

    ## expect_equal(sc_init() |>
    ##              sc_filter(unitid == 1000, instnm == "MU") |>
    ##              sc_select(unitid, stabbr, instnm), out)


})
