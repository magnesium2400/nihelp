function out = int2color(num)
% outputs a color based on the lines colormap

out = reshape(rowfunc(@doOnce, num(:)), [size(num,1:ndims1(num)), 3]); 

end


function out = doOnce(num)
switch mod(num,7)
    case 1; out = [     0    0.4470    0.7410];
    case 2; out = [0.8500    0.3250    0.0980];
    case 3; out = [0.9290    0.6940    0.1250];
    case 4; out = [0.4940    0.1840    0.5560];
    case 5; out = [0.4660    0.6740    0.1880];
    case 6; out = [0.3010    0.7450    0.9330];
    case 0; out = [0.6350    0.0780    0.1840];
end
end



