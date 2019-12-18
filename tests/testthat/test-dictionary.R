context('sc_dict')

test_that('Dictionary does not return correct object', {

    ## stabbr (short)
    df1 <- tidyr::tibble(varname = 'stabbr',
                         value = NA_real_,
                         label = NA_character_,
                         description = 'State postcode',
                         source = 'IPEDS',
                         dev_friendly_name = 'state',
                         dev_category = 'school',
                         notes = 'Shown/used on consumer website.')

    df2 <- sc_dict('stabbr', return_df = TRUE, print_off = TRUE)

    expect_identical(df1, df2)

    ## st_fips (long)
    st_value <- c(1, 2, 4, 5, 6, 8, 9, 10, 11, 12, 13, 15, 16, 17, 18,
                  19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32,
                  33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 44, 45, 46, 47,
                  48, 49, 50, 51, 53, 54, 55, 56, 60, 64, 66, 69, 70, 72,
                  78)
    st_label <- c("Alabama", "Alaska", "Arizona", "Arkansas",
                  "California", "Colorado", "Connecticut", "Delaware",
                  "District of Columbia", "Florida", "Georgia", "Hawaii",
                  "Idaho", "Illinois", "Indiana", "Iowa", "Kansas",
                  "Kentucky", "Louisiana", "Maine", "Maryland",
                  "Massachusetts", "Michigan", "Minnesota",
                  "Mississippi", "Missouri", "Montana", "Nebraska",
                  "Nevada", "New Hampshire", "New Jersey", "New Mexico",
                  "New York", "North Carolina", "North Dakota", "Ohio",
                  "Oklahoma", "Oregon", "Pennsylvania", "Rhode Island",
                  "South Carolina", "South Dakota", "Tennessee", "Texas",
                  "Utah", "Vermont", "Virginia", "Washington",
                  "West Virginia", "Wisconsin", "Wyoming",
                  "American Samoa", "Federated States of Micronesia",
                  "Guam", "Northern Mariana Islands", "Palau",
                  "Puerto Rico", "Virgin Islands")
    df1 <- tidyr::tibble(varname = 'st_fips',
                         value = st_value,
                         label = st_label,
                         description = 'FIPS code for state',
                         source = 'IPEDS',
                         dev_friendly_name = 'state_fips',
                         dev_category = 'school',
                         notes = 'Shown/used on consumer website.')

    df2 <- sc_dict('st_fips', return_df = TRUE, print_off = TRUE)

    expect_identical(df1, df2)
})
