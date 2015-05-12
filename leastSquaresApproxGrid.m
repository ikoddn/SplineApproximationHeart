function C = leastSquaresApproxGrid(uInput, vInput, output, weights, uKnots, vKnots, degree)

n1 = length(uKnots) - degree - 1;
n2 = length(vKnots) - degree - 1;
m2 = length(vInput);

D_transpose = zeros(m2, n1);
C = zeros(n1, n2);

for j = 1 : m2
    jWeights = weights(:,j);
    A = leastSquaresMatrix(uKnots, degree, uInput, jWeights);
    A_T = transpose(A);
    N = A_T * A;
    
    D_transpose(j,:) = N\(A_T * output(:,j));
end

for i = 1 : n1
    iWeights = weights(i,:);
    A = leastSquaresMatrix(vKnots, degree, vInput, iWeights);
    A_T = transpose(A);
    N = A_T * A;
    
    C(i,:) = N\(A_T * D_transpose(:,i));
end

end
