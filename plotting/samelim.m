function l = samelim(varargin)
%% SAMELIM Set the axes limits to be the same between x/y/z/c axes
%% Examples
%   figure; plot(-1:5); samelim(@xlim, @ylim); 
%   figure; plot(nexttile,-1:5); plot(nexttile,-1:5); samelim(@xlim, @ylim); 
%   
%   figure; plot3(-2:2, -1:3, 1:5); samelim(@xlim, @ylim, @zlim);
%   figure; plot3(-2:2, -1:3, 1:5); samelim(@xlim, @ylim); view(2); 
%   
%   

[ax, args, ~] = axescheck(varargin{:}); 
if isempty(ax); ax = gca(); end

ll = cellfun2mat(@(f) f(ax) , args(:)); % Limits for all the functions
l = [min(ll(:,1)), max(ll(:,2))];       % Max and min
cellfun(@(f) f(ax, l), args);           % Set

end
