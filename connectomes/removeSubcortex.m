function [out, edgesKept] = removeSubcortex(inp, varargin)
%% REMOVESUBCORTEX removes subcortex with MANY implicit assumptions
%% Usage Notes
% SPECIFY TOTAL NUMBER OF DATA POINTS IN MATRIX (**NOT** NUMBER IN ONE HEMISPHERE) 
% 
%   if inp == 68*68, assume Desikan Killiany and do nothing
%   if inp == 82*82, assume Desikan Killiany and remove 35-42 and 75-82
%   if inp == 200*200, assume Schaefer and do nothing
%   if inp == 220*220, assume Schaefer and remove 101-110 and 211-220
%   if inp == 360*360, assume Glasser and do nothing
%   if inp == 380*380, assume Glasser and remove 181-190 and 351-360
%   if inp == 500*500, assume Schaefer and do nothing
%   if inp == 520*520, assume Schaefer and remove 251-260 and 511-520
%% Authors
% Mehul Gajwani, Monash University, 2024
%
%
%% ENDPUBLISH


%% Prelims
ip = inputParser;
addRequired( ip, 'inp', @(x) ( isnumeric(x) && (size(x,1)==size(x,2)) ) );
addParameter(ip, 'verbose', true);
addParameter(ip, 'nSubcortex', []);
parse(ip, inp, varargin{:});
inp = ip.Results.inp;
NS = ip.Results.nSubcortex;


%% Calculate number of subcortical parcels to remove
allowedN =      [68, 82, 360, 380, (100:100:1000), 998, (100:100:1000)+20, 998+20].';
subCortLength = [0,  14,   0,  20,         zeros(1,11),             ones(1,11)*20].';
% allowedN =      [68,    82,     200,    220,    360,    380,    500,    520]';
% subCortLength = [0,     14,     0,      20,     0,      20,     0,      20]';

N = size(inp,1);

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

edgesKept = false(size(inp));

toBeKept = [(1:NC/2), (NC/2+NS/2+1):(NC+NS/2)];
edgesKept(toBeKept, toBeKept) = true;
out = reshape(inp(edgesKept), NC, NC);

end