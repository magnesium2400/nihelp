function viewh(flag)
%% VIEWH View (hemisphere) using anatomical position
%% Examples
%   figure; scatter3(rand(10,1), rand(10,1), rand(10,1)); viewh('l')
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

switch flag
    case {'l',  'left',         'll','rm'};     view([-90    0]); 
    case {'r',  'right',        'lm','rl'};     view([ 90    0]); 
    case {'s',  'superior',     'top'};         view([  0   90]); 
    case {'i',  'inferior',     'bottom'};      view([  0  -90]); 
    case {'p',  'posterior',    'back'};        view([  0    0]); 
    case {'a',  'anterior',     'front'};       view([180    0]); 
    otherwise; try view(flag); catch; view([0 0]); end
end
