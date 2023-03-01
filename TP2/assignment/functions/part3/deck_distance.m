function [dist] = deck_distance(deck, Mu, type)
%DECK_DISTANCE Calculate the distance between a partially filled deck and
%the centroides
%
%   input -----------------------------------------------------------------
%   
%       o deck : (N x 1) a partially filled deck
%       o Mu : (N x K) Value of the centroids
%       o type : type of distance to use {'L1', 'L2', 'Linf'}
%
%   output ----------------------------------------------------------------
%
%       o dist : K X 1 the distance to the k centroids
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N = size(deck,1);
K = size(Mu,2);
Mu_subset = Mu;

for i = 1:N
    if deck(i) == 0
        Mu_subset(i,:) = 0;
    end
end


dist = distance_to_centroids(deck, Mu_subset, type);

end

