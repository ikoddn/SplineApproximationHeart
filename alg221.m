function b = alg221(p, t, mu, x)
%ALG221 - Algorithm 2.21/2.22
%   p - Polynomial degree
%   t - Knot vector t_{mu-p+1}, ..., t_{mu+p}
%   x - A real number in [t_{mu}, t_{mu+1})

b = 1;

for k = 1 : p
    t1 = t(mu-k+1 : mu);
    t2 = t(mu+1 : mu+k);
    
    w = (x - t1) ./ (t2 - t1);
    b1 = [(1 - w) .* b; 0];
    b2 = [0; w .* b];
    b = b1 + b2;
end
