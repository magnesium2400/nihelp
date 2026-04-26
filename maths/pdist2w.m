function D = pdist2w(X, Y, w, Distance, ~)

if nargin < 4 || isempty(Distance)
    Distance = 'euclidean';
end

w = weights2spmat(w, height(X)); 

switch lower(Distance)
        
    case 'squaredeuclidean'
        D = ssqw(X, w)' + ssqw(Y, w) - 2 * gramw(X, Y, w);

    case 'euclidean'
        D = sqrt(pdist2w(X, Y, w, 'squaredeuclidean'));
        
    case 'cosine'
        % 1 - <x,y> / (||x|| * ||y||)
        Num = gramw(X, Y, w);
        DenX = vecnormw(X,w,2)';
        DenY = vecnormw(Y,w,2);
        D = 1 - Num ./ (DenX .* DenY);
        
    case 'correlation'
        D = pdist2w(demeanw(X,w), demeanw(Y,w), w, 'cosine');
        
    case 'spearman'
        D = pdist2w(tiedrank(X), tiedrank(Y), w, 'correlation');
        
    otherwise
        error("Distance with " + Distance + " not defined/implemented"); 
end

D = max(D, 0); 

end
