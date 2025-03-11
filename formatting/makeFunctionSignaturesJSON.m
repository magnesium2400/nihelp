function [fileout, json, s] = makeFunctionSignaturesJSON(varargin)
%% MAKEFUNCTIONSIGNATURESJSON Takes tsv file of function information and converts to MATLAB-suitable JSON
%% Examples
%   f = fileparts(which('makeFunctionSignaturesJSON')); makeFunctionSignaturesJSON(fullfile(f,'functionSignatures.tsv'),'outputDir',f);     
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2025
% 
% 


%% Prelims
ip = inputParser; 
ip.addOptional('filename', './functionSignatures.tsv',  @(x) ischar(x) || isStringScalar(x)); 
ip.addParameter('outputDir', [],                        @(x) ischar(x) || isStringScalar(x)); 

ip.parse(varargin{:}); 
filename    = ip.Results.filename; 
outputDir   = ip.Results.outputDir; 

[filepath, ~, ext] = fileparts(filename); 
if ~strcmp(ext, '.tsv'); warning("Expecting a tab-delimited file"); end

if isempty(outputDir); outputDir = filepath; end
fileout = fullfile(outputDir, 'functionSignatures.json'); 

% Use opts to (magically?) ensure that everything (in particular, empty
% columns) are imported as a string
T = readtable(filename, detectImportOptions(filename, 'FileType', 'text', 'Delimiter', '\t'));


%% Parse data
% Construct a struct array with a particular form
s = struct;
for ii = 1:height(T)
    f = T{ii,1}{1};
    d = T(ii,2:end);

    % Need to reformat data if the current `type` has a comma
    for jj = find(contains(table2cell(d),','))
        d{1,jj}{1} = split(d{1,jj}{1}, regexpPattern(',(?![^{]*\})')); 
    end

    d{1,strcmpi(table2cell(d) ,'false')} = {false}; 
    d{1,strcmpi(table2cell(d) ,'true')}  = {true}; 

    d = table2struct(d); 

    if isempty(f)
        s.(currentFunction).inputs = [s.(currentFunction).inputs, d];
    else
        s.(f) = struct;
        currentFunction = f;
        s.(currentFunction).inputs = d;
    end

end


%% Format and output
% Remove empty parameter values using regex
json = jsonencode(s,'PrettyPrint',true);
json = erase(json, regexpPattern(',\s*?"([^"]+)": ""'));

% Fix any functions with exactly one input add [] for list formatting)
openPos = flip(regexp(json, '"inputs": {')+10);
for o = openPos(:)'
    c = closingBracePos(json,o,1); 
    json = [json(1:o-1), '[', newline, '      {', json(o+1:c-1), '  }', newline, '    ]', json(c+1:end)]; 
end

% Use cu

% Output to file and validate
writelines(json, fileout); 
validateFunctionSignaturesJSON(fileout);


end


function n = closingBracePos(str, openingBracePos, braceCount)
for j = openingBracePos+1:length(str)
    if str(j) == '{'
        braceCount = braceCount + 1;
    elseif str(j) == '}'
        braceCount = braceCount - 1;
    end
    if braceCount == 0
        n = j;
        return;
    end
end
end







