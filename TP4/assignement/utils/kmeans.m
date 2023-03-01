function [labels, Mu, Mu_init, iter] =  kmeans(X,K,init,type,MaxIter,plot_iter)
%MY_KMEANS Implementation of the k-means algorithm
%   for clustering.
%
%   input -----------------------------------------------------------------
%   
%       o X        : (N x M), a data set with M samples each being of dimension N.
%                           each column corresponds to a datapoint
%       o K        : (int), chosen K clusters
%       o init     : (string), type of initialization {'sample','range'}
%       o type     : (string), type of distance {'L1','L2','LInf'}
%       o MaxIter  : (int), maximum number of iterations
%       o plot_iter: (bool), boolean to plot iterations or not (only works with 2d)
%
%   output ----------------------------------------------------------------
%
%       o labels   : (1 x M), a vector with predicted labels labels \in {1,..,k} 
%                   corresponding to the k-clusters.
%       o Mu       : (N x k), an Nxk matrix where the k-th column corresponds
%                          to the k-th centroid mu_k \in R^N 
%       o Mu_init  : (N x k), same as above, corresponds to the centroids used
%                            to initialize the algorithm
%       o iter     : (int), iteration where algorithm stopped
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Auxiliary Variable
[D, N] = size(X);
d_i    = zeros(K,N);
k_i    = zeros(1,N);
r_i    = zeros(K,N);
if plot_iter == [];plot_iter = 0;end

% Output Variables
Mu     = zeros(D, K);
labels = zeros(1,N);

% Step 1. Mu Initialization
Mu_init = kmeans_init(X,K,init);

%%%%%%%%%%%%%%%%%         TEMPLATE CODE      %%%%%%%%%%%%%%%%
% Visualize Initial Centroids if N=2 and plot_iter active
colors     = hsv(K);
if (D==2 && plot_iter)
    options.title       = sprintf('Initial Mu with %s method', init);
    ml_plot_data(X',options); hold on;
    ml_plot_centroids(Mu_init',colors);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%% K-Means Algorithm %%%%%
iter      = 0;
tolerance = 1e-6;
tol_iter = 0;
Mu = Mu_init;
while true
    Mu_ = Mu;
    
    % Step 2. Distances from X to Mu
	d_i =  distance_to_centroids(X, Mu, type);
    
    % Step 3. Assignment Step: Mu Responsability (Eq. 5 and 6)    
    [~, k_i] = min(d_i, [], 1);
    
    % Check that all clusters have been assigned
    while (length(unique(k_i)) < K)
        iter      = 0;
        % Redo Mu_init
        Mu_init = kmeans_init(X,K,init);
        Mu = Mu_init; Mu_ = Mu;
        
        % Step 2. Distances from X to Mu
        d_i =  distance_to_centroids(X, Mu, type);
        
        % Step 3. Assignment Step: Mu Responsability (Eq. 5 and 6)
        [~, k_i] = min(d_i, [], 1);        
    end
      
    for ii=1:K
        r_i(ii,:) = k_i == ii;
    end
        
	% Step 4. Update Step: Recompute Mu
    for jj=1:K                
        if (sum(r_i(jj,:)==1)==0)
            Mu(:,jj) = Mu(:,jj);
        else
            Mu(:,jj) = sum(X(:,r_i(jj,:)==1),2)/sum(r_i(jj,:)==1);
        end
    end            
    
    % Check for Mu stabilization 
    err = norm(Mu-Mu_); 
    if (err < tolerance)
        tol_iter = tol_iter + 1;        
        if(tol_iter > 10)
%             fprintf('Algorithm has converged at iter=%d! Stopping k-means.\n', iter);
            break;
        end
    end   
    
    % Check for MaxIter
    if (iter > MaxIter)
         warning(sprintf('Maximum Niter=%d reached! Stopping k-means.', MaxIter));
        break;
    end
        
    %%%%%%%%%%%%%%%%%         TEMPLATE CODE      %%%%%%%%%%%%%%%%       
    if (D==2 && iter == 1 && plot_iter)
        options.labels      = k_i;
        options.title       = sprintf('Mu and labels after 1st iter');
        ml_plot_data(X',options); hold on;
        ml_plot_centroids(Mu',colors);
    end    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%        
    iter = iter+1;
end
labels = k_i;

%%%%%%%%%%%   TEMPLATE CODE %%%%%%%%%%%%%%%
if (D==2 && plot_iter)
    options.labels      = labels;
    options.class_names = {};
    options.title       = sprintf('Mu and labels after %d iter', iter);
    ml_plot_data(X',options); hold on;    
    ml_plot_centroids(Mu',colors);
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
end