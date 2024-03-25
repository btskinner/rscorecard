context("sc_init")

## confirm init values ---------------------------

dil <- list("sc_init_list" = TRUE,
            "dfvars" = FALSE,
            "select" = NULL,
            "select_order" = NULL,
            "filter" = NULL,
            "zip" = NULL,
            "year" = "latest")

test_that("Default sccall from sc_init()", {
  expect_equal(sc_init(), dil)
})

## confirm bad inits -----------------------------

test_that("Did not start with sc_init()", {
  message <- "Chain not properly initialized. Be sure to start with sc_init()."

  ## one off
  expect_error(sc_select(), message)
  expect_error(sc_filter(), message)
  expect_error(sc_year(), message)
  expect_error(sc_get(), message)
  expect_error(sc_zip(), message)

  ## otherwise correct chains
  expect_error(sc_filter(unitid == 1000) |>
                 sc_select(unitid), message)
  expect_error(sc_filter(unitid == 1000) |>
                 sc_select(unitid) |>
                 sc_year(2020), message)
  expect_error(sc_filter(unitid == 1000) |>
                 sc_select(unitid) |>
                 sc_year(2020) |>
                 sc_get(), message)

  expect_error(sc_select(unitid) |>
                 sc_filter(unitid == 1000), message)
  expect_error(sc_select(unitid) |>
                 sc_filter(unitid == 1000) |>
                 sc_year(2020), message)
  expect_error(sc_select(unitid) |>
                 sc_filter(unitid == 1000) |>
                 sc_year(2020) |>
                 sc_get(), message)

  ## uninitialized chains with other errors (un-init should take precedence)
  expect_error(sc_filter(x == 1000) |>
                 sc_select(unitid), message)
  expect_error(sc_filter(unitid == 1000) |>
                 sc_select(x) |>
                 sc_year(2020), message)
  expect_error(sc_filter(unitid == 1000) |>
                 sc_select(unitid) |>
                 sc_year(1800) |>
                 sc_get(), message)
  expect_error(sc_filter(unitid = 1000) |>
                 sc_select() |>
                 sc_year(1800) |>
                 sc_get(), message)

})
