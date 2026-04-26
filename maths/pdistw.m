function D = pdistw(X, w, Distance, ~)
D2 = pdist2w(X, X, w, Distance);
D2(1:length(D2)+1:end) = 0; 
D = squareform(D2, "tovector"); 
end