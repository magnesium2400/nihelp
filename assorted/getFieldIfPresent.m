function out = getFieldIfPresent(structIn, fieldName)
% GETFIELDIFPRESENT checks if a struct contains a field; if so, returns it

if isfield(structIn, fieldName)
    out = structIn.(fieldName); %getfield(structIn, fieldName);
else
    out = [];
end
end