function gradient = adaptive_gradient(a,b,gamma)
    gradient = 2*(a-b)*gamma./(2*(gamma+abs(a-b)));
end