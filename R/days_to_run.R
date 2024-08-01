#' BEAST days to run helper
#'
#' @param total_steps The total number of steps to be performed by the MCMC chain. This is specified inside of the BEAST.xml file under MCMC chain.
#' @param hours_per_million This is the estimate "hours per million steps" value that is given in the print to screen output during a BEAST run.
#'
#' @return Returns an estimate number of days for a BEAST run to finish.
#' @export
#'
#'
days_to_run <- function(total_steps, hours_per_million) {
  # Calculate steps per hour
  steps_per_hour <- 1000000 / hours_per_million

  # Calculate hours to complete total steps
  hours_total <- total_steps / steps_per_hour

  # Calculate and return the number of days
  days_total <- hours_total / 24
  phrase <- paste("Hello there! Your BEAST run should finish in ",round(days_total,digits = 3)," days.")
  return(phrase)
}
