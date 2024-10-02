function val_out = iff(cond, val_true, val_false)
% IFF if/else structure in a function form
%   val_out = IFF(cond, val_true, val_false)
%
%   is a function equivalent to:
%     if cond
%       val_out = val_true;
%     else
%       val_out = val_false;
%     end
%
%   This may be useful for defining compact conditionals, for instance when
%   defining anonymous functions.
%
%   % Example:
%   % foo = @(c,x,y) iff(c,x.*y,x./y)

% Kerry S. Martin, martin@wild-wood.net

warning('deprecated - use ''iif''')

if isscalar(cond)
    if cond
        val_out = val_true;
    else
        val_out = val_false;
    end
else
    val_out = (cond).*val_true + (~cond).*val_false;
end

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net