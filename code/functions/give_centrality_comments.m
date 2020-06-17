% This is an example of code from the demonstration outlining some issues with it
% do not attempt to run it, data are not provided, code is for illustration purposes
% --------------------------------------------------
% No description is given about the code
% The code is not commented at all

% First, we look over the code and try and understand what it does:
% 1. Compiles the connectivity matrices across subjects for a selected brain parcellation
% 2. Calculates a representative group connectome
% 3. Calculates multiple centrality measures (weighted and binary) for a representative connectome
% 4. Manually edits the output;
% 5. Repeats the same procedure for different brain parcellations and connection weights.

% What's wrong with it?
% code and data not separated
% paths are not loaded using a unified script, but loaded separately
addpath /projects/pw38/nameSurname/BCT
addpath /projects/pw38/nameSurname/

% absolute paths are specified
cd /projects/pw38/nameSurname/project/connectomes/FACT/HCPMMP1ANDfslatlas20/SIFT2/standard/

% oksubs variable is not loaded from file, but imported manually - we don't
% know what file was loaded - this could have changed
[adjs, Ws, sub_id] = compile_connectomes(oksubs,380);
% numbers are hard-coded (e.g.380)

% folders changed using absolute paths to find the location of the
% functions used, they are placed together with data
cd /projects/kg98/nameSurname/project/scratch/scratch_shared/connectomes

% what if not all subjects in oksubs have the data? - this variable should
% be based on actual existing data
for i = 1:length(oksubs)
    d(i) = density_und(adjs{i});
    % variable is not pre-defined
    % variable name is no specific enough, should mean something
end

mean_d = mean(d);
gc380 = threshold_consistency(Ws, mean_d);
% variables are specific to the network used (380)
[gc380_cent, cent_names, cent_names_abbrev] = calc_centralities_bin(gc380,1);

bin = double(gc380 > 0);
bet_com = communicability_betweenness(bin,1);

gc380_cent = [gc380_cent; bet_com'];

% indexes hard-coded manually, what if the number of output variables changes?
cent_names_abbrev{12} = 'COMB';
clear bet_com

% very similar operations are done separately for the weighted version of the data
% using different variables
[gc380_cent_wei,cent_wei_names,cent_wei_names_abbrev] = calc_centralities_wei(gc380,1,1);

bet_com = communicability_betweenness(gc380,1);
% different sets of variables created for bin vs wei
gc380_cent_wei = [gc380_cent_wei;bet_com'];
% again, indexes hard-coded manually
cent_wei_names_abbrev{12} = 'COMB_w';

clear bet_com
% all the variables are saved - will contain unnecessary information
% file name is hard-coded
save('gc380_SIFT2_cents.mat')

clearvars -except oksubs

% the same procedure is repeated another 3 times for a different parcellations making the
% same mistakes:
% 1. hard coding variables;
% 2. creating variations of the same operation as separate text;
% 3. hard-coding file names and paths
% 4. naming variables based on data type - will be hard to run a function on the output
% 5. saving all the output


cd /projects/pw38/nameSurname/project/connectomes/connectomes/FACT/HCPMMP1ANDfslatlas20/UnSIFTed/density/

[adjs, Ws, sub_id] = compile_connectomes(oksubs,380);

cd /projects/pw38/nameSurname/project/connectomes/

for i = 1:length(oksubs)
    d(i) = density_und(adjs{i});
end
mean_d = mean(d);
gc380 = threshold_consistency(Ws, mean_d);

[gc380_cent, cent_names, cent_names_abbrev] = calc_centralities_bin(gc380,1);

bin = double(gc380 > 0);
bet_com = communicability_betweenness(bin,1);

gc380_cent = [gc380_cent; bet_com'];

cent_names_abbrev{12} = 'COMB';
clear bet_com
[gc380_cent_wei,cent_wei_names,cent_wei_names_abbrev] = calc_centralities_wei(gc380,1,1);

bet_com = communicability_betweenness(gc380,1);

gc380_cent_wei = [gc380_cent_wei; bet_com'];

cent_wei_names_abbrev{16} = 'COMB_w';

clear bet_com
save('gc380_density_cents.mat')

clearvars -except oksubs

cd /projects/pw38/nameSurname/project/connectomes/connectomes/FACT/aparcANDfirst/SIFT2/standard/

[adjs, Ws, sub_id] = compile_connectomes(oksubs,82);

cd /projects/pw38/nameSurname/project/connectomes/

for i = 1:length(oksubs)
    d(i) = density_und(adjs{i});
end
mean_d = mean(d);
gc82 = threshold_consistency(Ws, mean_d);

[gc82_cent, cent_names, cent_names_abbrev] = calc_centralities_bin(gc82,1);

bin = double(gc82 > 0);
bet_com = communicability_betweenness(bin,1);

gc82_cent = [gc82_cent; bet_com'];

cent_names_abbrev{12} = 'COMB';
clear bet_com
[gc82_cent_wei,cent_wei_names,cent_wei_names_abbrev] = calc_centralities_wei(gc82,1,1);

bet_com = communicability_betweenness(gc82,1);

gc82_cent_wei = [gc82_cent_wei; bet_com'];

cent_wei_names_abbrev{12} = 'COMB_w';

clear rand_bet bet_com
save('gc82_SIFT2_cents.mat')

clearvars -except oksubs

cd /projects/pw38/nameSurname/project/connectomes/FACT/aparcANDfirst/UnSIFTed/density/

[adjs, Ws, sub_id] = compile_connectomes(oksubs,gc82);

cd /projects/pw38/nameSurname/project/connectomes/

for i = 1:length(oksubs)
    d(i) = density_und(adjs{i});
end
mean_d = mean(d);
gc82 = threshold_consistency(Ws, mean_d);

[gc82_cent, cent_names, cent_names_abbrev] = calc_centralities_bin(gc82,1);

bin = double(gc82 > 0);
bet_com = communicability_betweenness(bin,1);

gc82_cent = [gc82_cent; bet_com'];

cent_names_abbrev{12} = 'COMB';

clear rand_bet bet_com

[gc82_cent_wei,cent_wei_names,cent_wei_names_abbrev] = calc_centralities_wei(gc82,1,1);

bet_com = communicability_betweenness(gc82,1);

gc82_cent_wei = [gc82_cent_wei; bet_com'];

cent_wei_names_abbrev{12} = 'COMB_w';
clear rand_bet bet_com
save('gc82_density_cents.mat')
