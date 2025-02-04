
#' Distance matrix
#'
#' Computes and returns a matrix of eigenvalue-weighted pairwise distances between query
#' and reference samples in the principal component space. Distance matrix is required
#' prior to applying the KANN algorithm
#'
#'
#' @param eigenvec data.table object of sample eigenvectors (PCs)
#' @param eigenval numeric vector of eigenvalues
#' @param id.ref character vector of reference sample IDs
#' @param id.query character vector of query sample IDs
#' @param pcs number of first PCs (integer) or specify custom set of PCs with numeric vector
#'
#' @return Matrix of pairwise distances between query and reference samples
#' @export
#' @import data.table
#' @examples
#'
#' data(pcaexample)
#' data(eigvalexample)
#' data(refidexample)
#' data(queryidexample)
#' dist <- distance_matrix(eigenvec = pcaexample,
#'                         eigenval = eigvalexample,
#'                         id.ref = refidexample,
#'                         id.query = queryidexample,
#'                         pcs = 2)
#'
distance_matrix <- function(eigenvec = NULL,
                            eigenval = NULL,
                            id.ref = NULL,
                            id.query = NULL,
                            pcs = 10){

  # Validate user input
  validate_distance_matrix_input(eigenvec = eigenvec,
                                 eigenval = eigenval,
                                 id.ref = id.ref,
                                 id.query = id.query,
                                 pcs = pcs)

  # PC weights based on eigenvalues
  if(length(pcs) > 1){
    pc.names <- paste0("PC", pcs)
    eigen.weights <- eigenval[pcs] / sum(eigenval[pcs])
  } else{
    pc.names <- paste0("PC", 1:pcs)
    eigen.weights <- eigenval[1:pcs] / sum(eigenval[1:pcs])
  }

  # Reference sample scores
  eigenvec.ref <- as.matrix(eigenvec[match(id.ref, eigenvec$ID), pc.names, with = FALSE])
  rownames(eigenvec.ref) <- id.ref

  # Query sample scores
  eigenvec.query <- as.matrix(eigenvec[match(id.query, eigenvec$ID), pc.names, with = FALSE])
  rownames(eigenvec.query) <- id.query

  # Compute weighted distances from all query samples to all reference samples
  eigenvec.ref.t <- t(eigenvec.ref)
  distance.matrix <- t(apply(eigenvec.query, 1, FUN = function(row){
    sqrt(as.numeric(colSums( (eigen.weights) * (eigenvec.ref.t-row)^2)))
  }))
  colnames(distance.matrix) <- rownames(eigenvec.ref)

  # Pairwise distances
  return(distance.matrix)
}
