#' Initialize All Budgets
#'
#' Given your user token, initialize full set of budgets from YNAB.
#'
#' @param token your user token, see instructions at https://api.youneedabudget.com/#personal-access-tokens
#'
#' @return a budget set with metadata on all budgets connected to the account
#' @export
#'
#' @examples
#' # Token test returns example
#' initialize_budgets("test")
initialize_budgets <- function(token) {
  new_budget_set() %>%
    set_token(token) %>%
    download() %>%
    parse()
}

#' Get a single budget from your budget set
#'
#' @param x a budget set
#' @param name name of the budget to extract
#'
#' @return a budget object
#' @export
#'
#' @examples
#'
get_budget <- function(x, name) {

}