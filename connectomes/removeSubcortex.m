function [out, edgesKept] = removeSubcortex(in, varargin)
%REMOVESUBCORTEX removes subcortex with MANY implicit assumptions
%   SPECIFY TOTAL NUMBER OF DATA POINTS IN MATRIX (**NOT** NUMBER IN ONE HEMISPHERE) 
%   if in == 68*68, assume Desikan Killiany and do nothing
%   if in == 82*82, assume Desikan Killiany and remove 35-42 and 75-82
%   if in == 200*200, assume Schaefer and do nothing
%   if in == 220*220, assume Schaefer and remove 101-110 and 211-220
%   if in == 360*360, assume Glasser and do nothing
%   if in == 380*380, assume Glasser and remove 181-190 and 351-360
%   if in == 500*500, assume Schaefer and do nothing
%   if in == 520*520, assume Schaefer and remove 251-260 and 511-520

%% Prelims
ip = inputParser;
addRequired( ip, 'in', @(x) ( isnumeric(x) && (size(x,1)==size(x,2)) ) );
addParameter(ip, 'verbose', true);
addParameter(ip, 'nSubcortex', []);
parse(ip, in, varargin{:});
in = ip.Results.in;
NS = ip.Results.nSubcortex;

% assert(ismatrix(in), "input must be a matrix");
% assert(size(in,1) == size(in,2), "input must be square");


%% Calculate number of subcortical parcels to remove
allowedN =      [68,    82,     200,    220,    360,    380,    500,    520]';
subCortLength = [0,     14,     0,      20,     0,      20,     0,      20]';

N = size(in,1);

if isempty(NS) % don't need to do calculations if user supplies nSubcortex
    assert(ismember(N, allowedN), "input not appropriate size");
    NS = subCortLength(allowedN == N); %N_subcortex
end

NC = N - NS; %N_cortex


%% Remove as indicated
if ip.Results.verbose && isempty(ip.Results.nSubcortex)
    if NS == 0
        warning("Using removeSubcortex function, no subcort found, no changes made");
    else
        warning("Using removeSubcortex function, needs close attention");
    end
end

edgesKept = false(size(in));

toBeKept = [(1:NC/2), (NC/2+NS/2+1):(NC+NS/2)];
edgesKept(toBeKept, toBeKept) = true;
out = reshape(in(edgesKept), NC, NC);

end