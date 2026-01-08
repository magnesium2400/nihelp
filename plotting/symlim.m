function l = symlim(varargin)
%% SYMLIM Set the x/y/z/c axes limits to be symmetric about 0
%% Examples
%   figure; scatter(-5:10, -5:10); symlim(@xlim); 
%   figure; scatter(-5:10, -5:10); symlim(@ylim); 
%   figure; scatter(-5:10, -5:10); symlim(@xlim, @ylim); 
%   figure; scatter3(-5:10, -5:10, -5:10); symlim(@xlim, @zlim); 
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2025
% 
% 


[ax, args, ~] = axescheck(varargin{:});
if isempty(ax); ax = gca; end

for ii = 1:numel(args)
    f = args{ii}; 
    ls = f(ax); 
    [a,b] = max(abs(ls)); 
    f(ax, [-1 1] * a); 
    l(ii) = ls(b); %#ok<AGROW>
end

end
