function p = plotLines(sources,targets,varargin)
%% PLOTLINES Plots lines from sources to targets
%% Examples
%   figure; plotLines(rand(10,2), rand(10,2)+1);
%   figure; plotLines(rand(10,3), rand(10,3)+1);
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


if size(sources,2)==2
    p = plot([sources(:,1),targets(:,1)].', [sources(:,2),targets(:,2)].',varargin{:}); 
elseif size(sources,2)==3
    p = plot3([sources(:,1),targets(:,1)].', [sources(:,2),targets(:,2)].', [sources(:,3),targets(:,3)].',varargin{:}); 
end

end