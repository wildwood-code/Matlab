function [xout, above, below] = split_above_below(x, data, limit)

% sanity check
narginchk(2,3)
if nargin<3
    limit = 0;
end
if ~isvector(x) || ~isreal(x) || ~isfloat(x)
    error('x must be a real vector')
end
N = length(x);
% check isvector data
if ~isvector(data) || ~isreal(data) || ~isfloat(data) || length(data)~=N
    error('data must be a real vector matching the length of x')
end

% preallocate, though these may actually grow
above = NaN(N,1);
below = NaN(N,1);
xout = NaN(N,1);

j = 1; % index into destination vectors

% track the last state
was_above = false;
xlast = NaN;
dlast = NaN;

% main loop
for i=1:N
    xx = x(i);
    dd = data(i);
    
    if isnan(xx) || isnan(dd)
        xout(j) = NaN;
        above(j) = NaN;
        below(j) = NaN;
        % was_above is unchanged
        j = j + 1;
    elseif dd<limit
        if was_above && dlast>limit
            % add an interpolated point
            [xi, di] = intp(limit, xlast, dlast, xx, dd);
            xout(j) = xi;
            above(j) = di;
            below(j) = di;
            xout(j+1) = xx;
            above(j+1) = NaN;
            below(j+1) = dd;
            j = j + 2;
        else
            xout(j) = xx;
            above(j) = NaN;
            below(j) = dd;
            j = j + 1;
        end
        was_above = false;
    elseif dd>limit
        if ~was_above && dlast<limit
            % add an interpolated point
            [xi, di] = intp(limit, xlast, dlast, xx, dd);
            xout(j) = xi;
            above(j) = di;
            below(j) = di;
            xout(j+1) = xx;
            above(j+1) = dd;
            below(j+1) = NaN;
            j = j + 2;
        else
            xout(j) = xx;
            above(j) = dd;
            below(j) = NaN;
            j = j + 1;
        end
        was_above = true;
    else % dd==limit
        xout(j+1) = xx;
        if was_above
            above(j+1) = dd;
            below(j+1) = NaN;
        else
            above(j+1) = NaN;
            below(j+1) = dd;
        end
        % was_above is unchanged
        j = j + 1;
    end
    
    xlast = xx;
    dlast = dd;
end

end % main function


function [xi, yi] = intp(limit, x1, y1, x2, y2, type)
nargoutchk(2,2)
narginchk(5,6)
if nargin<6
    type = 'lin';
end
if isnan(x1) || isnan(x2) || isnan(y1) || isnan(y2)
    xi = NaN;
    yi = NaN;
else
    % adjust input params for interpolation type
    switch type
        case 'logx'
            x1 = log(x1);
            x2 = log(x2);
        case 'logy'
            y1 = log(y1);
            y2 = log(y2);
            limit = log(limit);
        otherwise % no adjustment
    end
    
    % do a linear interpolation on the adjusted parameters
    xi = (limit*(x2 - x1) + x1*y2 - x2*y1)/(y2 - y1);
    yi = limit;
    
    % adjust output value for interpolation type if needed
    switch type
        case 'logx'
            xi = exp(xi);
        case 'logy'
            yi = exp(yi);
        otherwise % no adjustment
    end
    
end

end

