function f = plot_scatter(selectGenes, probeInformation, parcelExpression,makeNewFigure)

% plot_scatter    plots scatter plots for each pair of selected genes
%
%---INPUTS:
% selectGenes, cell containing gene names
% probeInformation, structure containing information about genes (columns
% in parcelExpression variable)
% parcelExpression, matrix containing regional gene expression measures
% (rows - regions, columns - genes)
% makeNewFigure, logical specifying to amke a new figure
%
%---OUTPUT:
% figure visualising distributions

% make a new figure, if selected
if makeNewFigure
f = figure('color','w');
set(gcf, 'Position', [200 500 1800 500])
end

numGenes = length(selectGenes); 
numPairs = nchoosek(numGenes,2); 

% select all expression measures to find min and max values that will be used to set axes
sg = char(selectGenes); 
[~,indALL] = intersect(probeInformation.GeneSymbol, sg); 
expALL = parcelExpression(:,indALL); 

k=1;
for g1=1:numGenes
    for g2=g1+1:numGenes
        
        indG1 = strcmp(probeInformation.GeneSymbol, selectGenes{g1});
        indG2 = strcmp(probeInformation.GeneSymbol, selectGenes{g2});
        % select a subplot
        subplot(1,numPairs,k);
        scatter(parcelExpression(:,indG1), parcelExpression(:,indG2),100, 'MarkerEdgeColor',[33,102,172]/255 ,'MarkerFaceColor',[1 1 1], 'LineWidth',3);
        set(gcf, 'renderer', 'painters')
        r = corr(parcelExpression(:,indG1), parcelExpression(:,indG2), 'rows', 'complete'); 
        % plot best fit line
        h2 = lsline;
        h2.LineWidth = 4;
        h2.LineStyle = ':';
        h2.Color = [0.2, 0.2, 0.2];
       
        % give labels
        xlabel(sprintf('%s\n', selectGenes{g1}))
        ylabel(sprintf('%s\n', selectGenes{g2}))
        
        % write correlation as title
        title(sprintf('r=%s', num2str(round(r,2))))
        
        xlim([min(expALL(:)) max(expALL(:))])
        ylim([min(expALL(:)) max(expALL(:))])
        
        axis square
        box off
        set(gca,'fontsize', 14);

        k=k+1;
    end
end

% apply same axes to all subplots for consistency



end