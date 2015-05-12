function [xValues, yValues, zValues] = splineCurveApproxHeart(degree, samplingPoints, knotVectorLengthPercent)

dataFiles = {
    'data/hj1.dat'
    'data/hj2.dat'
    'data/hj3.dat'
    'data/hj4.dat'
    'data/hj5.dat'
    'data/hj6.dat'
    'data/hj7.dat'
    'data/hj8.dat'
    'data/hj9.dat'
};

crossSections = length(dataFiles);

xValues = zeros(samplingPoints, crossSections);
yValues = zeros(samplingPoints, crossSections);
zValues = zeros(samplingPoints, crossSections);

for i = 1 : crossSections
    data = dlmread(dataFiles{i});
    
    [dataPoints, ~] = size(data);
    weights = ones(dataPoints, 1);
    
    fValues = splineCurveApprox(data, weights, degree, samplingPoints-1, knotVectorLengthPercent);
    
    xValues(1:end-1,i) = fValues(:,1);
    yValues(1:end-1,i) = fValues(:,2);
    xValues(end,i) = fValues(1,1);
    yValues(end,i) = fValues(1,2);
    zValues(:,i) = repmat(data(1,3), samplingPoints, 1);
end

end
