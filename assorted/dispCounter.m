function counter = dispCounter(frequency, name, doTiming)
%% DISPCOUNTER Repeatedly prints value of an indexing variable in a loop
%% Examples
%   for ii = 1:1000; dispCounter; end
%   for ii = 1:1000; dispCounter(200); end
%   for jj = 1:1000; dispCounter(200, 'jj'); end
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


if nargin < 1; frequency = 100; end
if nargin < 2; name = 'ii'; end
if nargin < 3; doTiming = false; end

counter = evalin('caller', name);

if counter==1 && doTiming
    evalin('caller', 'dispCounterTimer=tic;');
end

if mod(counter, frequency) == 1
    fprintf("%f\n", counter);
    if doTiming; evalin('caller', 'toc(dispCounterTimer)'); end
end

end

