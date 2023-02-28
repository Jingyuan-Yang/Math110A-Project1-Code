% Validation 1
% Jingyuan Yang (#86439119)
% Alisa Crowe (#62073824) 

% Textbook Example 8.1
% Objective function: f(x(1),x(2),x(3))=(x(1)-4).^4+(x(2)-3).^2+4*(x(3)+5).^4

function y=grad1(x)
% gradient
y=[4*(x(1)-4).^3; 2*(x(2)-3); 16*(x(3)+5).^3]; 

