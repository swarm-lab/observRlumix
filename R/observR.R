#' @export
observR <- function(wemo, cameras, delay = 5) {
  magicLamp::wemo_ON(wemo)
  initCams(cameras)
  magicLamp::wemo_OFF(wemo)

  ui <- svDialogs::dlgInput(message = "Duration of the experiment in seconds")
  duration <- as.numeric(gsub("[^0-9]", "", ui$res))

  ui <- svDialogs::dlgInput(message = "Interval between 2 pictures in seconds")
  interval <- as.numeric(gsub("[^0-9]", "", ui$res))

  times <- now() + seq(0, duration, interval) * 1000

  pb <- progress::progress_bar$new(total = length(times), format = "Progress [:bar] :percent")

  for (i in seq_len(length(times))) {
    success <- FALSE
    while (!success)
      success <- magicLamp::wemo_ON(wemo)$success

    Sys.sleep(delay)

    grabPictures(cameras)

    Sys.sleep(delay)

    pb$tick()

    success <- FALSE
    while (!success)
      success <- magicLamp::wemo_OFF(wemo)$success

    if (i < length(times)) {
      Sys.sleep((times[i + 1] - now()) / 1000)
    }
  }

  NULL
}
