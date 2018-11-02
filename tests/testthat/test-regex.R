context('regular expression conversions')

## dev-friendly --> var names: year
test_that('Conversion errors from dev-friendly names to var names: year', {

    ## i := input
    ## o := output
    ## h := hash conversion

    ## academics
    i <- '2016.academics.program_percentage.humanities'
    o <- 'program_percentage.humanities'
    h <- 'pcip24'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## admissions
    i <- '2016.admissions.sat_scores.75th_percentile.critical_reading'
    o <- 'sat_scores.75th_percentile.critical_reading'
    h <- 'satvr75'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## aid
    i <- '2016.aid.median_debt.number.income.30001_75000'
    o <- 'median_debt.number.income.30001_75000'
    h <- 'md_inc_debt_n'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## completion
    i <- '2016.completion.title_iv.loan_recip.transf_unknown_4yr_by.2yrs'
    o <- 'title_iv.loan_recip.transf_unknown_4yr_by.2yrs'
    h <- 'loan_unkn_4yr_trans_yr2_rt'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## cost
    i <- '2016.cost.title_iv.private.by_income_level.110001-plus'
    o <- 'title_iv.private.by_income_level.110001-plus'
    h <- 'num45_priv'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## earnings
    i <- '2016.earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.10'
    o <- '10_yrs_after_entry.working_not_enrolled.earnings_percentile.10'
    h <- 'pct10_earn_wne_p10'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## repayment
    i <- '2016.repayment.3_yr_repayment.income.greater_than_75000'
    o <- '3_yr_repayment.income.greater_than_75000'
    h <- 'hi_inc_rpy_3yr_rt'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## root
    i <- '2016.root.id'
    o <- 'id'
    h <- 'unitid'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## school
    i <- '2016.school.state'
    o <- 'state'
    h <- 'stabbr'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## student
    i <- '2016.student.share_dependent_middleincome.300001_48000'
    o <- 'share_dependent_middleincome.300001_48000'
    h <- 'dep_inc_pct_m1'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)
})

## dev-friendly --> var names: latest
test_that('Conversion errors from dev-friendly names to var names: latest', {

    ## i := input
    ## o := output
    ## h := hash conversion

    ## academics
    i <- 'latest.academics.program_percentage.humanities'
    o <- 'program_percentage.humanities'
    h <- 'pcip24'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## admissions
    i <- 'latest.admissions.sat_scores.75th_percentile.critical_reading'
    o <- 'sat_scores.75th_percentile.critical_reading'
    h <- 'satvr75'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## aid
    i <- 'latest.aid.median_debt.number.income.30001_75000'
    o <- 'median_debt.number.income.30001_75000'
    h <- 'md_inc_debt_n'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## completion
    i <- 'latest.completion.title_iv.loan_recip.transf_unknown_4yr_by.2yrs'
    o <- 'title_iv.loan_recip.transf_unknown_4yr_by.2yrs'
    h <- 'loan_unkn_4yr_trans_yr2_rt'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## cost
    i <- 'latest.cost.title_iv.private.by_income_level.110001-plus'
    o <- 'title_iv.private.by_income_level.110001-plus'
    h <- 'num45_priv'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## earnings
    i <- 'latest.earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.10'
    o <- '10_yrs_after_entry.working_not_enrolled.earnings_percentile.10'
    h <- 'pct10_earn_wne_p10'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## repayment
    i <- 'latest.repayment.3_yr_repayment.income.greater_than_75000'
    o <- '3_yr_repayment.income.greater_than_75000'
    h <- 'hi_inc_rpy_3yr_rt'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## root
    i <- 'latest.root.id'
    o <- 'id'
    h <- 'unitid'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## school
    i <- 'latest.school.state'
    o <- 'state'
    h <- 'stabbr'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)

    ## student
    i <- 'latest.student.share_dependent_middleincome.300001_48000'
    o <- 'share_dependent_middleincome.300001_48000'
    h <- 'dep_inc_pct_m1'
    expect_equal(dev_to_var(i, debug = TRUE), o)
    expect_equal(dev_to_var(i), h)
})

## add year
test_that('Conversion errors when adding year: year', {

    i <- c('academics.program_percentage.humanities',
           'admissions.sat_scores.75th_percentile.critical_reading',
           'completion.title_iv.loan_recip.transf_unknown_4yr_by.2yrs',
           'cost.title_iv.private.by_income_level.110001-plus',
           'earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.10',
           'id',
           'school.state',
           'repayment.3_yr_repayment.income.greater_than_75000')

    o <- c('2016.academics.program_percentage.humanities',
           '2016.admissions.sat_scores.75th_percentile.critical_reading',
           '2016.completion.title_iv.loan_recip.transf_unknown_4yr_by.2yrs',
           '2016.cost.title_iv.private.by_income_level.110001-plus',
           '2016.earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.10',
           'id',
           'school.state',
           '2016.repayment.3_yr_repayment.income.greater_than_75000')

    i_string <- paste(i, collapse = ',')
    o_string <- paste(o, collapse = ',')

    expect_equal(add_year(i_string, '2016'), o_string)

    ## permute
    new_order <- sample(1:length(i))
    i <- i[new_order]
    o <- o[new_order]

    i_string <- paste(i, collapse = ',')
    o_string <- paste(o, collapse = ',')

    expect_equal(add_year(i_string, '2016'), o_string)

})

## add latest year
test_that('Conversion errors when adding year: latest', {

    i <- c('academics.program_percentage.humanities',
           'admissions.sat_scores.75th_percentile.critical_reading',
           'completion.title_iv.loan_recip.transf_unknown_4yr_by.2yrs',
           'cost.title_iv.private.by_income_level.110001-plus',
           'earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.10',
           'id',
           'school.state',
           'repayment.3_yr_repayment.income.greater_than_75000')

    o <- c('latest.academics.program_percentage.humanities',
           'latest.admissions.sat_scores.75th_percentile.critical_reading',
           'latest.completion.title_iv.loan_recip.transf_unknown_4yr_by.2yrs',
           'latest.cost.title_iv.private.by_income_level.110001-plus',
           'latest.earnings.10_yrs_after_entry.working_not_enrolled.earnings_percentile.10',
           'id',
           'school.state',
           'latest.repayment.3_yr_repayment.income.greater_than_75000')

    i_string <- paste(i, collapse = ',')
    o_string <- paste(o, collapse = ',')

    expect_equal(add_year(i_string, 'latest'), o_string)

    ## permute
    new_order <- sample(1:length(i))
    i <- i[new_order]
    o <- o[new_order]

    i_string <- paste(i, collapse = ',')
    o_string <- paste(o, collapse = ',')

    expect_equal(add_year(i_string, 'latest'), o_string)

})
