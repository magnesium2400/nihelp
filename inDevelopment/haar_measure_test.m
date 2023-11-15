%close all;
%haar measure test
eig_vals=[];
seps=[];
d=100;
for i=1:5000
    Q = makeRandomRotationMatrix2(d, 1);
    [C,D]=eig(Q);
    JJ=diag(D);
    gg=real(-1j*log(JJ));
    eig_vals=[eig_vals; gg];
    yy=sort(gg);
    seps=[seps; (d-1)/(2*pi)*abs(yy(2:end)-yy(1:end-1))];
end
figure;
histogram(eig_vals,20,'Normalization','pdf')
figure;
histogram(seps,20,'Normalization','pdf')