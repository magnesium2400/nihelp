function out = load1(matfilepath, varname)
%% LOAD1 Load one variable from a `.mat` file and return in its own type
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2025
% 
% 

if nargin < 2
    if nargout == 0
        whos('-file', matfilepath)
    else
        out = whos('-file', matfilepath); 
    end
else
    out = matfile(matfilepath).(varname); 
end

% out = getfield(load(matfilepath, varname), varname);
end
