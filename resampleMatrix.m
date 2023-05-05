function spatialNoise = resampleMatrix(template, varargin)
%RESAMPLEMATRIX Generates a matrix of noise in the same pattern as a template
%   Detailed explanation goes here






% TODO : consider adding support for upper/lower triangles of template (if input
% as a matrix)

%% Prelims
ip = inputParser;
addRequired(ip, 'template', @isnumeric);
addOptional(ip, 'noise', 'gaussian', @isstring);

addParameter(ip, 'seed', []);
addParameter(ip, 'randParams', [0 1]);

parse(ip, template, varargin{:});

template = ip.Results.template;
noise = ip.Results.noise;
seed = ip.Results.seed;
alpha = ip.Results.randParams(1); % mean or min of rand distribution
beta = ip.Results.randParams(2); % SD or max of rand distribution

if ~isempty(seed); rng(seed); end % set seed if specified by user


%% Make and organise noise
% generate noise --> into the variable sortedNoise
switch noise
    case {'gaussian', 'normal'} % generate noise with specified mean and SD
        sortedNoise = sort( randn(numel(template), 1)*beta + alpha );
    case {'uniform'} % generate noise with specified max and min
        sortedNoise = sort( rand(numel(template), 1)*(beta-alpha) + alpha );

    otherwise
        if isnumeric(noise) % user has input their own noise
            assert(numel(noise) == numel(template), ...
                "Noise should contain the same number of elements as input map");
            sortedNoise = sort(noise(:));
        else
            error("Noise input not valid");
        end
end

[~, idx] = sort(template(:)); % get the spatial pattern of the template map
spatialNoise(idx) = sortedNoise; % order the noise according to the spatial pattern
spatialNoise = reshape(spatialNoise, size(template)); % make it the correct shape

end

