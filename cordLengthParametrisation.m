function u = cordLengthParametrisation(startValue, data)

[dataPoints, ~] = size(data);
u = zeros(dataPoints, 1);
u(1) = startValue;

for i = 2 : dataPoints
    u(i) = u(i-1) + norm(data(i,:) - data(i-1,:));
end

end
