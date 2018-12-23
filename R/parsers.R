


# to_data_frame <- function(x) {
#   x %>%
#     null_to_na() %>%
#     dplyr::bind_rows() %>%
#     # currency is in "milliunits" -- thousandths of unit
#     dplyr::mutate_if(is.numeric, ~./1000)
# }
#
# null_to_na <- function(l) {
#   l %>%
#     purrr::map(~ purrr::map(., function(x) ifelse(is.null(x), NA, x)))
# }
