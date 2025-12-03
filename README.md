# Assessing the Statistical Significance of Clusters Using SigClust

## Authors: Makena Grigsby & Sharvee Joshi


## Overview 
This project investigates when apparent clustering in high-dimensional data represents true statistical separation versus when it is merely an artifact of noise. We explore this question using the SigClust hypothesis test (Liu et al., 2008; Huang et al., 2015), which formally tests:

$H_0$: Data arise from a single Gaussian distribution

$H_1$: More than one cluster exists.

The project consists of:
- Implementing SigClust on simple simulated data for intuition.
- Exploring cluster behavior under three core scenarios: (1) Null, (2) Strong Signal (Alt 1), (3) Weak Dense Signal (Alt 2).
- Running BRCA cancer subtype simulations, replicating settings from Huang et al. (2015).
- Synthesizing results into a formal written report.

This repository contains reproducible code, the final R Markdown report, and all supporting functions.

## SigClust Conceptual Summary
SigClust evaluates cluster significance by:
1. Applying 2-means (k=2) clustering to compute the cluster index (CI):
   
$$\text{CI} = \dfrac{\text{within-cluster sum of squares}}{\text{total sum of squares}}$$
	
  ​
2. Estimating the null distribution of CI under a single-Gaussian model using Monte Carlo simulation.

3. Comparing the observed CI to the null CI distribution → p-value.

The statistical methodology (covariance shrinkage, eigenvalue thresholding, null distribution estimation) is covered in the report’s Methodology section.

## Simulation Scenarios

### Null - One Gaussian Distribution
- Spiked covariance: 10 large eigenvalues (variance = 50) + 990 noise dimensions (variance = 1)
- No cluster separation
- SigClust returns a large p-value (~0.82)
- Observed CI lies in the bulk of the null distribution
- **Interpretation:** no evidence of true clustering

### Alternative 1 - Strong One Direction Split 
- Groups differ by a large shift in only the first coordinates
- SigClust returns p ≈ 0
- Observed CI extremely small relative to null
- **Interpretation:** clear, statistically detectable cluster structure

### Alternative 2 - Dense Weak Shift 
- Groups shift slightly in every coordinate
- High-dimensional noise dominates
- SigClust p-values are unstable (sometimes significant, sometimes not)
- **Interpretation:** SigClust often fails to reject because signal is too weak and illustrates the “dense weak signal” detection challenge described in the paper

## BRCA Analysis

In addition to our controlled Gaussian simulations, our project also references a BRCA (breast cancer) subtype analysis inspired by Huang et al. (2015). The BRCA setting is useful because some subtype pairs are known to be biologically distinct, while others are much harder to separate. This allows SigClust to be evaluated on realistic, high-dimensional gene expression structure.

### Simulation Approach
To mirror the structure analyzed in the paper, the BRCA simulation workflow proceeds in three main steps:
1. Feature Filtering
2. Pairwise Subtype Comparisons
3. SigClust Configuration

Our goal is not to reproduce the full BRCA dataset, but rather to mimic the structure described in the literature and evaluate whether SigClust correctly identifies which subtype pairs exhibit meaningful biological separation.

## References

Huang, H., Liu, Y., Yuan, M., & Marron, J. S. (2015). Statistical Significance of Clustering Based on High-Dimensional Data. Journal of Computational and Graphical Statistics, 24(3), 975–993.

SigClust R Package Documentation.
https://cran.r-project.org/web/packages/sigclust/sigclust.pdf

Liu, Y., Hayes, D., Nobel, A. B., & Marron, J. S. (2008). Statistical Significance of Clustering for High-Dimension, Low-Sample Size Data. Journal of the American Statistical Association, 103(483), 1281–1293.

## Team Contributions 
| Team Member            | Contributions                                                                                                                                                                                                                                |
| ---------------------- | -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Sharvee** | GitHub setup, implementation of SigClust simulation functions, design of Null/Alt1/Alt2 scenarios, interpretation of SigClust diagnostics, PCA visualization, abstract, introduction, implementation section, troubleshooting runtime issues |
| **Makena**  | Methodology section, conceptual statistical theory, covariance estimation discussion, BRCA simulation setup, BRCA results interpretation, literature analysis, formatting and editing of report                                              |

