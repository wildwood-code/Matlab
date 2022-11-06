function dxdt=odefun_lorenz(~,x,sigma,beta,rho)
% ODEFUN_LORENZ Lorenz Differential Equations
%   dxdt=ODEFUN_LORENZ(~,x,sigma,beta,rho)
%
%   x is a 3-element vector

if nargin<3
    sigma = 10.0;
end
if nargin<4
    beta = 8.0/3.0;
end
if nargin<5
    beta = 28.0;
end

dxdt(1)=sigma*(x(2)-x(1));
dxdt(2)=x(1)*(rho-x(3))-x(2);
dxdt(3)=x(1)*x(2)-beta*x(3);

% typical parameter values:
%  sigma=10
%  beta=8/3
%  rho=28