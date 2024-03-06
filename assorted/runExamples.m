function [examples, docstringText] = runExamples(file, verbosity)
%% RUNEXAMPLES Run code examples from a "%% Examples" block in h1 comment
%% Examples
%   runExamples('minmax');
%   runExamples('minmax',1);
%   runExamples('minmax',2);
% 
% 
%% TODO
% * docs
% 
% 
%% Authors
% Mehul Gajwani, Monash University, 2024
% 
% 


if nargin < 2; verbosity = 0; end

%% Parse text from first comment
filetext = readlines(which(file));

commented = cellfun(@(x) ~isempty(x) && ~isempty(regexp(x, '^\s*%', 'once')), filetext);
commentStart = find(commented, 1);
commentEnd = find(~commented(commentStart:end),1)+commentStart-2;

docstringText = filetext(commentStart:commentEnd);


%% Parse "%% Examples" section
removeEmpty = @(x) ~cellfun('isempty', x);

examplesStart = removeEmpty( regexpi(docstringText, "^%% Examples?") );
examplesStart = find(examplesStart, 1); 
if isempty(examplesStart); warning('No examples found'); return; end

h1 = removeEmpty( regexp(docstringText, "^%%\s+[^%]") );
examplesEnd = find(h1(examplesStart+1:end), 1) + examplesStart - 1;
if isempty(examplesEnd); examplesEnd = length(docstringText); end

examples = docstringText(examplesStart+1:examplesEnd);
% ensure there are 3 spaces (2 spaces are pseudocode) 
validExamples = find( removeEmpty( regexpi(examples, "^%   [^\s\%]") ) ).';

if verbosity > 0
    fprintf('%i lines of "%% Examples" text found\n', length(examples));
    fprintf('%i valid examples found\nNow running', length(validExamples)); 
    cleanupObj = onCleanup(@() fprintf('\n')); 
end


%% Run examples
for ii = validExamples
    if verbosity == 1; fprintf('.'); 
    elseif verbosity >= 2; fprintf('\n  >> %s', extractAfter(examples{ii}, 4)); end
    eval( extractAfter(examples{ii}, 4) ); 
end


end
