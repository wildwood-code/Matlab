function y = interpolate(x, x1, y1, x2, y2, type)
% INTERPOLATE  interpolate between two ordered pairs using ling/logx/logy scaling
%   y = INTERPOLATE(x, x1, y1, x2, y2, type)
%
%   x1, y1, x2, y2 are scalars
%   x may be a scalar or vector
%
%   type:
%     'lin'  linear x and y
%     'logx' x is logarithmic, y is linear
%     'logy' y is logarithmic, x is linear
%     'log'  x and y are logarithmic
%
%   if x or any of the ordered pairs (x1, y1), (x2, y2) are NaN then the
%   result will be NaN

% Kerry S. Martin, martin@wild-wood.net

narginchk(5,6)
    if nargin<6
        type = 'lin';
    else
        type = lower(type);
    end
    if isnan(x) || isnan(x1) || isnan(x2) || isnan(y1) || isnan(y2)
        y = NaN(size(x));
    else
        % adjust input params for interpolation type
        switch type               
            case 'logx'
                x1 = log(x1);
                x2 = log(x2);
                x  = log(x);
            case 'logy'
                y1 = log(y1);
                y2 = log(y2);
            case 'log'
                x1 = log(x1);
                x2 = log(x2);
                x  = log(x);
                y1 = log(y1);
                y2 = log(y2);
            case 'lin'
                % no adjustment
            otherwise
                warning('unrecognized type: using ''lin''')
        end
        
        % do a linear interpolation on the adjusted parameters
        y = y1 + (y2-y1).*(x-x1)./(x2-x1);
        
        % adjust output value for interpolation type if needed
        switch type
            case {'logy', 'log'}
                y = exp(y);
            otherwise % no adjustment
        end
                
    end
end

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net