# URL Endpoint Functions

####################################################
#             Parameters                           #
####################################################
base_url <- "https://api.youneedabudget.com/v1"
# eps that only take an endpt and optional id for just one
simple_eps <- c("user", "budgets", "accounts", "payees",
                "months", "scheduled_transactions")
# eps that can be within others, names are eps, values are potential withins
within_opts <- list(categories = "months",
                    transactions = c("accounts", "categories",
                                     "payees", "transactions"),
                    payee_locations = "payees")

# all eps
eps <- c(simple_eps, names(within_opts))

#######################################################
#                 URL Building Fns                    #
#######################################################
get_url <- function(token, ep, id = "",
                      within = "", within_id = "") {
  stopifnot(ep %in% eps)

  base_url() %>%
    url_ep(ep, id, within, within_id) %>%
    add_token(token)
}

url_ep <- function(url, ep, id = "",
                   within = "", within_id = "") {
  stopifnot(ep %in% eps)
  if (within != "") {
    add_within(url, within, within_id)
  }

  add_ep(url, ep, id)

}

add_within <- function(url, within, within_id) {
  stopifnot(within_id != "")
  stopifnot(within %in% names(within_opts))
  stopifnot(within %in% within_opts[within])

  add_ep(url, within, within_id)
}

#' Add personal access token to URL
#'
#' @param url url
#' @param token access token
#'
#' @return url w/ access token as parameter
#' @export
#'
#' @examples
#' add_token("https://a_url", "secret_token_xxxx")
add_token <- function(url, token) {
  glue::glue("{url}?access_token={token}")
}


#' Add endpoint to end of URL
#'
#' @param url url
#' @param ep which endpt
#' @param id optional, an id for the endpoint, defaults to ""
#'
#' @return url with endpoint added
#'
#' @examples
#' add_ep("http://google.com", "endpoint")
#' add_ep("http://google.com", "endpoint", "id")
add_ep <- function(url, ep, id = "") {
  paste(url, ep, id, sep = "/")
}


