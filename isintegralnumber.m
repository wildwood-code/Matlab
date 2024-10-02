function b = isintegralnumber(x)

if isfloat(x) && ~isempty(x) && isfinite(x) && ~isnan(x) && floor(x)==x
    b = true;
else
    b = false;
end

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net