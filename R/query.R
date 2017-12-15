#' Query the current Bitcoin Price Index.
#'
#' This function is used to query the current price of BPI.
#' Currency can be specified by adding a list of currency codes.
#' The return dataframe consists of four columns data including currency code, description, float rate and time.
#' Powered by CoinDesk: https://www.coindesk.com/price/
#'
#' @param currency A list of currency code (default is USD).
#' @return Return a dataframe consists of current BPI.
#' @export
#' @examples
#' bpi_price()
#' bpi_price(c("EUR","CNY"))

bpi_price <- function(currency = NULL) {

  if (is.null(currency))
  {
    url <- "https://api.coindesk.com/v1/bpi/currentprice.json"
    request <- httr::GET(url)
    if (httr::status_code(request) != 200) {
      cat('Bad response, please try again')
      return()
    }
    json <- httr::content(request, "text", encoding = "ISO-8859-1")
    df <- jsonlite::fromJSON(json)
    time <- df$time$updated
    code <- df$bpi$USD$code
    description <- df$bpi$USD$description
    rate <- df$bpi$USD$rate_float
    res <- data.frame(code,description,rate,time)
    return(res)
  }
  # query price from currencies specified by user
  baseURL <- "https://api.coindesk.com/v1/bpi/currentprice/"
  res <- NULL
  for (cur in currency) {
    url <- paste(baseURL,cur,".json",sep = '')
    request <- httr::GET(url)
    if (httr::status_code(request) != 200) {
      cat('Wrong input currency code, please try again')
      return()
    }
    json <- httr::content(request, "text", encoding = "ISO-8859-1")
    df <- jsonlite::fromJSON(json)
    time <- df$time$updated
    code <- df$bpi[[cur]]$code
    description <- df$bpi[[cur]]$description
    rate <- df$bpi[[cur]]$rate_float
    res <- rbind(res, data.frame(code,description,rate,time))
  }
  return(res)
}

# bpi_price(c('EUR','CNY','ETB'))

