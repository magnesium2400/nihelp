function X = unfix(X)
%% UNFIX does the opposite of fix i.e. rounds away from 0
%% Examples
%   X = [-1.9 -3.4; 1.6 2.5; -4.5 4.5; 0 Inf; -Inf NaN], Y = unfix(X)
X(X>0) =  ceil(X(X>0)); 
X(X<0) = floor(X(X<0)); 
% X = ceil(X).*(X>0) + floor(X).*(X<0); 
end 