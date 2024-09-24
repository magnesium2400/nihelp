function tl = corrplot2(A, B)
%% CORRPLOT2 Plot correlations between columns in two matrices
%% Examples
%   figure; corrplot2(gallery('integerdata',99,[99,4],1)-(0:25:75),(1:99)'-[50,0]); 
%   figure; corrplot2(sort(gallery('integerdata',99,[99,5],1)),sort(gallery('integerdata',99,[99,6],1))); 
%   figure; corrplot2(sort(gallery('integerdata',99,[99,5],1))-(0:25:100),sort(gallery('integerdata',99,[99,6],1))-(0:20:100)); 
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

tl = colplot2(A,B,@(x,y) scatter(x,y,[],(1:numel(x))','.')); 
if exist('tern', 'file')
    tlfunc(tl, @(r,c) tern(r~=1,        @() yticks([]), 1)  , 'subscript');
    tlfunc(tl, @(r,c) tern(c~=width(A), @() xticks([]), 1)  , 'subscript');
end

% % % % % assert(height(A) == height(B)); 
% % % % % 
% % % % % m = width(A); 
% % % % % n = width(B); 
% % % % % 
% % % % % tl =  tiledlayout(m,n); 
% % % % % 
% % % % % for ii = 1:m
% % % % %     for jj = 1:n
% % % % %         nexttile(); 
% % % % %         scatter(B(:,jj), A(:,ii), [], 1:height(A), '.');
% % % % %         % lsline; 
% % % % %         if ii ~= m; xticks([]); end
% % % % %         if jj ~= 1; yticks([]); end
% % % % %     end
% % % % % end
% % % % % 
% % % % % 
% % % % % end


