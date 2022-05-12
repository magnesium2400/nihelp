function same_axes()
%% SAME_AXES sets x-axis and y-axis limits to be the same
v = axis; % get current values
lo = min( v(1:2:end) ); % lower limit
up = max( v(2:2:end) ); % uppper limit
axis( [lo up lo up] );
end

