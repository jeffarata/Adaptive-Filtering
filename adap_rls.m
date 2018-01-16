% Jeff Arata
% 1/7/18

function [ e, h ] = adap_rls( x, d, M, lambda, delta )
% This function implements an adaptive RLS filter algorithm by following
% that laid out in computer exercise 5 of the course Adaptive Signal
% Processing taught in 2010 at Lund University. This can be found in a pdf
% online.

% Input:
%
% x         - input signal, length N
% d         - desired signal: , length N
% M         - filter length/order
% lambda    - forgetting factor 0 < lambda <= 1 
% delta     - for initializing the P matrix
%
% Output:
%
% e         - the estimation error, length N
% h         - the final output filter weights, length M

x = x(:);   % Ensure x and d inputs are columns
d = d(:);
N = length(x); 
h = zeros(M,1);     % Initialize filter weights
P = eye(M)/delta;   % Initiailize P matrix

e = d;              % Initialize error as d signal

for ii = M:N
    
    x_col = x(ii:-1:ii-M+1);    % Get frame of x input signal
    k = ((1/lambda)*P*x_col) / (1 + (1/lambda)*x_col'*P*x_col);
    e(ii) = d(ii) - h'*x_col;   % Error at current time step
    h = h + k*conj(e(ii));      % Update filter coefficients
    P = (1/lambda)*P - (1/lambda)*k*x_col'*P;   % Update P matrix   
    
end
end
