# OHBMpractical

This repository provides Matlab code for OHBM hackathon practical session.
### Data files
Please download file `geneExpression.mat` from [cloudstor](https://cloudstor.aarnet.edu.au/plus/s/pGRbhqC5zTUPWzY), create `data` folder in the root directory and place the `geneExpression.mat` file there.
### Code
First, setup by adding required paths by running `setupPaths()` function. Then, the script `visualise_geneExpression.m` will plot a set of histograms visualising regional gene expression for selected genes and pairwise correlations between them. 

To run functions separately:

```matlab
    % add paths required for the project:
    setupPaths()
    % load data
    load('geneExpression.mat')
```

* `plot_distributions({'ABCA2', 'CAPN2', 'CTDSPL'}, probeInformation, parcelExpression, true)`
![](figures/histogramGenes.png)

* `plot_scatter({'ABCA2', 'CAPN2', 'CTDSPL'}, probeInformation, parcelExpression,true)`
![](figures/scatterGenes.png)
