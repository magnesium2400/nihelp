function [c, v_c, n_c] = centroid_fct(v, idx, n_pc, eq_n, split_fact, ...
    init_iter, realign, drawfig, dot_size)
%CENTROID_FCT k-means based clustering algorithm
%
% This clustering algorithm is based on k-means clustering, but offers some
% additional features. The goal was to provide a method to realize
% same-sized clusters. A corresponding flag eq_n can be set to enforce
% re-assignment of observations to clusters, after the centroids are
% calculated. In addition, split_fact may be set with the goal of
% suppressing empty clusters.
%
% The input array v expects a list of cartesian coordinates; an additional
% boolean idx can be used to select a subset of observations for the
% clustering. In this case, the remaining observations are assigned at the
% end to the respective nearest cluster. idx is ignored when a scalar, e.g.
% 0, is passed. Supplying an idx may be useful when a subset of
% observations shall define the centroids.
%
% The algorithm starts with k-means. When split_fact is set, clusters that
% are larger by split_fact compared to a smaller cluster are split into
% two, removing the smaller cluster for another clustering attempt. With
% split_fact set or n_pc > 0, the algorithm will split the largest clusters
% to remove empty ones. Otherwise, it will take the square root of the
% number of observations as cluster size and allow small or emtpy clusters.
%
% With a low split_fact set, the algorithm doesn't converge well which is
% why after a certain number of iterations, both the split factor is
% increased as well as the number of tries.
%
% When eq_n is true, the algorithm afterwards reassigns the observations,
% starting from the outermost centroids and filling them up.
%
% When realign is true, the centroids are finally realigned according to
% their (post-k-means) assigned observations.
%
% This has worked alright for my use case; however, results may vary. Use
% the draw_fig flag to observe the result. dot_size is a two-valued vector
% specifying the size of observation and centroid dots.
%
%   Outputs:
%   c: centroid positions, v_c: observation assignment to centroids /
%   clusters, n_c: number of resulting centroids
%
%   Inputs:
%   v: array with coordinates of observations (colums: kartesian coords.)
%   idx (bool): indices of considered observations
%   n_pc (int): desired cluster size (0 if unknown)
%   eq_n (bool): attempt equal number of observations per cluster
%   split_clust (bool): split largest cluster into two and remove smallest
%   init_iter (int): initial number of iterations before increasing
%   split_clust by 0.1 and init_iter by 5
%   realign (bool): realign cluster positions (use with eq_n = true)
%   drawfig: draw a figure in each iteration
%   dot_size: parameter for plotting (format: [n,m,l]; use with drawfig)
%
% By Kai-Daniel Buechter

%% parameters
if length(idx)>1
    v_all = v;                                  % save for later
    v = v(idx,:);                               % if observations are specified by idx, redefine v
end

dim = size(v,2);                                % dimension of v
n_v = size(v,1);                                % number of observations

if n_pc == 0
    n_pc = round(sqrt(n_v));                    % define size
end
n_c = ceil(n_v/n_pc);                           % number of clusters
r = zeros(n_v,n_c);                             % distance to centroids
c = zeros(n_c,dim);                             % centroid positions
v_c = randi(n_c,n_v,1);

%% display settings
if 1
    if length(idx)>1
        X = sprintf('%d of %d observations considered',sum(idx),size(v_all,1));
        disp(X);
    else
        disp('All observations considered.')
    end
    if n_pc ==0
        disp('no cluster size specified');
    else
        X = sprintf('cluster size is %d, resulting in %d clusters',n_pc, n_c);
        disp(X);
    end
    if eq_n
        disp('target equal cluster size')
    else
        disp('unequal cluster size')
    end
    if split_fact > 1
        X=sprintf('split clusters with factor %1.2f',split_fact);
        disp(X)
    elseif split_fact == 0
        disp('don''t split clusters')
    elseif split_fact < 1
        split_fact = abs(split_fact) + 1*(abs(split_fact)<1);
        X=sprintf('split clusters factor adjusted to %1.2f',split_fact);
        disp(X)
    end
    if realign
        disp('realign equalized centroids to considered observations')
    else
        disp('no realign')
    end
