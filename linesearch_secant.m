% Line Search Algorithm Using the Secant Method
% Jingyuan Yang (#86439119)
% Alisa Crowe (#62073824) 


function alpha=linesearch_secant(grad,x,d)
% LINESEARCH_SECANT is the implementation of the secant algorithm to solve
% for the optimal step size for the steepest descent method
% Inputs:
%   - grad: a function handle that returns the gradient of the function
%     at a given point
%   - x: A vector that represents the current point of the optimization algorithm
%   - d: the search direction
% Output:
%   - alpha: the step size that minimizes the function along the search direction


% Maximum number of iterations for the line search algorithm
max = 100; 
% epsilonerance for the line search algorithm
epsilon=10^(-4); 

% Initialize the step sizes and function gradients
current_alpha=0;
alpha=0.001;
dphi_zero=feval(grad,x)'*d;
dphi_curr=dphi_zero;

% Counter for the number of iterations
i=0;
% Loop until the termination criterion is met or the maximum number of iterations is reached
while abs(dphi_curr)>epsilon*abs(dphi_zero);
    % Update the previous values
    old_alpha=current_alpha;
    current_alpha=alpha;
    dphi_old=dphi_curr;
    dphi_curr=feval(grad,x+current_alpha*d)'*d;

    % Update the step size using the secant method
    alpha=(dphi_curr*old_alpha-dphi_old*current_alpha)/(dphi_curr-dphi_old);
    % Increment the iteration count
    i=i+1;
    % If the maximum number of iterations is reached and the termination
    % criterion is still not met, display message and break out of the loop
    if (i >= max) & (abs(dphi_curr)>epsilon*abs(dphi_zero));
        disp('Line search terminating with number of iterations:');
        disp(i);
        break;
    end
end