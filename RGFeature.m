function rg =RGFeature(I)

I = double(I);

%create the intensity feature from the input image
F1 = 0.3*I(:,:,1) + 0.59*I(:,:,2) + 0.11*I(:,:,3); 

n = size(F1);

for i = 1:n(1)
    for j = 1:n(2)
        
        if (F1(i,j)>25.0)
        
            F2(i,j) = abs(I(i,j,1) - I(i,j,2))./ F1(i,j);
        
        else
            
            F2(i,j) = 0.0;
            
        end
            
    end
end


F2(isnan(F2)) = 0;      % put all Nan = 0

rg = F2;



