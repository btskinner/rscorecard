context('sc_filter')

## dummy init list
dil <- list('sc_init_list' = TRUE,
            'dfvars' = FALSE,
            'select' = NULL,
            'select_order' = NULL,
            'filter' = NULL,
            'zip' = NULL,
            'year' = "latest")

test_that('Errors for non-init()', {
    expect_error(sc_filter(unitid == 99999),
                 'Chain not properly initialized. Be sure to start with sc_init().')
})

test_that('Errors for bad symbols', {
    expect_error(sc_filter(dil, unitid > 99999),
                 'Must use either \"==\", \"!=\", or \"%in%\" in sc_filter.')
    expect_error(sc_filter(dil, unitid < 99999),
                 'Must use either \"==\", \"!=\", or \"%in%\" in sc_filter.')
    expect_error(sc_filter(dil, unitid = 99999),
                 'Must use either \"==\", \"!=\", or \"%in%\" in sc_filter.')
    expect_error(sc_filter(dil, unitid >= 99999),
                 'Must use either \"==\", \"!=\", or \"%in%\" in sc_filter.')
    expect_error(sc_filter(dil, unitid <= 99999),
                 'Must use either \"==\", \"!=\", or \"%in%\" in sc_filter.')
})


test_that('Error for bad variable names', {
    expect_error(sc_filter(dil, x == 99999),
                 'Variable "x" not found in dictionary. Please check your spelling or search dictionary: ?sc_dict()',
                 fixed = TRUE)
})

ids <- c(99999, 99998, 99997)
assign('ids', ids, envir = .GlobalEnv)

test_that('Symbols correctly converted', {
    ## single value
    expect_equal(sc_filter(dil, unitid == 99999)[['filter']],
                 'id=99999')
    ## concatenation
    expect_equal(sc_filter(dil, unitid == c(99999,99998))[['filter']],
                 'id=99999,99998')
    ## using object from global environment
    expect_equal(sc_filter(dil, unitid == ids)[['filter']],
                 'id=99999,99998,99997')
    ## using object from global enviroment with %in%
    expect_equal(sc_filter(dil, unitid %in% ids)[['filter']],
                 'id=99999,99998,99997')
    ## using object from global enviroment: subset to one
    expect_equal(sc_filter(dil, unitid %in% ids[1])[['filter']],
                 'id=99999')
    ## using object from global enviroment: subset to first two
    expect_equal(sc_filter(dil, unitid %in% ids[1:2])[['filter']],
                 'id=99999,99998')
    ## using object from global enviroment: subset to first and third
    expect_equal(sc_filter(dil, unitid %in% ids[c(1,3)])[['filter']],
                 'id=99999,99997')
    ## not equal
    expect_equal(sc_filter(dil, unitid != 99999)[['filter']],
                 'id__not=99999')
    ## accounting for white space in name
    expect_equal(sc_filter(dil, instnm == 'New York')[['filter']],
                 'school.name=New%20York')
    ## accounting for white space in multiple names
    expect_equal(sc_filter(dil, instnm == c('New York', 'New Jersey'))[['filter']],
                 'school.name=New%20York,New%20Jersey')
    ## range
    expect_equal(sc_filter(dil, ccbasic == 10:14)[['filter']],
                 'school.carnegie_basic__range=10..14')
})

## not on CRAN -----------------------------------

test_that('Filtered pulls not the same', {
    check_api()
    df1 <- sc_init() %>%
        sc_filter(region == 2, ccbasic == c(21,22,23), locale == 41:43) %>%
        sc_select(unitid) %>%
        sc_year(2013) %>%
        sc_get(debug = TRUE)

    filter <- c('region == 2', 'ccbasic == c(21,22,23)', 'locale == 41:43')
    df2 <- sc_init() %>%
        sc_filter_(filter) %>%
        sc_select(unitid) %>%
        sc_year(2013) %>%
        sc_get(debug = TRUE)

    expect_equal(df1, df2)
})

test_that('Allows for filter variable that is not approved', {
    check_api()
    expect_error(sc_filter(dil, avgfacsal == 100000))
})
