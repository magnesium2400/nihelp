function varargout = separatePatches(data, varargin)
%% SEPARATEPATCHES Separates verts and faces into two distinct patches
%% Examples
%   [v,f] = sphereMesh; [v1,f1,v2,f2]=separatePatches(v,f); p=@(a,b) patch('Vertices',a,'Faces',b,'FaceColor','none'); figure; p(v1,f1); hold on; p(v2,f2); 
%   [v,f] = torusMesh; [v1,f1,v2,f2]=separatePatches(v,f,[],'SeparatingFunction',@(x) x(:,1).^2+x(:,2).^2<2); p=@(a,b,c) patch('Vertices',a,'Faces',b,'FaceColor',c); figure; p(v1,f1,'blue'); p(v2,f2,'red'); 
%   [v,f] = sphereMesh; r=randi(2,size(v(:,1))); [v1,f1,v2,f2]=separatePatches(v,f,r,r<2); p=@(a,b,c) patch('Vertices',a,'Faces',b,'FaceColor',c); figure; nexttile; p(v1,f1,'blue'); nexttile; p(v2,f2,'red'); 
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


%   Inputs: any of:
%           - a struct that contains vertices, and potentially faces and
%           rois; OR
%           - a v*3 matrix of vertices only; OR
%           - a v*3 matrix of vertices and an f*3 matrix of faces; OR
%           - a v*3 matrix of vertices, an f*3 matrix of faces, and a v*1
%           vector of roi allocations
%           Optionally:
%           - 'SeparatingFunction', a function handle to a function that is 
%            used to separate thesets of vertices
%           - 'SeparatingData', the data that `SeparatingFunction` should act
%           one ('verts', 'faces', or 'rois')
%   Outputs: depends on the number of outputs requested
%           2. two structs containing vertices and faces, and potentially
%           rois
%           4. verts1, faces1, verts2, faces2
%           6. verts1, faces1, rois1, verts2, faces2, rois2

%% Prelims
ip = inputParser;
addRequired(ip, 'verts');
addOptional(ip, 'faces', []);
addOptional(ip, 'rois', []);
addOptional(ip, 'SeparatingFunction', @(x) x(:, 1) < 0, @(x) islogical(x) || isnumeric(x) || isa(x,'function_handle'));
addParameter(ip, 'SeparatingData', 'verts', @(x) isStringScalar(x) || ischar(x));
parse(ip, data, varargin{:});

% parse inputs based on whether first input is a struct
if (class(ip.Results.verts) == "struct")
    verts = ip.Results.verts.vertices;
    faces = getFieldIfPresent(ip.Results.verts, 'faces');
    rois = getFieldIfPresent(ip.Results.verts, 'rois');
else % otherwise, first input is the verts
    verts = ip.Results.verts;
    faces = ip.Results.faces;
    rois = ip.Results.rois;
end

sf = ip.Results.SeparatingFunction;
sd = ip.Results.SeparatingData;


%% Calculations
% check verts
if isa(sf, 'function_handle')
    dataFor1 = logical(sf(getfield(ip.Results, sd)));
else
    dataFor1 = logical(sf); 
end

% separate verts and faces
if ~isempty(faces)
    [verts1, faces1] = surfKeepCortex(verts, faces, dataFor1);
    [verts2, faces2] = surfKeepCortex(verts, faces, ~dataFor1);
else
    verts1 = verts(dataFor1, :);
    verts2 = verts(~dataFor1, :);
    faces1 = [];
    faces2 = [];
end

% separate rois
if ~isempty(rois)
    rois1 = rois(dataFor1);
    rois2 = rois(~dataFor1);
else
    rois1 = [];
    rois2 = [];
end


%% Output
if nargout <= 2
    varargout{1} = struct('vertices', verts1, 'faces', faces1, 'rois', rois1);
    varargout{2} = struct('vertices', verts2, 'faces', faces2, 'rois', rois2);
elseif nargout <= 4
    varargout{1} = verts1;
    varargout{2} = faces1;
    varargout{3} = verts2;
    varargout{4} = faces2;
elseif nargout <= 6
    varargout{1} = verts1;
    varargout{2} = faces1;
    varargout{3} = rois1;
    varargout{4} = verts2;
    varargout{5} = faces2;
    varargout{6} = rois2;
end


end