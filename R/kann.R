
#' KANN Algorithm
#'
#' Estimates ancestry fractions for a set of query individuals based on
#' distances in principal components space and reference sample ancestries.
#' The function requires the distance matrix as an input, see documentation for
#' distance_matrix function.
#'
#' @param ref.profiles data.table of reference sample profiles
#' @param dist.matrix matrix of pairwise distances between query (row) and reference (column) samples
#' @param k Number of nearest samples (positive integer) to consider in kNN-regression
#' @param p Power of the inverse distance in which to raise reference sample weights
#' @param r0 Minimum radius inside which samples are assigned same weight r0
#'
#' @return data.table of query sample profiles
#' @export
#' @import data.table
#'
#' @examples
#'
#' data(pcaexample)
#' data(eigvalexample)
#' data(refidexample)
#' data(refexample)
#' data(queryidexample)
#'
#' dist <- distance_matrix(eigenvec = pcaexample,
#'                         eigenval = eigvalexample,
#'                         id.ref = refidexample,
#'                         id.query = queryidexample,
#'                         pcs = 2)
#'
#' query.profiles <- kann(ref.profiles = refexample,
#'                        dist.matrix = dist,
#'                        k = 25,
#'                        p = 0,
#'                        r0 = 0.1)
#'
kann <- function(ref.profiles = NULL,
                 dist.matrix = NULL,
                 k = 25,
                 p = 0,
                 r0 = 0.1){

  validate_kann_input(ref.profiles = ref.profiles,
                      dist.matrix = dist.matrix,
                      k = k,
                      p = p,
                      r0 = r0)

  # Array indices of samples distances to themselves (this is zero)
  i.zerodist <- which(dist.matrix == 0, arr.ind = TRUE)

  # Preprocess PCA distance matrix to sample ancestry weight matrix
  weights.matrix <- dist.matrix # copy matrix
  weights.matrix[which(weights.matrix < r0, arr.ind = TRUE)] <- r0 # assign r0 to distances less than r0
  weights.matrix <- weights.matrix^(-p) # Raise distance to inverse power
  weights.matrix[i.zerodist] <- 0 # Set 0 for sample weight on themselves

  # Sort each row in distance matrix by column indices
  weights.sorted.ix <- t(apply(dist.matrix, 1, FUN=function(row){
    row[row == 0] <- max(row)+1 # zero distances to last position
    sort(row, index.return = TRUE, decreasing = FALSE)$ix
  }))

  # Vector of population labels
  populations <- colnames(ref.profiles)[2:ncol(ref.profiles)]

  # Estimate ancestry profiles of query samples based on ref sample weights
  query.profiles <- data.table(ID = rownames(weights.matrix))

  for(pop in populations){

    # Reference sample target population profiles
    ref.pop.profiles <- ref.profiles[match(colnames(weights.matrix), ref.profiles$ID), pop, with = FALSE]

    # Add population profiles as column to matrix (depending on K)
    if(is.null(k) | k == ncol(weights.matrix)){ # K not defined or same as number of reference samples
      query.profiles[,pop] <- as.numeric(rowSums(weights.matrix %*% as.matrix(ref.pop.profiles)) / rowSums(weights.matrix))
    } else{
      query.profiles[,pop] <- as.numeric(sapply(1:nrow(weights.matrix), FUN=function(row){
        # Indices of K nearest samples, excluding reference sample itself
        i.sort <- weights.sorted.ix[row, 1:k]
        sum(weights.matrix[row, i.sort] * ref.pop.profiles[i.sort]) / sum(weights.matrix[row, i.sort])
      }))
    }
  }

  # Query sample ancestry profiles
  return(query.profiles)

}

