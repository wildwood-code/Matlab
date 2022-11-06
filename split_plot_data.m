function [x,y] = split_plot_data(x,y)
% SPLIT_PLOT_DATA inserts NaN's to split discontinuous plot data
%    [x,y] = SPLIT_PLOT_DATA(x,y)
%
%    x,y may be column or row vectors, but must be of the same length
%
%    It is common to encounter data which is sampled in discontinuous
%    ranges of x data, for instance for EMI measurements which may be taken
%    in discontinuous bands.
%
%    When plotted directly, the splits will show up as a line connecting
%    across the discontinuity. It is desirable in these cases to show a gap
%    instead of a line. Inserting a NaN in between discontinuous ranges
%    will cause Matlab plots to show a gap.

% Kerry S. Martin, martin@wild-wood.net

narginchk(2,2);
nargoutchk(1,2);

if ~isrow(x) && ~iscolumn(x)
    error('x must be a row or column vector')
end
if ~isrow(y) && ~iscolumn(y)
    error('y must be a row or column vector')
end
if length(x) ~= length(y)
    error('x and y must be the same length')
end

n = length(x);

if n>=4
    dxx = x(2)-x(1);
    isplit = [];
    for i=2:n
        dx = x(i)-x(i-1);
        if dx>5*dxx
            isplit = [isplit i];
            i = i + 1;
            if i<=n
                dx = x(i)-x(i-1);
            end
        elseif dx==0
            i = i + 1;
            if i<=n
                dx = x(i) + x(i-1);
            end
        elseif dx<0
            error('x data must be increasing')
        end
        dxx = dx;    
    end
    if ~isempty(isplit)
        ixc = iscolumn(x);
        iyc = iscolumn(y);
        for j=1:length(isplit)
            i = isplit(j)+j-1;
            if ixc
                x = [x(1:i-1) ; NaN ; x(i:end)];
            else
                x = [x(1:i-1) , NaN , x(i:end)];
            end
            if iyc
                y = [y(1:i-1) ; NaN ; y(i:end)];
            else
                y = [y(1:i-1) , NaN , y(i:end)];
            end
        end
    end
end