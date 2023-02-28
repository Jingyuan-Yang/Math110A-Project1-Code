% The Steepest Descent Algorithm Using the Secant Method for Line Search
% Jingyuan Yang (#86439119)
% Alisa Crowe (#62073824) 


function [x,N]=steep_desc(grad,xnew,settings);
% Inputs:
%   grad: A function handle that computes the gradient of the objective
%         function.
%   xnew: A vector that represents the initial point of the optimization
%         algorithm.
%   settings (optional): A vector that specifies the settings for the
%                        optimization algorithm. It can have up to four
%                        elements, in the following order: 'print',
%                        'epsilon_x', 'epsilon_g', and 'max_iter'.
%
% Outputs:
%   x: A vector that represents the final point of the optimization
%      algorithm.
%   N (optional): An integer that represents the number of iterations
%                 performed by the algorithm.
%
% Note: If the user does not request any output arguments, the function
%       prints the final point and number of iterations to the console.
%       If the user requests one output argument, the function returns only
%       the final point. If the user requests two output arguments, the
%       function returns both the final point and the number of iterations.


% Set default settings
if nargin ~= 3 % check if three input arguments are provided
    settings = []; % if not, set settings to empty
    if nargin ~= 2 % if two input arguments are not provided
        disp('Wrong number of arguments.'); % display an error message
        return;
    end
end

% Define default settings if not set
if length(settings) >= 4 % check if settings array is at least length 4
    if settings(4)==0 % check if the maximum number of iterations is set to zero
        settings(4)=1000*length(xnew); % if so, set it to a default value
    end
else
    settings(4)=1000*length(xnew); % if not, set it to a default value
end

clc; % clear command window
format compact; % set format to compact
format short e; % set format to scientific notation with 5 digits after decimal point

% Set display settings
settings = foptions(settings); % Convert the settings input to a struct with default values if necessary
print = settings(1); % Whether to print information during the optimization
epsilon_x = settings(2); % Tolerance for difference between consecutive iterates
epsilon_g = settings(3); % Tolerance for norm of gradient
max_iter=settings(4); % Maximum number of iterations

% Perform gradient descent
for k = 1:max_iter
    xcurr=xnew; % Set the current iterate to the most recent iterate
    g_curr=feval(grad,xcurr); % Evaluate the gradient at the current iterate
    if norm(g_curr) <= epsilon_g % If the norm of the gradient is smaller than the tolerance, terminate the optimization
        disp('Terminating: Norm of gradient less than');
        disp(epsilon_g);
        k=k-1; % Since we're terminating early, decrement k to undo the final increment
        break;
    end 
    
    % Perform line search using secant method
    alpha=linesearch_secant(grad,xcurr,-g_curr); % Perform a line search to determine the step size
    % Update the iterate using the chosen step size and direction
    xnew = xcurr-alpha*g_curr; 
    
    % Print current iteration's information
    if print
        disp('Iteration number k =')
        disp(k); % Print the current iteration index
        disp('alpha =');
        disp(alpha); % Print the step size
        disp('Gradient = ');
        disp(g_curr'); % Print the gradient at the current iterate
        disp('New point =');
        disp(xnew'); % Print the new iterate
    end
    
    % Check termination criteria
    if norm(xnew-xcurr) <= epsilon_x*norm(xcurr) % If the change in iterates is smaller than the tolerance, terminate the optimization
        disp('Terminating: Norm of difference between iterates less than');
        disp(epsilon_x);
        break;
    end    
    
    if k == max_iter % If we reach the maximum number of iterations, terminate the optimization
        disp('Terminating with maximum number of iterations');
    end 
end 

if nargout >= 1 % If the function was called with an output argument for x, set x to the final iterate
    x=xnew;
    if nargout == 2 % If the function was called with an output argument for N, set N to the number of iterations
        N=k;
    end
else % If the function was not called with any output arguments, print the final iterate and the number of iterations
    disp('Final point =');
    disp(xnew');
    disp('Number of iterations =');
    disp(k);
end 
