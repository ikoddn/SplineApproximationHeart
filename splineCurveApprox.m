function fValues = splineCurveApprox(data, weights, degree, samplingPoints, knotVectorLengthPercent)

u = cordLengthParametrisation(0, data);

[dataPoints, ~] = size(data);
nKnots = ceil(dataPoints * (knotVectorLengthPercent/100));
knots = generateUniformKnots(u(1), u(end), nKnots, degree);

A = leastSquaresMatrix(knots, degree, u, weights);
A_T = transpose(A);
N = A_T * A;

cx = N\(A_T * data(:,1));
cy = N\(A_T * data(:,2));

f = SplineCurve(degree, knots, cx, cy);

fValues = generatePoints(f, samplingPoints);

end
