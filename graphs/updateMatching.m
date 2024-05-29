function [a, m, n, d] = updateMatching(a, m, n, d, ii, jj)

if nargin == 1
    assert(isequal(a', double(logical(a)))); % check that a is symmetric and the correct type
    n = 2*a*a; 
    n(1:(length(a)+1):end) = 0;
    temp = sum(a,1); 
    d = temp + temp' - 2*a;
    m = n ./ (d + ~n);
    return
end

a(ii, jj) = 1;
a(jj, ii) = 1;

temp1 = n(:,ii) + a(:,jj)*2;
temp2 = n(:,jj) + a(:,ii)*2;
% [n(:,ii), n(ii,:), n(:,jj), n(jj,:), n(ii,ii), n(jj,jj)] = deal(temp1, temp1', temp2, temp2', 0, 0); 
n(:,ii) = temp1;
n(ii,:) = temp1;
n(:,jj) = temp2;
n(jj,:) = temp2;
n(ii,ii) = 0;
n(jj,jj) = 0;

temp = d(:,[ii,jj])+1;
% [d(:,[ii,jj]), d([ii,jj],:)] = deal(temp, temp'); 
d(:,[ii,jj]) = temp;
d([ii,jj],:) = temp';
d(ii,jj) = d(ii,jj) - 1;
d(jj,ii) = d(jj,ii) - 1;
d(ii,ii) = d(ii,ii) + 1;
d(jj,jj) = d(jj,jj) + 1;

m(:,[ii,jj]) = n(:,[ii,jj])./(d(:,[ii,jj]));
m([ii,jj],:) = n([ii,jj],:)./(d([ii,jj],:));

end
