context("sc_zip")

## dummy init list
dil <- list("sc_init_list" = TRUE,
            "dfvars" = TRUE,
            "select" = NULL,
            "filter" = NULL,
            "zip" = NULL,
            "year" = 2013)

## errors
test_that("Missing zip code", {
  expect_error(sc_zip(dil), "Must provide a 5-digit zip code.")
})

test_that("Zip code with non-numeric characters", {
  expect_error(sc_zip(dil, "12sda"), "Zip code must contain only digits.")
  expect_error(sc_zip(dil, "37203-4444"), "Zip code must contain only digits.")
})

test_that("Zip code longer than 5 digits", {
  expect_error(sc_zip(dil, "372034444"),
               "Zip codes cannot be longer than 5 digits.")
})

test_that("Non-numeric distance", {
  expect_error(sc_zip(dil, "37203", "25km"),
               "Distance may only contain digits.")
})

## zip values
test_that("Leading zeros", {
  expect_equal(sc_zip(dil, 11111)[["zip"]], "&_zip=11111&_distance=25")

  ## numeric leading zeros
  expect_equal(sc_zip(dil, 01111)[["zip"]], "&_zip=01111&_distance=25")
  expect_equal(sc_zip(dil, 00111)[["zip"]], "&_zip=00111&_distance=25")
  expect_equal(sc_zip(dil, 00011)[["zip"]], "&_zip=00011&_distance=25")
  expect_equal(sc_zip(dil, 00001)[["zip"]], "&_zip=00001&_distance=25")

  ## string leading zeros
  expect_equal(sc_zip(dil, "01111")[["zip"]], "&_zip=01111&_distance=25")
  expect_equal(sc_zip(dil, "00111")[["zip"]], "&_zip=00111&_distance=25")
  expect_equal(sc_zip(dil, "00011")[["zip"]], "&_zip=00011&_distance=25")
  expect_equal(sc_zip(dil, "00001")[["zip"]], "&_zip=00001&_distance=25")

  ## short version
  expect_equal(sc_zip(dil, 1111)[["zip"]], "&_zip=01111&_distance=25")
  expect_equal(sc_zip(dil, 111)[["zip"]], "&_zip=00111&_distance=25")
  expect_equal(sc_zip(dil, 11)[["zip"]], "&_zip=00011&_distance=25")
  expect_equal(sc_zip(dil, 1)[["zip"]], "&_zip=00001&_distance=25")
})
