clear all; close all;
% ------------------------------------------
% choose genes to visualise
selectGenes = {'ABCA2', 'CAPN2', 'CTDSPL'}; 
makeNewFigure = true; 
% ------------------------------------------

% load data
load('data/geneExpression.mat')

% ------------------------------------------
% plot the distributions of gene expression for selected genes
f1 = plot_distributions(selectGenes, probeInformation, parcelExpression,makeNewFigure);
% save the figure
figureName = sprintf('figures/histogramGenes.png');
print(f1,figureName,'-dpng','-r600');
% ------------------------------------------


% ------------------------------------------
% calculate pairwise correlationa and plot the scatter-plots for selected genes
f2 = plot_scatter(selectGenes, probeInformation, parcelExpression,makeNewFigure);
% save the figure
figureName = sprintf('figures/scatterGenes.png');
print(f2,figureName,'-dpng','-r600');
% ------------------------------------------