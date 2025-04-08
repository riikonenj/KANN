# KANN

KANN is an R package for estimating genetic ancestry profiles using principal components (PCs).
Ancestry estimation is based on first computing the pairwise eigenvalue-weighted distances between query and reference individuals in the PCA-space.
Together with known ancestry profiles of reference individuals, ancestry is estimated for new query individuals by applying k-nearest neighbor regression.

KANN enables using admixed reference individuals with continuous ancestry information, i.e. having proportions of genetic ancestry inherited from multiple source populations.
In addition, KANN is compatible with the conventional format where reference individuals are discretely allocated to a single source population.
This can be achieved by assigning 100% ancestry to one of the source populations, and 0% to others.

## Installation
```
# Installation from GitHub
devtools::install_github("riikonenj/KANN")
```

## Usage

### Input data

KANN takes as an input:

1. PCA coordinates and IDs for both reference and query samples in data.table format:

```
          ID         PC1        PC2
  1:    Ref1 -0.01561711  2.4081375
  2:    Ref2  0.15248024  1.2998039
  3:    Ref3 -0.14510612  1.4859893
  4:    Ref4  1.38914114 -1.2079563
  5:    Ref5 -0.95442801 -0.4333195
 ---
146: Query46  1.05311991 -0.8222472
147: Query47 -0.27442420 -0.3124595
148: Query48 -0.53274040 -0.1079550
149: Query49 -0.30099626  0.2799824
150: Query50  0.24175229 -0.2976537


```

With first column named ID containing sample IDs, and remaining columns named PC1, PC2, ... etc. corresponding to the sample coordinates on the principal components. Principal components should be standardized to have zero (0) mean and unit (1) variance.

2. Eigenvalues from the PCA analysis as a numeric vector:

```
[1] 0.5395004 0.4604996

```

3. Reference sample ancestry fractions in data.table format:

```
         ID        POP1         POP2        POP3
  1:   Ref1 0.021315186 0.0460213746 0.932663440
  2:   Ref2 0.114520525 0.1935225067 0.691956968
  3:   Ref3 0.123121961 0.0583334502 0.818544589
  4:   Ref4 0.010993413 0.8928960378 0.096110549
  5:   Ref5 0.728646488 0.1404565525 0.130896960
 ---
96:  Ref96 0.006321796 0.0259999206 0.967678284
97:  Ref97 0.822671110 0.1408764744 0.036452416
98:  Ref98 0.033879181 0.7984002015 0.167720618
99:  Ref99 0.920572448 0.0038637129 0.075563839
100: Ref100 0.880139211 0.0318104069 0.088050382

```

4. Reference sample IDs as a character vector (same as IDs in reference sample ancestry fractions table):

```
[1] "Ref1"   "Ref2"   "Ref3" ... "Ref98"  "Ref99"  "Ref100"
```

5. Query sample IDs as a character vector:

```
[1] "Query1"  "Query2"  "Query3" ... "Query48" "Query49" "Query50"
```

### Example data

KANN package comes with dummy data for 100 reference samples and 50 query samples for demonstrating the method.
Both the query and reference samples have scores on the first two principal components. The reference indviduals have ancestry profiles with respect to 3 source populations.
After loading the KANN library, the dummy data can be loaded to the environment with data() function, providing the name of the data object as parameter.
See data_doc.R for the data documentation, and section "Running KANN" of this document for example usage of KANN with dummy data.

### Running KANN

The ancestry estimation first requires the computation of pairwise eigenvalue weighted distances between query and reference samples in the PCA space.

```

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

```

Using the distance matrix and reference sample ancestry profiles, ancestry fractions can be estimated for query samples:

```

data(refexample)

query.profiles <- kann(ref.profiles = refexample,
                       dist.matrix = dist,
                       k = 25,
                       p = 0,
                       r0 = 0.1,
                       cores = 1)
                        
> query.profiles
         ID       POP1       POP2       POP3
 1:  Query1 0.09667044 0.81775561 0.08557395
 2:  Query2 0.50242703 0.09752791 0.40004506
 3:  Query3 0.41744537 0.12394901 0.45860562
 4:  Query4 0.09489899 0.81494447 0.09015653
 5:  Query5 0.08333331 0.06668711 0.84997958
 ---
46: Query46 0.09655258 0.82209717 0.08135025
47: Query47 0.75877036 0.13066451 0.11056512
48: Query48 0.82291879 0.07650332 0.10057788
49: Query49 0.35826334 0.11117423 0.53056244
50: Query50 0.12856602 0.75243320 0.11900078
         ID       POP1       POP2       POP3

```

## Parameters

After loading KANN with ```library("KANN")```, see ```?distance_matrix``` and ```?kann``` for documentation related to distance matrix and k-nearest neighbor regression functions.

### Parallel computation

Parallelization of computation has been implemented with the ```parallel``` package.
The number of utilized cores can be provided as parameter ```cores``` to both functions ```distance_matrix()``` and ```kann()```.
By default, ```cores = 1```.

## Contact

juha.riikonen@helsinki.fi




