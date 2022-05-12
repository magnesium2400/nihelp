function out = rotz(t)
%% ROTZ generates rotation matrix around z axis by t radians
out = [cos(t) -sin(t) 0 ; sin(t) cos(t) 0 ; 0 0 1] ;
end

