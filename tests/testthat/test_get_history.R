library(coindesk)

test_that("check if the query histoary data is the same as df dataframe", {
  expect_equal(get_history(currency = 'CNY',start = '2017-10-01', end = '2017-12-01'), coindesk::df)
})
