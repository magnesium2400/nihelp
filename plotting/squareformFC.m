function out = squareformFC(dataIn)
%% same as squareform, however matrix diagonal can be all ones OR all zeros


% if vector, put ones on the diagonal
if (isvector(dataIn))
    out = squareform(dataIn);
    out = out + eye(size(out));
    return
end


% if matrix, permit the diagonals to be all ones instead of all zeros, 
% as is seen in an FC matrix
try
    out = squareform(dataIn);
catch ME

    switch ME.identifier
        case 'stats:squareform:BadInputMatrix'
            if all(abs(diag(dataIn) - 1) < 1e-10)
                out = squareform(dataIn - diag(diag(dataIn)));
            else 
                disp('Diagonal elements are not ALL equal to 0 or close to 1'); 
                rethrow(ME);
            end
        otherwise
            rethrow(ME);
    end

end

end