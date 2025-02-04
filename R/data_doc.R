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
#' @source Simulated data
"refexample"

#' Reference sample IDs
#'
#' A character vector with IDs for reference individuals.
#'
#' @format character vector
#' @source Simulated data
"refidexample"

#' Query sample IDs
#'
#' A character vector with IDs for query individuals.
#'
#' @format character vector
#' @source Simulated data
"queryidexample"

#' Eigenvalues of PCA
#'
#' A numeric vector containing the eigenvalues of the PCA analysis.
#'
#' @format numeric vector
#' @source Simulated data
"eigvalexample"
