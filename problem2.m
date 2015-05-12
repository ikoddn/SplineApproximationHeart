function problem2()

degree = 3;
samplingPoints = 20;
knotVectorLengthPercent = 20;
uGridSize = 30;
vGridSize = 30;

[xValues, yValues, zValues] = splineCurveApproxHeart(degree, samplingPoints, knotVectorLengthPercent);
[~, crossSections] = size(xValues);

u = linspace(0, 1, samplingPoints);
v = linspace(0, 1, crossSections);

uKnots = generateUniformKnots(u(1), u(end), 15, degree);
vKnots = generateUniformKnots(v(1), v(end), 9, degree);

uWeights = ones(samplingPoints, 1);
vWeights = ones(crossSections, 1);
weights = uWeights * vWeights';

Cx = leastSquaresApproxGrid(u, v, xValues, weights, uKnots, vKnots, degree);
Cy = leastSquaresApproxGrid(u, v, yValues, weights, uKnots, vKnots, degree);
Cz = leastSquaresApproxGrid(u, v, zValues, weights, uKnots, vKnots, degree);

g = SplineSurface(degree, uKnots, vKnots, Cx, Cy, Cz);

[gx, gy, gz] = generatePoints(g, uGridSize, vGridSize);
gx = [gx; gx(1,:)];
gy = [gy; gy(1,:)];
gz = [gz; gz(1,:)];

surf(gx, gy, gz);

end
