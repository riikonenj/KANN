# Function for validating KANN user input
validate_kann_input <- function(ref.profiles,
                                dist.matrix,
                                k,
                                p,
                                r0){
  # ref.profiles
  stopifnot("Reference sample profiles is NULL" = !is.null(ref.profiles))
  stopifnot("Column named 'ID' not found in reference sample profiles" = "ID" %in% colnames(ref.profiles)) # ID column
  stopifnot("No population columns found" = ncol(ref.profiles) > 1)
  stopifnot("ID column must be character" = is.character(ref.profiles$ID))

  # dist.matrix
  stopifnot("Distance matrix is NULL" = !is.null(dist.matrix))
  stopifnot("Number of columns of distance matrix must match number of reference profile rows" = ncol(dist.matrix) == nrow(ref.profiles))
  stopifnot("Distance matrix column name IDs do not match reference profiles IDs" = identical(sort(colnames(dist.matrix)), sort(ref.profiles$ID)) == TRUE)

  # K:
  stopifnot("K not numeric" = is.numeric(k))
  stopifnot("K has to be positive integer" = k > 0)
  stopifnot("K larger than number of reference samples" = k <= nrow(ref.profiles))

  # p:
  stopifnot("p not numeric" = is.numeric(p))
  stopifnot("p has to be non-negative" = p >= 0)

  # r0:
  stopifnot("Min. radius r0 not numeric" = is.numeric(r0))
  stopifnot("Min. radius r0 has to be non-negative" = r0 >= 0)


}
