% This is an example of modified code from demonstration make_gencog_centrality_comments.m
% do not attempt to run it, data are not provided, code is for illustration purposes
% --------------------------------------------------
% This script
% 1. compiles subject-specific networks based on different parcellations
% 2. calculates multiple binary and weighted centrality measures
% 3. saves them in a structure for each parcellation
% --------------------------------------------------
clear all; close all;

% load a list of subjects
load('subs.mat')
% specify paths where the data located - to add more data, just need to add
% additional paths to this cell.
pathNames = {'data/HCPMMP1ANDfslatlas20/SIFT2/standard',...
    'data/HCPMMP1ANDfslatlas20/UnSIFTed/density/',...
    'data/aparcANDfirst/SIFT2/standard/',...
    'data/aparcANDfirst/UnSIFTed/density/'};
% specify what measure types should be calculated
measureTypes = {'bin', 'wei'};

for n=1:length(pathNames)

    % specify number of regions in each parcellation
    if contains(pathNames{n}, 'HCPMMP1ANDfslatlas20')
        numReg = 380;
    elseif contains(pathNames{n}, 'aparcANDfirst')
        numReg = 82;
    end

    cd (pathNames{n})
    % compile connecomes - runs from within that directory
    [adjs, Ws] = compile_connectomes(oksubs,numReg);
    cd ../../../..
    % define the number of subject that have connectomes - the number might
    % not be the same as oksubs variable.
    numSubs = size(adjs,2);
    fprintf('Connectomes for %d subjects loaded\n', numSubs)

    % pre-define variables for speed
    den = zeros(numSubs,1);

    % calculate average density
    for i = 1:numSubs
        den(i) = density_und(adjs{i});
    end
    mean_den = mean(den);

    for m=1:length(measureTypes)
        % make a group connectome
        Adj = threshold_consistency(Ws, mean_den);

        mt = measureTypes{m};
        fprintf('Calculating centrality measures for %s %d region network\n', mt, numReg)
        switch mt
            case 'bin'
                % binarise connectome for binary measures to be calculated
                Adj = double(Adj > 0);
                % calculate binary centrality measures
                [group_cent, cent_names, cent_names_abbrev] = calc_centralities_bin(Adj,1);
            case 'wei'
                % calculate weighted centrality measures
                [group_cent, cent_names, cent_names_abbrev] = calc_centralities_wei(Adj,1,1);
        end
        fprintf('%d centrality measures calculated\n', length(cent_names))
        % add additional measure, this one is not included in the function
        % - append at the end of the existing ones.
        % - ideally, would need to include this one into the function, so there is no need to add
        % at the end
        bet_com = communicability_betweenness(Adj,1);
        cent_names_abbrev{size(cent_names,2)+1} = 'COMB';
        cent_names{size(cent_names,2)+1} = 'communicabilityBetweenness';
        cent_measures = [group_cent; bet_com']';

        % define parts of the filename
        if contains(pathNames{n}, 'standard')
            typeNet = 'standard';
        elseif contains(pathNames{n}, 'density')
            typeNet = 'density';
        end

        % place results in the structure separately for binary and weighted measures
        centrality.(mt).measures = cent_measures;
        centrality.(mt).names = cent_names;
        centrality.(mt).abbreviations = cent_names_abbrev;
        centrality.(mt).network = Adj;

        % save the file
        fileName = sprintf('data/results/centrality_%d_%s.mat', numReg, typeNet);
        save(fileName, 'centrality');

    end

end
