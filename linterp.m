function yi = linterp(x,y,xi,scaling,enable_checks)
% LINTERP  Linear (or log) interpolation of a set of data
%
%   yi = LINTERP(x, y, xi, scaling, enable_checks)
%
%   Arguments:
%     x       = x data (must be vector)
%     y       = y data (must be vector)
%     xi      = x interpolation points
%     scaling = type of data scaling {optional, see below)
%     enable_checks = flag to enable (true) or disable (false, default)
%                     checking of arguments: disable to improve performance
%
%   Output:
%     yi  = y interpolated at all xi
%
%   Notes:
%     The x and xi vectors must be sorted or unpredictable results may occur.
%     The x and y vectors must be sized identically, and must be either row
%     or column vectors.
%     The values in xi must be within the bounds of the data in xi
%
%     Scaling: char vector or string denoting x-y scaling
%       lin, linlin, '' {default}
%       log, loglog
%       loglin, semilogx
%       linlog, semilogy
%

narginchk(3,5)
if nargin<4
    % default parameters if not specified
    scaling = 'lin';
    enable_checks = false;
elseif nargin==4
    % determine if scaling (char/string) or enable_checks (logical)
    % and default the one that is not
    if islogical(scaling)
        enable_checks = scaling;
        scaling = 'lin';
    else
        enable_checks = false;
    end
elseif nargin==5
    % determine if scaling and enable_checks are supplied out-of-order
    % and swap if they are
    if islogical(scaling)
        temp = enable_checks;
        enable_checks = scaling;
        scaling = temp;
    end
end

scaling = lower(scaling);

if isempty(scaling) || strcmp(scaling,'lin') || strcmp(scaling,'linlin')
    scaling = 'lin';
    is_log_x = false;
    is_log_y = false;
else
    if strcmp(scaling,'log') || strcmp(scaling,'loglog')
        scaling = 'log';
        is_log_x = true;
        is_log_y = true;
    elseif strcmp(scaling,'loglin') || strcmp(scaling,'semilogx')
        scaling = 'loglin';
        is_log_x = true;
        is_log_y = false;
    elseif strcmp(scaling,'linlog') || strcmp(scaling,'semilogy')
        scaling = 'linlog';
        is_log_x = false;
        is_log_y = true;
    else
        scaling = 'lin';
        warning('Unrecognized scale: assuming %s', scaling)
        is_log_x = false;
        is_log_y = false;
    end
end

if enable_checks
    % these checks affect performance, only do them if requested
    if ~isvector(x) || ~isvector(y)
        error('''x'' and ''y'' must be vectors')
    end
    if ~issorted(x)
        error('''x'' must be in ascending order')
    end
    if ~issorted(xi)
        error('''xi'' must be in ascending order')
    end
    if min(xi) < min(x) || max(xi) > max(x)
        error('All ''xi'' data must be within the range of ''x'' data')
    end
    if is_log_x && min(x)<=0
        error('For ''%s'' all x data must be > 0', scaling);
    end
    if is_log_y && min(y)<=0
        error('For ''%s'' all y data must be > 0', scaling);
    end
end

% convert to log scale for x or y, if log scale is used
if is_log_x
    x = log(x);
    xi = log(xi);
end
if is_log_y
    y = log(y);
end

% pre-allocate output 'yi' to have same dimensions as 'xi'
yi = zeros(size(xi));

% this algorithm is meant to be very efficient, but expects that all 'xi'
% are sorted from low to high, and that they are within the bounds of 'x'
% which is also sorted from low to high.
Nxi = numel(xi);
j_last = 1;
j = 1;
for i=1:Nxi
    
    xt = xi(i);
    
    % test in ascending order to locate the points in which xt is between
    while x(j) < xt
        j_last = j;
        j = j + 1;
    end
    
    m = (y(j)-y(j_last))/(x(j)-x(j_last));
    if isnan(m)
        % detect condition where xt == x(1)
        m = 0;
    end
    
    yi(i) = y(j_last) + (xt-x(j_last))*m;

end

% convert back from log scale, if log scale was used for y
if is_log_y
    yi = exp(yi);
end

% Kerry S. Martin, martin@wild-wood.net 8/20/2021