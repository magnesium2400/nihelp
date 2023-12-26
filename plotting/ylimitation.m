function ylimitation(varargin)
%% YLIMITATION change ylim, only if new limits are not within current limits
% Inputs: axis handle (optional) - otherwise defaults to gca
%         either: (i) two element vector of the form [ymin ymax]; or
%                 (ii) one or both of the name-value arguments 'min' and 'max'
% 
% YLIMITATION might change the ylimits of the axis specified. If a maximum
% ylim is input (from either of the input sytaxes), and this limit is
% greater than the current ymax, the limit will be updated. A similar
% principle applies for the minimum.
%
% As an example: if the current ylims are [-1, 1], and you write
% `ylimitation([-0.5, 2])`, the upper ylim will be updated, but not the
% lower one i.e. the limits will be changed to expand the visible area
% only.

limitation(varargin{:}, 'func', @ylim);

end



