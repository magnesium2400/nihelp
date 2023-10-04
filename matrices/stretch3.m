function output = stretch3(inp)
%STRETCH3 Summary of this function goes here
%   Detailed explanation goes here
output = nan( size(inp,1)*size(inp,2)*size(inp,3) , size(inp,4) );
for ii = 1:size(inp,4)
    temp = inp(:,:,:,ii);
    output(:,ii) = temp(:);
end

end

