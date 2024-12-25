function out = str2color(str)
str = string(str); 
out = reshape(rowfunc(@doOnce, str(:)), [size(str,1:ndims1(str)), 3]); 

end


function out = doOnce(str)
switch str
    case {'red'    , 'r'};  out = [1 0 0];
    case {'green'  , 'g'};  out = [0 1 0];
    case {'blue'   , 'b'};  out = [0 0 1];
    case {'cyan'   , 'c'};  out = [0 1 1];
    case {'magenta', 'm'};  out = [1 0 1];
    case {'yellow' , 'y'};  out = [1 1 0];
    case {'black'  , 'k'};  out = [0 0 0];
    case {'white'  , 'w'};  out = [1 1 1];

    case {'back'   , 'bg', 'background'};   out = [240 240 240]/255;
    case {'grey', 'gray', 'e', 'a'};        out = [1 1 1]/2;
end
end



