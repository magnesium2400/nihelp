function counter = dispCounter(frequency, name)

if nargin < 1; frequency = 100; end
if nargin < 2; name = 'ii'; end

counter = evalin('base', name);
if mod(counter, frequency) == 1; disp(counter); end

end

