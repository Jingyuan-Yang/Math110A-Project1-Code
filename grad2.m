% Validation 2
% Jingyuan Yang (#86439119)
% Alisa Crowe (#62073824) 

% Textbook Example 8.26
% Objective function: f(x(1),x(2))=100*(x(2)-x(1)^2)^2+(1-x(1))^2

function y=grad2(x)
% gradient
y=[2*(200*x(1).^3-200*x(1)*x(2)+x(1)-1); 200*(x(2)-x(1).^2)];

