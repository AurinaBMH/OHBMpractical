function f = plot_distributions(selectGenes, probeInformation, parcelExpression, doPlot)
% plot_distributions    plots histograms visualising regional gene expression for selected genes 
%
%---INPUTS:
% probeInformation, structure containing information about genes (columns
% in parcelExpression variable)
% parcelExpression, matrix containing regional gene expression measures
% (rows - regions, columns - genes)
%
%---OUTPUT:
% figure visualising distributions

% make a new figure, if selected
if doPlot
f = figure('color','w');
set(gcf, 'Position', [200 500 1500 500])
end


numGenes = length(selectGenes); 

% for each gene
valYLim = cell(numGenes,1); 
valXLim = cell(numGenes,1); 

% loop over selected genes
for g=1:numGenes
    % find corresponding column in the matrix
    indG = strcmp(probeInformation.GeneSymbol, selectGenes{g});
    % select a subplot
    AxHandle(g) = subplot(1,numGenes,g); 
    hist(parcelExpression(:,indG), 20, 'EdgeColor', [33,102,172]/255, 'FaceColor',[1 1 1], ...
        'LineWidth',3)

    axis square
    ylabel('Count')
    xlabel('Gene expression')
    title(sprintf('%s\n', selectGenes{g}))
    box off
    set(gca,'fontsize', 14);
    
    % select axis properties - will apply the same axes to all subplots
    valYLim(g) = get(AxHandle(g), {'YLim'});
    valXLim(g) = get(AxHandle(g), {'XLim'});
end

% apply same axes to all subplots for consistency
allYLim = cat(2, valYLim{:});
allXLim = cat(2, valXLim{:});
set(AxHandle, 'YLim', [min(allYLim), max(allYLim)]);
set(AxHandle, 'XLim', [min(allXLim), max(allXLim)]);

end
