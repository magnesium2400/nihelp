function l = symlim(varargin)
%% SYMLIM Symmetrise axes limits
%% Examples
%   figure; scatter(-5:10, -5:10); symlim(1); 
%   figure; scatter(-5:10, -5:10); symlim(2); 
%   figure; scatter(-5:10, -5:10); symlim([1 2]); 
%   figure; scatter3(-5:10, -5:10, -5:10); symlim([1 3]); 
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
whichAxes = args{1}; 

for ii = whichAxes(:)'
    
    switch ii
        case 1; f = @xlim; 
        case 2; f = @ylim; 
        case 3; f = @zlim; 
    end

    ls = f(ax); 
    [a,b] = max(abs(ls)); 
    f(ax, [-1 1] * a); 
    l(ii) = ls(b); %#ok<AGROW>

end

end
