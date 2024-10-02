function X=logspacex(X1, X2, N)
% LOGSPACEX log spaced data shortcut
%   X = LOGSPACEX(X1, X2, N)
%
%   equivalent to logspace(log10(X1), log10(X2), N)
%
%   See also: LOGSPACE

narginchk(2,3)

if nargin<3
    N = 50;
end

if X1<=0
    error('X1 must be greater than zero')
end
if X2<=X1
    error('X2 must be greater than X1')
end

X = logspace(log10(X1), log10(X2), N);

% Copyright (c) 2024, Kerry S. Martin, martin@wild-wood.net