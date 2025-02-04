.onAttach <- function(libname, pkgname) {
  # Check for data.table version
  if (utils::packageVersion("data.table") < "1.14.2") {
    packageStartupMessage("Please update data.table to version 1.14.2 or higher for best compatibility")
  }

  # Check R version
  if (getRversion() < "3.5") {
    packageStartupMessage("Please update R to version 3.5 or higher for best compatibility.")
  }
}

