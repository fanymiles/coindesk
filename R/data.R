#' Bitcoin Price Index presented in CNY from 2017-10-01 to 2017-12-01
#'
#' This data provides a small sample of the query result from the get_history() function.
#' The original query function is set as: get_history(currency = 'CNY',start = '2017-10-01', end = '2017-12-01'), where the currency is specified as CNY. And start date and end date are specified as above.
#' The rownames of the data frame are repective time.
#'
#' @usage{"df"}
#' @format The df data frame contains 62 observations on 1 variable.
#' \describe{
#'   \item{price}{The Bitcoin Price Index, in CNY}
#' }
#' @source \url{ https://www.coindesk.com/price/}
"df"
