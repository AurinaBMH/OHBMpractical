function norm_expression = normalize_expression_vector(selectGenes, probeInformation, parcelExpression)
% normalize_expression    normalizes expression measures for selected genes using z-score normalization
%
%---INPUTS:
% selectGenes, cell containing gene names
% probeInformation, structure containing information about genes (columns
% in parcelExpression variable)
% parcelExpression, matrix containing regional gene expression measures
% (rows - regions, columns - genes)
%
%---OUTPUT:
% normalized gene expression values

% select all genes at once
[~,indG] = intersect(probeInformation.GeneSymbol, selectGenes);
expVals = parcelExpression(:, indG); 
% do the operations in a vectorised form
norm_expression = (expVals - nanmean(expVals))./nanstd(expVals); 

end
