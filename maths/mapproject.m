function out = mapproject(v, type, params)
%% MAPPROJECT Project from unit sphere to plane or plane to unit sphere
%% Examples
%   v=randn(1000,3); v=v./vecnorm(v,2,2); v2=mapproject(v,'eqaazim'); figure; scatter(v(:,1),v(:,2));
%   v=randn(1000,3); v=v./vecnorm(v,2,2); v2=mapproject(mapproject(v,'eqaazim'),'eqaazim'); assert(allclose(v,v2));
%   p=[sqrt(rand(1000,1))*2, rand(1000,1)*2*pi]; v=p(:,1).*[cos(p(:,2)),sin(p(:,2))]; v=mapproject(v,'eqaazim'); figure; scatter3(v(:,1),v(:,2),v(:,3),'.');
%
%   [v,f]=sphereMesh; figure; nexttile; patchvfc(v,f); v2=mapproject(v,'eqacylin'); nexttile; patchvfc(v2,f);
%   v=randn(1000,3); v=v./vecnorm(v,2,2); for t=["eqaazim","cassini","eqdcylin","eqacylin"]; v2=mapproject(mapproject(v,t),t); assert(allclose(v,v2)); end
%
%
%% TODO
% * docs
%
%
%% See also
% `https://en.wikipedia.org/wiki/List_of_map_projections`
% `https://au.mathworks.com/help/map/summary-and-guide-to-projections.html`
%
%
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%


if size(v,2) == 2                       % Plane to sphere
    switch type
        case 'eqaazim'
            out(:,3) = -1 + pdist2(v,[0,0],'squaredeuclidean')/2;
            out(:,1:2) = sqrt((1-out(:,3))/2).*v;
        case 'cassini'
            phi = asin(sin(v(:,2)).*cos(v(:,1)));
            lambda = atan2(tan(v(:,1)), cos(v(:,2)));
            [out(:,1),out(:,2),out(:,3)] = sph2cart(lambda,phi,1);
        case 'eqdcylin'
            lambda = v(:,1);
            phi = v(:,2); 
            [out(:,1),out(:,2),out(:,3)] = sph2cart(lambda,phi,1);
        case 'eqacylin'
            lambda = v(:,1); 
            phi = asin(v(:,2)); 
            [out(:,1),out(:,2),out(:,3)] = sph2cart(lambda,phi,1);
        otherwise
            error("Incorrect type specified");
    end



elseif size(v,2) == 3                   % Sphere to plane
    [az,el] = cart2sph(v(:,1),v(:,2),v(:,3));
    switch type
        case 'eqaazim'
            out = sqrt(2./(1-v(:,3))).*v(:,1:2);
        case 'cassini'
            lambda = az; phi = el;
            out(:,1) = asin(cos(phi).*sin(lambda));
            out(:,2) = atan2(sin(phi),cos(phi).*cos(lambda));
        case 'eqdcylin'
            out(:,1) = az;
            out(:,2) = el;
        case 'eqacylin'
            out(:,1) = az; 
            out(:,2) = sin(el); 
        otherwise
            error("Incorrect type specified");
    end
end



end

