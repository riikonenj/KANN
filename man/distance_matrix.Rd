% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/compute_distance_matrix.R
\name{distance_matrix}
\alias{distance_matrix}
\title{Distance matrix}
\usage{
distance_matrix(
  eigenvec = NULL,
  eigenval = NULL,
  id.ref = NULL,
  id.query = NULL,
  pcs = 10,
  cores = 1
)
}
\arguments{
\item{eigenvec}{data.table object of sample eigenvectors (PCs) (required)}

\item{eigenval}{numeric vector of eigenvalues (required)}

\item{id.ref}{character vector of reference sample IDs (required)}

\item{id.query}{character vector of query sample IDs (required)}

\item{pcs}{number of first PCs (integer) or specify custom set of PCs with numeric vector}

\item{cores}{Number of parallel CPU cores utilized}
}
\value{
Matrix of pairwise distances between query and reference samples
}
\description{
Computes and returns a matrix of eigenvalue-weighted pairwise distances between query
and reference samples in the principal component space. Distance matrix is required
prior to applying the KANN algorithm
}
\examples{

data(pcaexample)
data(eigvalexample)
data(refidexample)
data(queryidexample)
dist <- distance_matrix(eigenvec = pcaexample,
                        eigenval = eigvalexample,
                        id.ref = refidexample,
                        id.query = queryidexample,
                        pcs = 2,
                        cores = 1)

}
