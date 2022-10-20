function [has_converged, tol_iter] = check_convergence(Mu, Mu_previous, iter, tol_iter, MaxIter, MaxTolIter, tolerance)
%CHECK_CONVERGENCE Check if the kmeans main loop has converged to a
%solution
%
%   input -----------------------------------------------------------------
%   
%       o Mu : Current value of the centroids
%       o Mu_previous : Previous value of the centroids
%       o iter : Current number of iterations
%       0 tol_iter : Number of iterations since Mu = Mu_previous
%       o MaxIter : Maximum number of iterations
%       o MaxTolIter : Maximum number of iterations for stabilization (Mu =
%       Mu_previous)
%       o tolerance : tolerance for considering Mu = Mu_previous
%
%   output ----------------------------------------------------------------
%
%       o has_converged : true if one of the convergence situation is met
%       o tol_iter : previous tol_iter incremented if stabilization but no
%       convergence, 0 otherwise
%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

has_converged = false;

nb_cluster = size(Mu,2);
dist = zeros(nb_cluster,1);
for i = 1:nb_cluster
    dist(i) = compute_distance(Mu(:,i), Mu_previous(:,i), 'L2');
end

if iter > MaxIter
    has_converged = true;
end

if tol_iter > MaxTolIter
    has_converged = true;
end

if (max(dist,[],2) < tolerance) 
    tol_iter = tol_iter + 1 ;
end

end

