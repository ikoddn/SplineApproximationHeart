classdef SplineSurface
    
    properties (Access = private)
        degree
        uKnots
        vKnots
        xCoefficients
        yCoefficients
        zCoefficients
    end
    
    methods
        function obj = SplineSurface(degree, uKnots, vKnots, xCoefficients, yCoefficients, zCoefficients)
            obj.degree = degree;
            obj.uKnots = uKnots;
            obj.vKnots = vKnots;
            obj.xCoefficients = xCoefficients;
            obj.yCoefficients = yCoefficients;
            obj.zCoefficients = zCoefficients;
        end
        
        function [g, uMu, vMu] = evaluate(obj, x, y, uStartMu, vStartMu)
            g = zeros(1, 3);
            p = obj.degree;
            
            uMu = findMu(obj.uKnots, x, uStartMu);
            vMu = findMu(obj.vKnots, y, vStartMu);
            
            uBSplines = alg221(p, obj.uKnots, uMu, x);
            vBSplines = alg221(p, obj.vKnots, vMu, y);
            
            cx = obj.xCoefficients(uMu-p : uMu, vMu-p : vMu);
            cy = obj.yCoefficients(uMu-p : uMu, vMu-p : vMu);
            cz = obj.zCoefficients(uMu-p : uMu, vMu-p : vMu);
            
            for r = 1 : length(vBSplines)
                g(1) = g(1) + sum(cx(:,r) .* uBSplines * vBSplines(r));
                g(2) = g(2) + sum(cy(:,r) .* uBSplines * vBSplines(r));
                g(3) = g(3) + sum(cz(:,r) .* uBSplines * vBSplines(r));
            end
        end
        
        function [gx, gy, gz] = generatePoints(obj, uNumPoints, vNumPoints)
            gx = zeros(uNumPoints, vNumPoints);
            gy = zeros(uNumPoints, vNumPoints);
            gz = zeros(uNumPoints, vNumPoints);
            
            xBegin = obj.uKnots(1);
            xEnd = obj.uKnots(end);
            xRange = linspace(xBegin, xEnd, uNumPoints + 1);
            
            yBegin = obj.vKnots(1);
            yEnd = obj.vKnots(end);
            yRange = linspace(yBegin, yEnd, vNumPoints + 1);
            
            uStartMu = 1;
            
            for i = 1 : uNumPoints
                x = xRange(i);
                vStartMu = 1;
                
                for j = 1 : vNumPoints
                    y = yRange(j);
                    
                    [gxyz, uStartMu, vStartMu] = evaluate(obj, x, y, uStartMu, vStartMu);
                    
                    gx(i,j) = gxyz(1);
                    gy(i,j) = gxyz(2);
                    gz(i,j) = gxyz(3);
                end
            end
        end
    end
end
