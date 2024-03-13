function varNames = unload(dataname)
%% UNLOAD removes variables from workspace
%% Examples
%   whos, load('mri'); whos, unload('mri'); whos
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


varNames = fieldnames(load(dataname)); 
for ii = 1:length(varNames)
    evalin('base', sprintf("clear('%s')", varNames{ii}));
end    
if nargout == 0; clear varNames; end

end
