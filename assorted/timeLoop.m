function timeLoop(nmax, varName, doTiming)
%% Examples
%   for ii = 1:50; pause(0.1); timeLoop(50); end
%   for jj = 1:50; pause(0.1); timeLoop(50, 'jj'); end
%
%


% TO DO: what if loop is not from 1 to n? starts at different value?
% different/irregular increment?

if nargin < 1; error('specify num iterations'); end
if nargin < 2; varName = 'ii'; end
if nargin < 3; doTiming = true; end

% Get counter from caller workspace
if isnumeric(varName); counter = varName; 
elseif isStringScalar(varName) || ischar(varName); counter = evalin('caller', varName);
else; error('varname must be string/char/numeric'); 
end

% Create timer if requested
if doTiming
    if counter==1;  timetaken = 0; evalin('caller', 'timeLoopTimer=tic;'); 
    else;           timetaken = evalin('caller', 'toc(timeLoopTimer)')*counter/(counter-1); end
    timeleft = timetaken * (nmax-counter)/counter;
end

% Create output string
n = strlength(string(nmax)); 
out = sprintf("%"+n+"i/%"+n+"i", counter, nmax);

% Add timing if requested
if doTiming
    out = sprintf('%s: %s remaining (%s taken)', ...
        out, string(duration(0,0,timeleft)), string(duration(0,0,timetaken))); 
end

% Add newline and backspaces
out = out + "\n"; 
if counter ~= 1
    % Number of backspaces reduced by 1 due to newline? 
    % '\n' rendered as one character?
    out = sprintf('%s%s', repmat('\b', 1, strlength(out)-1), out); 
end

fprintf(out); 
if counter==nmax; evalin('caller', 'clear("timeLoopTimer");'); end

end
