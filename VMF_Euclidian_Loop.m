function [out] = VMF_Euclidian_Loop(OMEGA_x)

[R,C,spec] = size(OMEGA_x);
dis = zeros(1,R*C);
temp = zeros(3,R*C);
a=1;
for r=1:1:R
    for c=1:1:C
        x1 = double(reshape(OMEGA_x(r,c,:), [1 3])); 
        di = 0;        
        for rr=1:1:R
            for cc =1:1:C
                xk = double(reshape(OMEGA_x(rr,cc,:), [1 3]));
                di = di + sqrt(sum(abs(x1-xk).^2));
                dis(a)=di;
            end            
        end
        temp(1:3,a)= OMEGA_x(r,c,:);                           
        a = a+1;
    end
end

[~,ind] = min(dis);
ind(1);
out = temp(1:3, ind);
end
