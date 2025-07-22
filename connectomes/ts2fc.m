function out = ts2fc(ts)
%% TS2FC Time series to functional connectivity (Pearson correlation)
%% Examples
%   ts2fc(randn(5,20)+(1:20))
%   ts2fc(randn(5,20)*20+(1:20))
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 

out = 1-squareform(pdist(ts, 'correlation')); 
out(out>1) = 1; 
out(out<-1) = -1; 

end
