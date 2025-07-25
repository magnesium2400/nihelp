function [vertex,face] = read_vtk(filename)
%% READ_VTK Read data from VTK file.
%% Syntax
%  [vertex,face] = read_vtk(filename)
% 
% 
%% Output Arguments
% `vertex - 3-column matrix specifying the position of the vertices (numeric
% array)`
% 
% `face - 3-column matrix specifying the triangulation of the mesh (numeric
% array)`
%  
%  
%  
%% TODO
% * docs
% 
% 
%% Authors
% Copyright (c) Mario Richtsfeld
% 
% 



fid = fopen(filename,'r');
if( fid==-1 )
    error('Can''t open the file.');
end

str = fgets(fid);   % -1 if eof
if ~strcmp(str(3:5), 'vtk')
    error('The file is not a valid VTK one.');    
end

%%% read header %%%
str = fgets(fid); %#ok<NASGU>
str = fgets(fid); %#ok<NASGU>
str = fgets(fid); %#ok<NASGU>
str = fgets(fid);
nvert = sscanf(str,'%*s %d %*s', 1);

% read vertices
[A,cnt] = fscanf(fid,'%f %f %f', 3*nvert);
if cnt~=3*nvert
    warning('Problem in reading vertices.');
end
A = reshape(A, 3, cnt/3);
vertex = A;

% read polygons
str = fgets(fid); %#ok<NASGU>
str = fgets(fid); 

info = sscanf(str,'%c %*s %*s', 1);

if((info ~= 'P') && (info ~= 'V'))
    str = fgets(fid);    
    info = sscanf(str,'%c %*s %*s', 1);
end

if(info == 'P')
    
    nface = sscanf(str,'%*s %d %*s', 1); %#ok<NASGU>
    npoint = sscanf(str,'%*s %*s %d', 2);

    [A,cnt] = fscanf(fid, '%d ', npoint);
    ndim = A(1);
    if cnt~=npoint
        warning('Problem in reading faces.');
    end

    if all(A(1:(ndim+1):end) == ndim)
        A = reshape(A, ndim+1, []);
        face = A(2:end,:)+1;
    else
        B = {};
        while ~isempty(A)
            B{end+1} = A(2:(A(1)+1))+1; %#ok<AGROW>
            A(1:(A(1)+1)) = [];
        end
        face = B;
    end


    % [A,cnt] = fscanf(fid,'%d %d %d %d\n', 4*nface);
    % if cnt~=4*nface
    %     warning('Problem in reading faces.');
    % end
    % 
    % A = reshape(A, 4, cnt/4);
    % face = A(2:4,:)+1;
end

if(info ~= 'P')
    face = 0;
end

% read vertex ids
if(info == 'V')
    
    nv = sscanf(str,'%*s %d %*s', 1);

    [A,cnt] = fscanf(fid,'%d %d \n', 2*nv);
    if cnt~=2*nv
        warning('Problem in reading faces.');
    end

    A = reshape(A, 2, cnt/2);
    face = repmat(A(2,:)+1, 3, 1);
end

if((info ~= 'P') && (info ~= 'V'))
    face = 0;
end

fclose(fid);

return