function SYS=bodes(H,w)
% BODES Generate bode plot for symbolic H(s)
%   BODES(H)
%   SYS = BODES(H)
%   SYS = BODES(H,{WMIN,WMAX})
%   SYS = BODES(H,W)
%
%   This function will generate a bode plot of a symbolic function of 's'.
%   The optional output argument is the continuous-time transfer function
%   represented by H(s)
%
%   H(s) must be a rational function of 's'. H(s) may have symbolic
%   coefficients, but these must evaluate to numeric coefficients. This
%   will be done in BODES.
%
%   Example:
%     syms s k0 k1 k2
%     H = s/(k2*s^2 + k1*s + k0);
%     k0 = 140; k1=10; k2=1;
%     bodes(H)
%
%   See also: TF BODE

% Kerry S. Martin, martin@wild-wood.net

% sanity checking and argument tweaking
narginchk(1,2)
nargoutchk(0,1)
if ~isa(H,'sym')
    error('The argument ''H'' must be a symbolic rational function of ''s''')
end

% The argument H must be a rational function of s
syms s

% Evaluate the symbolic transfer function, substituting in any defined
% values of parameters in the workspace
[N,D] = numden(subs(H));

% Evaluate the num and den coefficients numerically
PD = double(coeffs(D,s,'All'));
PN = double(coeffs(N,s,'All'));

% Normalize and reverse the vectors
P0 = PD(1);
NUM = PN/P0;
DEN = PD/P0;

% Form the transfer function
HS = tf(NUM, DEN);

% If an output is specified, return the generated tf
if nargout>0
    % don't plot, just generate the output argument
    SYS = HS;
else
    % plot if no output arguments were specified
    if nargin<2
        bode(HS)
    else
        bode(HS,w)
    end
end