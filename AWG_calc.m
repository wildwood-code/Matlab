function [awg,awgs] = AWG_calc(size, type)

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

