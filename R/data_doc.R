#' Example PCA eigenvector data
#'
#' A data set containing PCA coordinates and IDs for reference and query samples.
#'
#' @format data table:
#' \describe{
#'   \item{ID}{character, sample identifier (e.g., "Ref1", "Query1")}
#'   \item{PC1}{numeric, 1st principal component coordinate}
#'   \item{PC2}{numeric, 2nd principal component coordinate}
#' }
#' @usage data(pcaexample)
#' @source Simulated data
"pcaexample"

#' Reference Ancestry Fractions
#'
#' A data set with ancestry fractions for reference individuals.
#'
#' @format data table:
#' \describe{
#'   \item{ID}{character, sample identifier (e.g., "Ref1")}
#'   \item{POP1}{numeric, ancestry fraction for population 1}
#'   \item{POP2}{numeric, ancestry fraction for population 2}
#'   \item{POP3}{numeric, ancestry fraction for population 3}
#' }
#' @usage data(refexample)
#' @source Simulated data
"refexample"

#' Reference sample IDs
#'
#' A character vector with IDs for reference individuals.
#'
#' @format character vector
#' @usage data(refidexample)
#' @source Simulated data
"refidexample"

#' Query sample IDs
#'
#' A character vector with IDs for query individuals.
#'
#' @format character vector
#' @usage data(queryidexample)
#' @source Simulated data
"queryidexample"

#' Eigenvalues of PCA
#'
#' A numeric vector containing the eigenvalues of the PCA analysis.
#'
#' @format numeric vector
#' @usage data(eigvalexample)
#' @source Simulated data
"eigvalexample"
