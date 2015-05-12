classdef SplineCurve
    
    properties (Access = private)
        degree
        knots
        xCoefficients
        yCoefficients
    end
    
    methods
        function obj = SplineCurve(degree, knots, xCoefficients, yCoefficients)
            obj.degree = degree;
            obj.knots = knots;
            obj.xCoefficients = xCoefficients;
            obj.yCoefficients = yCoefficients;
        end
        
        function [f, mu] = evaluate(obj, x, startMu)
            f = zeros(1, 2);
            p = obj.degree;
            
            mu = findMu(obj.knots, x, startMu);
            
            bSplines = alg221(p, obj.knots, mu, x);
            
            cx = obj.xCoefficients(mu-p : mu, :);
            cy = obj.yCoefficients(mu-p : mu, :);
            
            f(1) = sum(bSplines .* cx);
            f(2) = sum(bSplines .* cy);
        end
        
        function f = generatePoints(obj, numPoints)
            f = zeros(numPoints, 2);
            
            xBegin = obj.knots(1);
            xEnd = obj.knots(end);
            xRange = linspace(xBegin, xEnd, numPoints + 1);
            
            startMu = 1;
            
            for i = 1 : numPoints
                x = xRange(i);
                [f(i,:), startMu] = evaluate(obj, x, startMu);
            end
        end
    end
end
