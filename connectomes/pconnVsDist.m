function [probPerBin, bincounts, binedges, binidx, h] = pconnVsDist(W,D, varargin)
%% PCONNVSDIST Evaluates function on connnectome with connections binned by edge length 
%% Input Arguments
%  W - connectome (square matrix)
%  
%  D - matrix of edge lengths (square matrix)
%  
%   
%% Name-Value Arguments
%  bins - nbins or binedges to use (positive integer | vector)
%  
%  
%% Output Arguments  
%  out - results of function applied to edges in each distance bin (vector)
%  
%  
%% See Also
%  HISTCOUNTS, SPLITAPPLY0
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%
%% TODO
% * docs
%
%
%% ENDPUBLISH


%% Prelims
ip = inputParser;
ip.addRequired('W');
ip.addRequired('D');
ip.addParameter('bins', []);
ip.addParameter('summaryStatistic', @(x) nnz(x)/numel(x) ); %@mean or @(x) mean(nonzeros(x)) for mean edge weight in each bin
ip.addParameter('symmetric', true);

ip.addParameter('doPlot', false);
ip.addParameter('yyright', true);
ip.addParameter('yyrightLabel', 'Probability of Connection');
ip.addParameter('yyrightScale', 'log');

ip.parse(W, D, varargin{:});
W = ip.Results.W;
D = ip.Results.D;
bins = ip.Results.bins;


%% Calculations
if ip.Results.symmetric
    W = triu2vec(W, 1);
    D = triu2vec(D, 1);
else
    W = W(:);
    D = D(:);
end

if isempty(bins);   [bincounts, binedges, binidx] = histcounts(D(:));
else;               [bincounts, binedges, binidx] = histcounts(D(:), bins); end

probPerBin = splitapply0(ip.Results.summaryStatistic, W, binidx); 


%% Plotting
if ip.Results.doPlot
    h = histogram('BinEdges', binedges, 'BinCounts', bincounts, 'FaceColor', [0.5 0.5 0.5]);
    ylabel('Number of Edges');
    xlabel('Distance');
    if ip.Results.yyright
        yyaxis right;
        histogram('BinEdges', binedges, 'BinCounts', nan2zero(probPerBin)); 
        set(gca, 'YScale', ip.Results.yyrightScale);
        ylabel(ip.Results.yyrightLabel);
        hold on; 
        scatter( (binedges(1:(end-1))+binedges(2:end))/2, probPerBin , 5, 'black', 'filled'); 
%         bestfit(2); lsline;
    end
end

end
