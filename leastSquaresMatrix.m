function A = leastSquaresMatrix(tau, p, x, weights)

dataPoints = length(x);
A = zeros(dataPoints, p+1);

mu = 1;

for i=1 : dataPoints
    mu = findMu(tau, x(i), mu);
    b = alg221(p, tau, mu, x(i));

    A(i, mu-p:mu) = sqrt(weights(i)) .* b;
end

end
