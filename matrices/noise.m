function out = noise(type, opts)
%% NOISE Generates procedural noise
%% Examples
%   n = noise('powerlaw', struct('sz', 20, 'alpha', 1));
%   k=40; n=noise('powerlaw1', struct('sz', k, 'alpha', 4)); figure; imagesc(n); hold on; imagesc(k+1,1,n);                   xlim('tight'); ylim('tight');
%   k=40; n=noise('powerlaw2', struct('sz', k, 'alpha', 3)); figure; imagesc(n); hold on; imagesc(k+1,1,n); imagesc(1,k+1,n); xlim('tight'); ylim('tight');
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


switch type
    case 'powerlaw1'
        if isUnemptyField(opts, 'seed'); try rng(opts.seed); catch; end; end
        k = opts.sz(end); % numer of timepoints
        n = opts.sz(1); % number of independent samples
        m = randn(k,n);
        mf = fftshift(fft(m));
        a = opts.alpha; % 1/f exponent
        d = sqrt(((1:k).'-(k/2)-1).^2);
        filt = d .^ (-a/2); % frequency filter for 1D
        filt(isinf(filt))=1;
        ff = mf .* filt; % apply the filter
        v = ifft(ifftshift(ff)); % power-law noise vector
        vScaled = rescale(v,-1,1); % scaled power-law noise [-1,1]
        out = vScaled.';
    case 'powerlaw2'
        if isUnemptyField(opts, 'seed'); try rng(opts.seed); catch; end; end
        n = opts.sz;
        m = randn(n,n);
        mf = fftshift(fft2(m));
        a = opts.alpha; % 1/f exponent
        d = ((1:n)-(n/2)-1).^2;
        dd = sqrt(d(:) + d(:)');
        filt = dd .^ -a; % frequency filter
        filt(isinf(filt))=1; 
        ff = mf .* filt;
        out = rescale(ifft2(ifftshift(ff)), -1, 1);
    otherwise
        error('Please ensure noise type is correct'); 
end


end
