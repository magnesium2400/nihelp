function out = plotSlice(V, varargin)
%% PLOTSLICE Plots slices of a volume V
% Examples
% load mri; figure; plotSlice(squeeze(D), 60, 60, [20, 10]); colormap gray;


%% Prelims
ip = inputParser;
ip.addRequired('V');
ip.addOptional('xslice', []);
ip.addOptional('yslice', []);
ip.addOptional('zslice', []);
ip.addParameter('surfOptions', {'EdgeColor', 'none'});
ip.addParameter('zeroMidline', false, @islogical);

ip.parse(V, varargin{:});
V = ip.Results.V;
xslice = ip.Results.xslice;
yslice = ip.Results.yslice;
zslice = ip.Results.zslice;
zeroMidline = ip.Results.zeroMidline;

if isempty(xslice) && isempty(yslice) && isempty(zslice)
    xslice = round(size(V,1)/2);
    yslice = round(size(V,2)/2);
    zslice = round(size(V,3)/2);
end

ih = ishold;


%% Plot each slice across all three dimensions
out = [];

[X,Y,Z] = ndgrid( 1:size(V,1) , 1:size(V,2) , 1:size(V,3) );
O = ones(size(V));
slices = {xslice, yslice, zslice};

for d = 1:3
    currentSlices = slices{d};
    for n = currentSlices
        f = @(x) sliceDim(x,d,n);
        data = {f(X),f(Y),f(Z),f(V)};
        data{d} = n*f(O);

        if zeroMidline; data{1} = data{1} - size(V,1)/2; end

        s = surf(data{:}, ip.Results.surfOptions{:});
        out = [out; s]; %#ok<AGROW> %out(end+1) = s doesn't work
        hold on;
    end
end


%% Beautify
axis equal tight;

if zeroMidline; xlim([-1,1]*size(V,1)/2); else; xlim([1, size(V,1)]); end;
ylim([1, size(V,2)]); 
zlim([1, size(V,3)]);

if ~ih; hold off; end


end
