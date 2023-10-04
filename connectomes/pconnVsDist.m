function out = pconnVsDist(A,D, varargin)
%PCONNVSDIST Summary of this function goes here
%   Detailed explanation goes here
% A = nxn adjacency matrix
% D = nxn distance matrix
% bins = bin edges or nbins


ip = inputParser;
ip.addRequired('A');
ip.addRequired('D');
ip.addParameter('bins', []);
ip.addParameter('doPlot', false);
ip.addParameter('symmetric', true);
ip.addParameter('yyright', true);
ip.addParameter('summaryStatistic', @(x) nnz(x)/numel(x) ); %@mean or @(x) mean(nonzeros(x)) for mean edge weight in each bin
ip.addParameter('yyrightLabel', 'Probability of Connection');
ip.addParameter('yyrightScale', 'log');
ip.parse(A, D, varargin{:});
A = ip.Results.A;
D = ip.Results.D;
bins = ip.Results.bins;


if ip.Results.symmetric
    A = triu2vec(A, 1);
    D = triu2vec(D, 1);
else
    A = A(:);
    D = D(:);
end


if isempty(bins)
    [bincounts, binedges, binidx] = histcounts(D(:));
else
    [bincounts, binedges, binidx] = histcounts(D(:), bins);
end


out = splitapply(ip.Results.summaryStatistic, A, binidx); 


if ip.Results.doPlot
    histogram('BinEdges', binedges, 'BinCounts', bincounts, 'FaceColor', [0.5 0.5 0.5]);
    ylabel('Number of Edges');
    xlabel('Distance');
    if ip.Results.yyright
        yyaxis right;
        histogram('BinEdges', binedges, 'BinCounts', out); 
        set(gca, 'YScale', ip.Results.yyrightScale);
        ylabel(ip.Results.yyrightLabel);
        hold on; 
        scatter( (binedges(1:(end-1))+binedges(2:end))/2, out , 5, 'black', 'filled'); 
%         bestfit(2); lsline;
    end
end

