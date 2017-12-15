#' Query the history Bitcoin Price Index.
#'
#' This function is used to query the history BPI.
#' Currency, start date, end date can be specified in the query.
#' The return dataframe consists of BPI data and respective date.
#' Powered by CoinDesk: https://www.coindesk.com/price/
#'
#' @param currency Query currency code (default is USD).
#' @param start Query start date, YYYY-MM-DD format.(default is last one month)
#' @param end Query end date, YYYY-MM-DD format.
#' @param yesterday Logical variable, if set to true, will return yesterday's BPI.
#' @return Return a dataframe consists of historical BPI.
#' @export
#' @examples
#' get_history('CNY','2017-10-11','2017-11-20')
#' get_history(yesterday=TRUE)
#' get_history('CNY')
#' get_history()

get_history <- function(currency = NULL, start = NULL, end = NULL, yesterday = FALSE) {

  if (is.null(currency)) cur <- 'USD'
  else cur <- currency
  url <- "https://api.coindesk.com/v1/bpi/historical/close.json?"
  if (yesterday == TRUE) {
    request <- httr::GET(url, query = list(currency = cur, 'for' = 'yesterday'))
    if (httr::status_code(request) != 200) {
      cat('Bad response, please try again')
      return()
    }
    json <- httr::content(request,"text", encoding = "ISO-8859-1")
    listData <- jsonlite::fromJSON(json)$bpi
    df <- do.call("rbind", lapply(listData, data.frame))
    colnames(df) <- 'price'
    return(df)
  }
  # user does't specify start date and end date
  if (is.null(start)) {
    request <- httr::GET(url, query = list(currency = cur))
    if (httr::status_code(request) != 200) {
      cat('Bad response, please try again')
      return()
    }
    json <- httr::content(request,"text", encoding = "ISO-8859-1")
    listData <- jsonlite::fromJSON(json)$bpi
    df <- do.call("rbind", lapply(listData, data.frame))
    colnames(df) <- 'price'
    return(df)
  }

  request <- httr::GET(url, query = list(currency = cur, start = start, end = end))
  if (httr::status_code(request) != 200) {
    cat('Bad response, please try again')
    return()
  }
  json <- httr::content(request,"text", encoding = "ISO-8859-1")
  listData <- jsonlite::fromJSON(json)$bpi
  df <- do.call("rbind", lapply(listData, data.frame))
  colnames(df) <- 'price'
  return(df)
}
