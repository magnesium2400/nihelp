function [s1,s2] = imagesc2(Clower, Cupper, varargin)
%% IMAGESC2 Plots two matrices with a gap, similar to IMAGESC (upper and lower triangles)
%% Syntax
%  imagesc2(Clower, Cupper); 
%  imagesc2(Clower, Cupper, offset); 
%  imagesc2(ax, ___); 
%  
%  
%% Examples
%   figure; imagesc2(1./pascal(5), hilb(5)        ); 
%   figure; imagesc2(1./pascal(5), hilb(5),  1    ); 
%   figure; imagesc2(1./pascal(5), hilb(5),  2    ); 
%   figure; imagesc2(1./pascal(5), hilb(5), [2 0] ); 
%   figure; imagesc2(1./pascal(5), hilb(5), [2 -1]); 
%
%

%% Prelims
[ax, args, nargs] = axescheck(Clower, Cupper, varargin{:}); 
if isempty(ax); ax = gca(); end

% Required args
Clower = args{1}; 
Cupper = args{2}; 
if ~allclosen(Clower,Clower');          warning('First matrix is not symmetric');   end
if ~allclosen(Cupper,Cupper');          warning('Second matrix is not symmetric');  end
if ~all(size(Clower)==size(Cupper));    warning('Matrices are not the same size');  end

% Optional (offset)
if nargs < 3 || isempty(args{3}); offset = 0; 
else; offset = args{3}; end


%% Plot
s1 = surfsc(Clower, 'mask', tril(true(size(Clower)),-1), 'XData', 1-offset(1));
hold on; 
s2 = surfsc(Cupper, 'mask', triu(true(size(Cupper)),+1), 'YData', 1-offset(end));
set(ax, 'YDir', 'reverse', 'View', [0 90], 'Layer', 'bottom'); 

end

