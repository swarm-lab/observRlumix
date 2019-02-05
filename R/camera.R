#' @export
initCams <- function(cameras) {
  lapply(cameras, function(x) {
    RCurl::getURL(paste0("http://", x, "/cam.cgi?mode=camcmd&value=recmode"))
  })

  NULL
}


#' @export
grabPictures <- function(cameras) {
  lapply(cameras, function(x) {
    RCurl::getURL(paste0("http://", x, "/cam.cgi?mode=camcmd&value=capture"))
  })

  NULL
}
