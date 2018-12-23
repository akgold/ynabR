new_budget_set <- function() {
  structure(list(
    token = "",
    budgets = tibble::tibble()
  ),
  class = "budget_set")
}

print.budget_set <- function(x) {
  b <- get_budgets(x)
  if (token == "") {
    warning("\nToken not yet set. See https://api.youneedabudget.com/#personal-access-tokens for how to get one.\n") }
  else if (length(class(b)) == 1 && class(b) == "response") {
    warning("\nBudgets not yet parsed.\n")
  } else if (nrow(b) == 0) {
    warning("\nBudgets not yet downloaded.\n")
  }  else {
    cat(glue::glue("\nBudget Set with {nrow(b)} budget{ifelse(nrow(b) == 1, '' , 's')}.\n\n"))
    print(b %>%
            dplyr::select(name, last_modified_on, first_month, last_month,
                          last_downloaded))
    cat("\n\n")
  }
  invisible(x)
}

is_budget_set <- function(x) {
  "budget_set" %in% class(x)
}

set_token.budget_set <- function(x, token) {
  x$token <- token
  x
}

get_token.budget_set <- function(x) {
  x$token
}

set_budgets <- function(x, budgets) {
  x$budgets <- budgets
  x
}

get_budgets <- function(x) {
  x$budgets
}

is_token_set <- function(x) {
  stopifnot(is_budget_set(x))

  get_token(x) != ""
}

download.budget_set <- function(x, download = TRUE) {
  stopifnot(is_budget_set(x))

  if (get_token(x) == "test") return(set_budgets(x, load_test_dat("bs")))

  x %>%
    get_token() %>%
    get_url("budgets") %>%
    httr::GET() %>%
    jsonlite::parse_json() %>%
    set_budgets(x, .)
}

parse.budget_set <- function(x) {
  b <- x %>%
    get_budgets() %>%
    magrittr::extract2("data") %>%
    magrittr::extract2("budgets") %>%
    purrr::map(parse_budget_meta) %>%
    dplyr::bind_rows()
  set_budgets(x, b)
}

load_test_dat <- function(which) {
  dat <- readRDS(file.path("tests", "test_dat.rds"))
  stopifnot(which %in% names(dat))

  dat[[which]]
}