function b = isintegralnumber(x)

if isfloat(x) && ~isempty(x) && isfinite(x) && ~isnan(x) && floor(x)==x
    b = true;
else
    b = false;
end