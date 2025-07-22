function out = flatten(X, flag)
if nargin>1 & strcmpi(flag,'r');    out = reshape(X', [], 1); 
else;                               out = reshape(X,[],1);      end
end
