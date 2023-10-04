function out = dir2(path)
%%DIR2 removes . and .. from DIR
% SEE ALSO DIR
if nargin == 0; path = "."; end
d = dir(path);
out = d(~ismember({d.name}, {'.','..'}));
end
