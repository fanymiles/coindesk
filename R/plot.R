#' Plot the historical data of BPI.
#'
#' This function is used to draw a simple plot for historical BPI.
#' Powered by CoinDesk: https://www.coindesk.com/price/
#'
#' @param df Query result from history BPI
#'
#' @export
#' @examples
#' plot_bpi(df)

plot_bpi <- function(df) {
  #library(lubridate)
  #print(rownames(df))
  df$time <- lubridate::ymd(rownames(df))
  ggplot2::ggplot(df, ggplot2::aes(df$time, df$price)) + ggplot2::geom_line(group = 1) +
    ggplot2::scale_x_date(date_labels = "%m-%d") +
    ggplot2::xlab("Time") + ggplot2::ylab("Price")
}

#plot_bpi(df)
