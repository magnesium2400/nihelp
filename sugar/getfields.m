function out = getfields(s, fields)
%% Examples
%   getfields(struct('a',1,'b',2,'c',3), ["a","b"])
%   getfields(struct('a',1,'b',2,'c',3), ["a";"b"])
%   getfields(struct('a',1,'b',2,'c',3), {"a";"b"})
%   getfields(struct('a',1,'b',2,'c',3), {'a','b'})

for f = string(fields(:)'); out.(f) = s.(f); end

end


