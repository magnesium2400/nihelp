function h = subpanel(m,n,p)

w = 1/n; h = 1/m;

% have to swap these indices as ind2sub is columnmajor, but subplot indexing should be rowmajor
[jj, ii] = ind2sub([n m], p); 

x = (jj-1)*w; 
y = (m-ii)*h;

h = uipanel('Position', [x y w h]);

end
