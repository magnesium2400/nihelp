function [out, ismax, ismin] = meshExtrema(f, data)
%% Examples
%   [v,f] = sphereMesh; figure; patchvfc(v,f,meshExtrema(f,v(:,3)));
%   [v,f] = sphereMesh; figure; patchvfc(v,f,meshExtrema(f,sum(v,2)));
%   [v,f] = sphereMesh(60,'fib'); v=v*2*pi; figure; e = meshExtrema(f,sin(v(:,1))+sin(v(:,2))+sin(v(:,3))); patchvfc(v,f,e);

e = triangulation2edges(f);
e = [e;fliplr(e)]; 

maxs = accumarray(e(:,1), data(e(:,2)), [], @max, -inf); 
mins = accumarray(e(:,1), data(e(:,2)), [], @min, +inf);

% maxs = splitapply( @(x) max(x,[],1), data(e(:,2),:), e(:,1) ); 
% mins = splitapply( @(x) min(x,[],1), data(e(:,2),:), e(:,1) ); 

ismax = data>=maxs; 
ismin = data<=mins; 

out = ismax - ismin; 

end

