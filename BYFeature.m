function yb =BYFeature(I)

I = double(I);

%create the intensity feature from the input image
F1 = 0.3*I(:,:,1) + 0.59*I(:,:,2) + 0.11*I(:,:,3); 

% compute yellow component
Y = (I(:,:,1) + I(:,:,2))/2;


n = size(F1);

for i = 1:n(1)
    for j = 1:n(2)
        
        if (F1(i,j)>25.0)
        
            F3(i,j) = abs(Y(i,j) - I(i,j,3))./ F1(i,j);
        
        else
            
            F3(i,j) = 0.0;
            
        end
            
    end
end


F3(isnan(F3)) = 0;      % put all Nan = 0

yb = F3;



