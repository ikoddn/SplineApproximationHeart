function knots = generateUniformKnots(min, max, n, p)
%GENERATEUNIFORMKNOTS Generates a p+1 regular knot vector with uniform
%internal knots.
%   min - Value for the p+1 first knots
%   max - Value for the p+1 last knots
%   n - Number of knots total
%   p - Degree

knots = zeros(n, 1);

knots(1 : p) = min;
knots(p+1 : n-p) = linspace(min, max, n-2*p);
knots(n-p+1 : n) = max;

end
