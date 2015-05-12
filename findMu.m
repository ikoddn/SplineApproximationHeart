function mu = findMu(knots, x, startMu)
%FINDMU - Finds mu such that t_{mu} <= x < t_{mu+1} holds
%   knots - The knot vector t_1, t_2, ..., t_{n+p+1}
%   x - A real number in the interval [t_1, t_{n+p+1})
%   startMu - Optional start mu value. Sets the start index when
%   searching through the knot vector.

startIndex = 1;
endIndex = length(knots) - 1;

if exist('startMu', 'var')
    startIndex = startMu;
end

for j = startIndex : endIndex
    if x >= knots(j) && x < knots(j + 1)
        mu = j;
        break;
    end
end

if x == knots(end)
    while x == knots(j)
        j = j - 1;
    end

    mu = j;
end
