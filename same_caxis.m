function new_caxis = same_caxis(axesArray)
% SAME_CAXIS sets all caxis to the global max and min
%   same_caxis changes the caxis for any number of (sub)plots so that they
%   all use the same caxis. The function is called by passing handles for the
%   individual axes that are to be made the same.
%
%   same_caxis(h1,h2,...) changes the caxis for axes h1, h2, ... , making
%   them the same.
%
%   h = same_caxis(h1,h2,...) changes the caxis for axes h1, h2, ... and 
%   returns the new caxis as the two element row vector h. 
%
%   Example:
%       [X,Y,Z] = peaks(30);
%       figure;
%       h1 = subplot(1,2,1);
%       pcolor(X,Y,Z); axis square;
%
%       h2 = subplot(1,2,2);
%       pcolor(X,Y,2*Z); axis square;
%
%       same_caxis(h1,h2);

new_caxis = caxis(axesArray(1));

for jj = 2:length(axesArray)
    t = caxis(axesArray(jj));
    new_caxis(1) = min(new_caxis(1), t(1));
    new_caxis(2) = max(new_caxis(2), t(2));
end

for jj = 1:length(axesArray)
    caxis(axesArray(jj), new_caxis);
end