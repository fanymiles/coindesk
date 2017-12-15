#' Get the currency code for Bitcoin Price Index query.
#'
#' This function is used to show all the currency codes used for BPI query.
#' Powered by CoinDesk: https://www.coindesk.com/price/
#'
#' @return Return a dataframe consists of supported currency codes.
#' @export
#' @examples
#' get_currency_code()

get_currency_code <- function() {

  url <- "https://api.coindesk.com/v1/bpi/supported-currencies.json"
  request <- httr::GET(url)
  if (httr::status_code(request) != 200) {
    cat('Bad response, please try again')
    return()
  }
  json <- httr::content(request,"text", encoding = "ISO-8859-1")
  df <- jsonlite::fromJSON(json)
  return(df)
}

# get_currency_code()


