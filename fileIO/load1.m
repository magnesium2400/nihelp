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

out = getfield(load(matfilepath, varname), varname);
end
