function fix_log_axis_numbering(haxis)
% FIX_LOG_AXIS_NUMBERING  change log axis numbering to # style vs 10^#
%   FIX_LOG_AXIS_NUMBERING(haxis)
%      haxis = handle to axis (default = current axis)
%
%   This function changes only log axes (x and/or y). It will not change
%   linear axes.

narginchk(0,1)
if nargin<1
    haxis = gca;
end

% X axis
switch haxis.XScale
    case 'log'
        New_TickLabel = get(haxis,'XTick');
        set(haxis,'XTickLabel',New_TickLabel);
end

% Y axis
switch haxis.YScale
    case 'log'
        New_TickLabel = get(haxis,'YTick');
        set(haxis,'YTickLabel',New_TickLabel);
end

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net