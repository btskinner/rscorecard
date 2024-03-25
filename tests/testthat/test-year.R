context("sc_year")

## dummy init list
dil <- list("sc_init_list" = TRUE,
            "dfvars" = FALSE,
            "select" = NULL,
            "select_order" = NULL,
            "filter" = NULL,
            "zip" = NULL,
            "year" = "latest")

test_that("Errors for non-init()", {
  expect_error(sc_year(2000),
               "Chain not properly initialized. Be sure to start with sc_init().")
})

test_that("Bad year range, type, or missing", {
  expect_error(sc_year(dil, 1847),
               paste0("Must provide a 4-digit year in 1900s or 2000s ",
                      "or use the string \"latest\"."), fixed = TRUE)
  expect_error(sc_year(dil, 2100),
               paste0("Must provide a 4-digit year in 1900s or 2000s ",
                      "or use the string \"latest\"."), fixed = TRUE)
  expect_error(sc_year(dil, "2000"),
               paste0("Must provide a 4-digit year in 1900s or 2000s ",
                      "or use the string \"latest\"."), fixed = TRUE)
  expect_error(sc_year(dil, "now"),
               paste0("Must provide a 4-digit year in 1900s or 2000s ",
                      "or use the string \"latest\"."), fixed = TRUE)
  expect_error(sc_year(dil),
               paste0("Must provide a 4-digit year in 1900s or 2000s ",
                      "or use the string \"latest\"."), fixed = TRUE)

})
