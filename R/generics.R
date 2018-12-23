set_token <- function(x, token) {
  UseMethod("set_token")
}

get_token <- function(x) {
  UseMethod("get_token")
}

download <- function(x) {
  UseMethod("download")
}

parse <- function(x) {
  UseMethod("parse")
}