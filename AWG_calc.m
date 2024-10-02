function [awg,awgs] = AWG_calc(size, type)
% AWG_CALC AWG wire gauge calculator
%   awg = AWG_CALC(size_mm2)
%   awg = AWG_CALC(size_mm2, 'CSA')   % or 'MM2' or 'MM^2'
%   awg = AWG_CALC(diam_mm, 'MM')     % or 'D' or 'DIA'
%   awg = AWG_CALC(diam_in, 'IN')
%   awg = AWG_CALC(diam_mil, 'MIL')

% Kerry S. Martin, martin@wild-wood.net

% dia(mm) = 0.127mm * 92^((36-n)/39)
narginchk(1,2)
if nargin<2
    type = 'CSA';
end
type = upper(type);
switch (type)
    case { 'CSA', 'MM2', 'MM^2' }
        size = 2*sqrt(size/pi);
    case { 'D', 'DIA', 'MM' }
        % native unit, no conversion required
    case { 'IN' }
        size = size*25.4;
    case { 'MIL' }
        size = size*0.0254;
    otherwise
        error('Unknown type')
end

awg = (36-39*log(size/0.127)/log(92));
if nargout>=2
    if awg>=1.0
        awgs = sprintf("%.0f", floor(awg));
    elseif awg>-0.5
        awgs = "0";
    elseif awg>-1.5
        awgs = "00";
    elseif awg>-2.5
        awgs = "000";
    elseif awg>-3.5
        awgs = "0000";
    else
        awgs = ">0000";
    end
end

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net