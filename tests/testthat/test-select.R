context('sc_select')

## dummy init list -------------------------------

dil <- list('sc_init_list' = TRUE,
            'dfvars' = FALSE,
            'select' = NULL,
            'select_order' = NULL,
            'filter' = NULL,
            'zip' = NULL,
            'year' = 2013)

test_that('Errors for non-init()', {
    expect_error(sc_select(unitid),
                 'Chain not properly initialized. Be sure to start with sc_init().')
})

test_that('Errors for blank', {
    expect_error(sc_select(dil),
                 'Incomplete sc_select()! You must select at least one variable.',
                 fixed = TRUE)
})


test_that('Error for bad variable names', {
    expect_error(sc_select(dil, x),
                 'Variable "x" not found in dictionary. Please check your spelling or search dictionary: ?sc_dict()',
                 fixed = TRUE)
})

## not on CRAN -----------------------------------

test_that('Selected variables not the same between lazyeval and _ version', {
    check_api()
    df1 <- sc_init() %>%
        sc_filter(region == 2, ccbasic == c(21,22,23), locale == 41:43) %>%
        sc_select(unitid, stabbr) %>%
        sc_year(2013) %>%
        sc_get(debug = TRUE)

    vars <- c('unitid', 'stabbr')
    df2 <- sc_init() %>%
        sc_filter(region == 2, ccbasic == c(21,22,23), locale == 41:43) %>%
        sc_select_(vars) %>%
        sc_year(2013) %>%
        sc_get(debug = TRUE)

    expect_equal(df1, df2)
})

test_that('Select helper starts_with() not working with variable names', {
    check_api()
    expect_type(sc_init() %>%
                sc_filter(region == 2,
                          ccbasic == c(21,22,23),
                          locale == 41:43) %>%
                sc_select(starts_with('ugds')) %>%
                sc_get(debug = TRUE), 'character')

})

test_that('Select helper ends_with() not working with variable names', {
    check_api()
    expect_type(sc_init() %>%
                sc_filter(region == 2,
                          ccbasic == c(21,22,23),
                          locale == 41:43) %>%
                sc_select(ends_with('_hisp')) %>%
                sc_get(debug = TRUE), 'character')

})

test_that('Select helper matches() not working with variable names', {
    check_api()
    expect_type(sc_init() %>%
                sc_filter(region == 2,
                          ccbasic == c(21,22,23),
                          locale == 41:43) %>%
                sc_select(matches('ugds')) %>%
                sc_get(debug = TRUE), 'character')

})

test_that('Select helper contains() not working with variable names', {
    check_api()
    expect_type(sc_init() %>%
                sc_filter(region == 2,
                          ccbasic == c(21,22,23),
                          locale == 41:43) %>%
                sc_select(contains('ugds')) %>%
                sc_get(debug = TRUE), 'character')
})
