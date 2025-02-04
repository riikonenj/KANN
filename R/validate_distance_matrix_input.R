# Function for validating user input on distance matrix computation
validate_distance_matrix_input <- function(eigenvec,
                                           eigenval,
                                           id.ref,
                                           id.query,
                                           pcs){

  stopifnot("Column named 'ID' not found in eigenvec" = "ID" %in% colnames(eigenvec))
  stopifnot("Eigenvalues must be numeric" = is.numeric(eigenval))
  stopifnot("Reference sample IDs must be a character vector" = is.character(id.ref))
  stopifnot("Query sample IDs must be a character vector" = is.character(id.query))
  stopifnot("Number of PCs must be integer or numeric vector" = is.numeric(pcs))

  if(length(pcs) == 1){ # First 1,...,pcs number of PCs
    stopifnot("Number of PCs must be a positive integer" = pcs >= 1)
    stopifnot("Column names 'PC1',...,'PC(pcs)' not found in column names of eigenvec" = (unique(paste0("PC", 1:pcs) %in% colnames(eigenvec)) == TRUE))
  } else{ # a numeric vector of PCs
    stopifnot("Column names 'PC(pcs[1])',...'PC(pcs[length(pcs)])' not found in column names of eigenvec" = unique(paste0("PC", pcs) %in% colnames(eigenvec)) == TRUE)
  }

  stopifnot("At least as many eigenvalues as PCs must be provided" = length(eigenval) >= pcs)
  stopifnot("Reference sample IDs must be found in the 'ID' column of eigenvec" = unique(id.ref %in% eigenvec$ID))
  stopifnot("Query sample IDs must be found in the 'ID' column of eigenvec" = unique(id.query %in% eigenvec$ID))

}