end

if drawfig
    figure(1)
    ccolor = linspace(0,10,n_c);
    if dim>2
        f11 = scatter3(v(:,1),v(:,2),v(:,3),dot_size(1),ccolor(v_c),'Filled');
    elseif dim == 2
        f11 = scatter(v(:,1),v(:,2),dot_size(1),ccolor(v_c),'Filled');
    else
        f11 = scatter(v,v,dot_size(1),ccolor(v_c),'Filled');
    end
    hold on
    if dim>2
        f12 = scatter3(c(:,1),c(:,2),c(:,3),dot_size(2),ccolor','Filled');
    elseif dim == 2
        f12 = scatter(c(:,1),c(:,2),dot_size(2),ccolor','Filled');
    else
        f12 = scatter(c,c,dot_size(2),ccolor','Filled');
    end
    hold off
    axis equal
    xlabel('x')
    ylabel('y')
    zlabel('z')
    
    figure(2)
    h1 = histogram(v_c);
    title('cluster sizes');
    mmics = sprintf('max ratio: %1.2f', split_fact);
    legend(mmics)
    drawnow
end



%% begin
stopcrit = 0;
iterations = init_iter-5;
split_fact = split_fact-0.1;
while ~stopcrit
    v_c_prev = 0;   % track changes
    
    %% initial cluster assignment
    while length(union(v_c,1:n_c))~=n_c         % assure that all are considered
        v_c = randi(n_c,n_v,1);                 % initial, random assignment of observations to centroids
    end
    in_c(1:n_c) = sum(v_c == 1:n_c);
    
    %% k-means loop (modified)
    dv_c = 0;
    counter = 0;
    
    mmic = split_fact;
    iterations = iterations + 5;
    split_fact = split_fact + 0.1;
    X = sprintf('Split clusters factor changed to %1.2f, trying %d iterations',split_fact, iterations);
    disp(X);
    
    while ~dv_c && counter < iterations %~isequal(deps,deps_prev)
        if mmic > split_fact
            counter = counter+1;
        end
        
        %% move centroids
        for ic = 1:n_c                          % each centroid
            if sum((v_c==ic)) > 0               % only if centroid ic is assigned
                c(ic,:) = mean(v(v_c==ic,:),1);	% center of assigned v's: estimate nearest
            end
        end
        
        %% split cluster
        if (max(in_c) > split_fact*min(in_c)) && split_fact
            [~,split_idx] = sort(in_c);
            %             small_clust = find(in_c(split_idx)./in_c(fliplr(split_idx))<(1/split_fact),1,'last');
            max_clust = length(in_c);
            for i=1:1%small_clust
                min_c_idx = split_idx(i);
                max_c_idx = split_idx(max_clust-i+1);
                c(min_c_idx,:) = c(max_c_idx,:) + 0.001 * mean(sqrt(sum(v(v_c==max_c_idx).*v(v_c==max_c_idx),2))) * (2*rand(1,dim)-1);
                c(max_c_idx,:) = c(max_c_idx,:) + 0.001 * mean(sqrt(sum(v(v_c==max_c_idx).*v(v_c==max_c_idx),2))) * (2*rand(1,dim)-1);
            end
        elseif (min(in_c)==0 && n_pc>0)
            [split_sort,split_idx] = sort(in_c);
            %             small_clust = find(split_sort==0,1,'last');
            max_clust = length(in_c);
            for i=1:1%small_clust
                min_c_idx = split_idx(i);
                max_c_idx = split_idx(max_clust-i+1);
                c(min_c_idx,:) = c(max_c_idx,:) + 0.001 * mean(sqrt(sum(v(v_c==max_c_idx).*v(v_c==max_c_idx),2))) * (2*rand(1,dim)-1);
                c(max_c_idx,:) = c(max_c_idx,:) + 0.001 * mean(sqrt(sum(v(v_c==max_c_idx).*v(v_c==max_c_idx),2))) * (2*rand(1,dim)-1);
            end
        end
        
        %% calculate distance matrix
        r(:) = 0;                               % distance of each observations to centroids
        for iv = 1:n_v                          % observations idx
            for j = 1:n_c                       % centroid idx
                for k = 1:dim
                    r(iv,j) = r(iv,j) + (v(iv,k)-c(j,k))^2;
                end
            end
        end
        r = sqrt(r);
        [~,v_c] = min(r,[],2);
        %         notNAN = ~isnan(c(:,1));
        in_c(1:n_c) = sum(v_c == 1:n_c);
        
        
        %% check changes
        dv_c = sum(v_c - v_c_prev) == 0;
        v_c_prev = v_c;
        mmic = max(in_c)/min(in_c);
        
        if drawfig
            if dim>2
                f11.YData = v(:,2);
                f11.ZData = v(:,3);
            elseif dim == 2
                f11.YData = v(:,2);
            else
                f11.YData = v(:,1);
            end
            hold on
            if dim>2
                f12.YData = c(:,2);
                f12.ZData = c(:,3);
            elseif dim == 2
                f12.YData = c(:,2);
            else
                f12.YData = c(:,1);
            end
            f11.XData = v(:,1);
            f12.XData = c(:,1);
            f11.CData = ccolor(v_c);
            f12.CData = ccolor';
            hold off
            
            h1.Data = v_c;
            mmics = sprintf('max ratio: %1.2f', mmic);
            legend(mmics)
            drawnow
        end
    end
    
    if split_fact % && eq_n
        stopcrit = length(unique(v_c))==n_c && (max(in_c) < split_fact*min(in_c)); % all clusters assigned and of acceptible size
    else
        stopcrit = 1;                       % no splitting desired - any cluster size acceptible
    end
end
X = sprintf('Found result after %d iterations, split factor of %1.2f', counter, split_fact);
disp(X)

if eq_n                                     % reassign observations toward equalizing number of observations per cluster
    in_c = zeros(n_c,1);                    % observations assigned to cluster
    v_c = zeros(n_v,1);                     % cluster assigned to observations
    v_idx = 1:n_v;                          % observation idx
    
    c_idx = mean(r.^2,1);                   % mean square distance of centroids from CoG
    [~,c_idx] = sort(c_idx,'descend');      % sort by mean square distance
    
    n_pc_i = ones(n_c,1)*n_pc;              % individualize cluster size (integers) to accomodate all observations
    if sum(n_pc_i)~=n_v
        n_pc_d = n_v-sum(n_pc_i);
        %         n_pc_ds = zeros(n_c,1);           % random selection of clusters
        %         n_pc_adj = randperm(n_c,abs(n_pc_d));
        %         n_pc_ds(n_pc_adj) = 1.*sign(n_pc_d);
        %         n_pc_i = n_pc_i+n_pc_ds;
        n_pc_i(c_idx(1:(abs(n_pc_d)))) = n_pc_i(c_idx(1:(abs(n_pc_d)))) + sign(n_pc_d);
        % sorted by distance from CoG
    end
    
    while sum(v_c==0)>0                     % continue until all observations assigned
        for icc = 1:n_c                     % running index for clusters
            ic = c_idx(icc);                % cluster idx: start from centroid farthest from CoG
            if sum(v_c==0)>0                % continue while not all observations assigned
                curr_other_clust = in_c < n_pc_i;
                curr_other_clust(ic) = 0;   % consider all other clusters that are not full
                i_addtocluster = r(:,ic) - min(r(:,curr_other_clust),[],2); % tmp - distance comparison
                % add if distance to this centroid is smallest
                [~,i_addtocluster] = sort(i_addtocluster,'ascend');	% sort by distance to all others
                if isempty(i_addtocluster)
                    i_addtocluster = v_idx; % fallback
                end
                i = 0;                      % running index for observation
                while ~isempty(v_idx) && in_c(ic) < n_pc_i(ic) && i < length(i_addtocluster)
                    i = i+1;
                    iv = i_addtocluster(i);     % begin with observations nearest to centroid ic
                    if ismember(iv,v_idx)       % not yet assigned
                        v_c(iv) = ic;           % assign a centroid to each observation
                        in_c(ic) = in_c(ic)+1;  % count number of observations in cluster
                        v_idx(v_idx==iv) = [];  % remove observation from unassigned list
                    end
                end
                
                if realign                      % realign centroids according to re-assigned clusters
                    if sum((v_c==ic)) > 0
                        c(ic,:) = mean(v(v_c==ic,:));
                    end
                end
            end
            
            if drawfig
                v_cc=v_c;
                v_cc(v_cc==0)=1;
                if dim>2
                    f11.XData = v(:,1);
                    f11.YData = v(:,2);
                    f11.ZData = v(:,3);
                    f11.CData = ccolor(v_cc);
                elseif dim == 2
                    f11.XData = v(:,1);
                    f11.YData = v(:,2);
                    f11.CData = ccolor(v_cc);
                else
                    f11.XData = v(:,1);
                    f11.YData = v(:,1);
                    f11.CData = ccolor(v_cc);
                end
                hold on
                if dim>2
                    f12.XData = c(:,1);
                    f12.YData = c(:,2);
                    f12.ZData = c(:,3);
                    f12.CData = ccolor';
                elseif dim == 2
                    f12.XData = c(:,1);
                    f12.YData = c(:,2);
                    f12.CData = ccolor';
                else
                    f12.XData = c(:,1);
                    f12.YData = c(:,1);
                    f12.CData = ccolor';
                end
                hold off
                
                
                h1.Data = v_c;
                mmic = max(in_c)/min(in_c);
                mmics = sprintf('max ratio: %1.2f', mmic);
                legend(mmics)
                drawnow
                %                 figure(2)
                %                 histogram(v_c)
%                 %                 histogram(in_c)
%                 title('cluster sizes');
                drawnow
            end
        end
    end
end

%% regenerate index and add ignored observations
if length(idx)>1                    % if idx was defined, assign remaining observations
    n_va = size(v_all,1);           % nbr. of all observations
    r = zeros(n_va,n_c);            % distance to centroids
    for in = find(idx == false)'    % all ignored observations
        for j = 1:n_c               % number of centroids
            for k = 1:dim
                r(in,j) = r(in,j) + (v_all(in,k)-c(j,k))^2;
            end
        end
    end
    r = sqrt(r);
    v_c_all = zeros(n_va,1);
    v_c_all(idx) = v_c;             % considered observations
    [~,v_c_all(idx == false)] = min(r(idx == false,:),[],2);    % ignored observations
    v_c = v_c_all;
    
    if drawfig
        if dim>2
            f11.XData = v(:,1);
            f11.YData = v(:,2);
            f11.ZData = v(:,3);
            f11.CData = ccolor(v_c);
        elseif dim == 2
            f11.XData = v(:,1);
            f11.YData = v(:,2);
            f11.CData = ccolor(v_c);
        else
            f11.XData = v(:,1);
            f11.YData = v(:,1);
            f11.CData = ccolor(v_c);
        end
        hold on
        if dim>2
            f12.XData = c(:,1);
            f12.YData = c(:,2);
            f12.ZData = c(:,3);
            f12.CData = ccolor';
        elseif dim == 2
            f12.XData = c(:,1);
            f12.YData = c(:,2);
            f12.CData = ccolor';
        else
            f12.XData = c(:,1);
            f12.YData = c(:,1);
            f12.CData = ccolor';
        end
        hold off

        figure(2)
        histogram(v_c)
        title('cluster sizes');
        drawnow
    end
end

end