# Budget Object
new_budget <- function() {
  structure(list(
    meta = tibble::tibble(),
    accounts = tibble::tibble(),
    payees = tibble::tibble(),
    payee_locations = tibble::tibble(),
    months = tibble::tibble(),
    scheduled_transactions = tibble::tibble(),
    categories = list(),
    transactions = list(),
    last_downloaded = NULL,
    last_knowledge_of_server = NULL
  ),
  class = "budget")
}

set_budget_meta <- function(x, dat) {
  stopifnot(identical(sort(names(dat)),
                      sort(c("id", "name", "last_modified_on", "first_month",
                             "last_month", "format", "iso_code",
                             "example_format", "decimal_digits",
                             "decimal_separator", "symbol_first",
                             "group_separator", "currency_symbol",
                             "display_symbol"))))

  set_attr(x, "meta", dat)
}

set_token.budget <- function(x, token) {
  stopifnot(length(token) == 1)
  stopifnot(is.character(token))

  set_attr(x, "token", token)
}

get_token.budget <- function(x) {
  get_attr(x, "token")
}

get_meta <- function(x) {
  get_attr(x, "meta")
}

get_attr <- function(x, which) {
  stopifnot(which %in% names(new_my_budget()))

  x[[which]]
}

set_attr <- function(x, which, val) {
  x[[which]] <- val
  x
}

print.ynab_budget <- function(x) {
  if (nrow(x$meta) == 0) cat("\nThis budget has no data yet.\n")

}

parse_budget_meta <- function(response) {
  response %>%
    purrr::flatten() %>%
    dplyr::bind_cols() %>%
    dplyr::mutate(
      last_modified_on = lubridate::ymd_hms(last_modified_on),
      first_month = lubridate::ymd(first_month),
      last_month = lubridate::ymd(last_month),
      last_downloaded = NA
    )
}