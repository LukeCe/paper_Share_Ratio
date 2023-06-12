# ---- sectioning -------------------------------------------------------------
.section_counters <- list2env(list("sec" = 0, "subsec" = 0, "subsubsec" = 0))
sec <-
  sec___________________________________________________________________________ <- function(...) {

    .section_counters$sec <- .section_counters$sec + 1
    .section_counters$subsec <- 0
    .section_counters$subsubsec <- 0
    .s <- .section_counters$sec
    message("\n",.s, ") ", ...)
  }

subsec <-
  subsec________________________________________________________________________ <- function(...) {

    .section_counters$subsec <- .section_counters$subsec + 1
    .section_counters$subsubsec <- 0
    .s <- .section_counters$sec
    .ss <- .section_counters$subsec
    message("\n",.s,".",.ss, ") ", ...)


  }

subsubsec <-
  subsubsec_____________________________________________________________________ <- function(...) {
    .section_counters$subsubsec <- .section_counters$subsubsec + 1
    .s <- .section_counters$sec
    .ss <- .section_counters$subsec
    .sss <- .section_counters$subsubsec
    message("\n",.s,".",.ss, ".", .sss, ") ", ...)

  }

# ---- tracking differences ---------------------------------------------------
.data_diff_trackers <- new.env()

message_df <- function(df) {
  if (nrow(df) > 20)
    df <- head(df)
  message(paste0(capture.output(df), collapse = "\n"))
}

msglist <- function(x, drop_names = is.null(names(x))) {
  if (drop_names || is.null(names(x)))
    return(paste0("\n  -", paste0(x, collapse = "\n  -")))
  return(msglist(paste0(names(x), " = ", x), T))
}

# log_df_diff <- function(
#   df_name,
#   new_version,
#   row_diff = TRUE,
#   case_col = NULL,
#   sum_cols = NULL,
#   direct_report = TRUE) {
#
#
#   track_info <- c(
#     .data_diff_trackers[[df_name]],
#     list("dim" = dim(new_version),
#          "cases" = new_version[,case_col],
#          "sums" = colSums(new_version[,case_col],na.rm = T))
#   )
#
#
#   if (direct_report)
#     msg_df_diff(df_name)
# }

# msg_df_diff <- function(df_name, report_cases = F, report_sums = F) {
#
#
#   df_infos <- .data_diff_trackers[[df_name]]
#   n_infos <- length(df_infos)
#
#
#
#   if (n_infos == 0)
#     return(invisible(TRUE))
#
#
#
#   if (n_infos == 1) {
#     info_1 <- df_infos[[1]]
#
#     msg_r <- "[%s] - dataset: with %s rows"
#     msg_r <- sprintf(
#       msg_r, df_name,
#       info_1[["dim"]][1])
#     return(msg_r)
#   }
#
#   if (n_infos >  1) {
#     info_1  <- df_infos[[1]]
#     info_n  <- df_infos[[n_infos]]
#     info_n1 <- df_infos[[n_infos - 1]]
#
#
#     msg_r <- "[%s] - dataset: with (%s/%s) rows"
#     msg_r <- sprintf(
#       msg_r, df_name,
#       info_1[["dim"]][1], info_n[["dim"]][1])
#
#     msg_c <- setdiff(info_n1[["cases"]], info_n[["cases"]])
#     msg_c <- msglist(msg_c)
#     msg_c <- sprintf(" lost observations: %s", msg_c)
#
#
#     sum_diff <- rbind(info_1)
#     msg_s <-
#
#       "Changes in total information"
#     #, nrow(df_new))
#   }
#
#
#   info_old <- .data_diff_trackers[[df_name]]
#   df_old <- info_old[["df"]]
#   df_new <- new_version
#
#
#
#
#   if (is.null(df_old)) {
#     .data_diff_trackers[[df_name]] <- list("df" = df_new, "dim" = dim(df_new))
#     msg <- "[%s] - dataset: with %s rows" # and %s columns"
#     msg <- sprintf(msg, df_name, nrow(df_new)) #, nrow(df_new))
#     return(msg)
#   } else {
#     .data_diff_trackers[[df_name]][["df"]] <- df_new[["df"]]
#     msg_r <- "[%s] - dataset: (%s/%s) rows" #(%s/%s) columns"
#     msg_r <- sprintf(msg_r, df_name, nrow(df_new),nrow(df_old))
#
#     msg_c <- NULL
#     if (!missing(case_col)) msg_c <- setdiff(df_new[,case_col], df_new[,case_col])
#     if (length(msg_c) > 0) msg_c <- msglist(msg_c)
#
#     msg_s <- NULL
#     if (!missing(sum_cols)) stop("Not yet implemented")
#     return(list(msg_r,msg_c,msg_s))
#   }
# }
#




