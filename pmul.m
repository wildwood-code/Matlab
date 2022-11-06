function p = pmul(a,varargin)
% PMUL simple polynomial multiplication
%   p = PMUL(a,b,...)
%
%   inputs:
%      one or more polynomials (row vectors) or scalars
%
%   output:
%
%     outputs a row vector representing the product of all of the
%     polynomials in the input list
%
%   % Example:
%   %   pmul(44, [1 0], [1/4 0 1])  ->  [11 0 44 0]
%   %   is equivalent to multiplying:
%   %     44 * (s) * (s^2/4 + 1)  ->  11*s^3 + 44*s
%   pmul(44, [1 0], [1/4 0 1])
%
%   See also: CONV

% Author: Kerry S. Martin, martin@wild-wood.net, 1/10/2017

p = a;

if nargin>1
    for i=1:length(varargin)
        p = conv(p, varargin{i});
    end
end