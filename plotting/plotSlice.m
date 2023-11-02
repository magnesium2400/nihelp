function plotSlice(V, xslice, yslice, zslice)
%% PLOTSLICE Plots slices of a volume V

%% Prelims
[X,Y,Z] = ndgrid(1:size(V,1),1:size(V,2),1:size(V,3));
O = ones(size(V));
slices = {xslice, yslice, zslice};

%% Plot each slice across all three dimensions
for d = 1:3
    currentSlices = slices{d};
    for n = currentSlices
        f = @(x) sliceDim(x,d,n);
        data = {f(X),f(Y),f(Z),f(V)};
        data{d} = n*f(O);
        surf(data{:}, 'EdgeColor', 'none'); 
        hold on;
    end
end

%% Beautify
% xlabel('x'); ylabel('y'); zlabel('z');
xlim([1, size(V,1)]); 
ylim([1, size(V,2)]); 
zlim([1, size(V,3)]);



end
