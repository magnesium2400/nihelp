function inp = thresholdMatrix(inp, varargin)


%% Prelims
ip = inputParser;
addRequired(ip, 'inp', @isnumeric);
addParameter(ip, 'max', [], @isnumeric);
addParameter(ip, 'min', [], @isnumeric);
addParameter(ip, 'nnz', [], @isnumeric);
addParameter(ip, 'density', [], @isnumeric);

addParameter(ip, 'inclusive', true, @islogical);
addParameter(ip, 'newValue', nan);

ip.parse(inp, varargin{:});
inp = ip.Results.inp;
inc = ip.Results.inclusive;
nv = ip.Results.newValue;

iud = @(x) any(contains(ip.UsingDefaults, x)); %isUsingDefault


%% Thresholding
if ~iud('density')
    inp = thresholdMatrix(inp, 'nnz', round(ip.Results.density * numel(inp)), ...
        'inclusive', inc, 'newValue', nv); 
    return; 
end

if ~iud('nnz')
    nn = ip.Results.nnz;
    if numel(inp) < nn
        warning('nihelp:thresholdMatrix:insufficientElements', ...
            'The supplied matrix has fewer than the desired number of elements');
        return;
    end
    if nnz(inp) < nn
        warning('nihelp:thresholdMatrix:insufficientNonzeroElements', ...
            'The supplied matrix has fewer than the desired number of nonzero elements');
        return;
    end
    if nnz(inp) == nn; return; end


    temp = sort(inp(:), 'descend');
    thr = temp(nn);

    if temp(nn) == temp(nn+1) && ~inc
        inp(inp<=thr) = nv;
    else % if temp(nn) ~= temp(nn+1) || inc
        inp(inp<thr) = nv;
    end

    return;
end

if ~iud('min')
    if inc; f = @lt; else; f = @le; end
    inp(f(inp, ip.Results.min)) = nv;
end

if ~iud('max')
    if inc; f = @gt; else; f = @ge; end
    inp(f(inp, ip.Results.max)) = nv;
end



