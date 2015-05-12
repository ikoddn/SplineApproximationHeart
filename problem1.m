function problem1(knotVectorLengthPercent)

degree = 3;
samplingPoints = 40;

[xValues, yValues, zValues] = splineCurveApproxHeart(degree, samplingPoints, knotVectorLengthPercent);
[~, crossSections] = size(xValues);

figure
view(3);
hold on

for i = 1 : crossSections
    plot3(xValues(:,i), yValues(:,i), zValues(:,i));
end

hold off

end
