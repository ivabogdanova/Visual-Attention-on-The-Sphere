function N_cmap = exponential_norm(cmap, gamma)

%-----------------------------------------------%
% exponential_norm(): this fct computes         %
% the exponential normalization by              %
% factor gamma                                  %
%                                               %                
% step(1) C = w*C where  w = Max(C)/Mean(C)     %
%                                               %
%                 AND                           %
%                                               %
% step(2) C = (C/Max(C))^gamma                  %
%                                               %
%-----------------------------------------------%


%----------------------%
% step 1               %
%----------------------%

Max_C = max(max(cmap));

Mean_C = mean2(cmap);

w = Max_C/Mean_C;          


N_cmap = cmap*w;

%----------------------%
% step 2               %
%----------------------%

Max_NC = max(max(N_cmap));


N_cmap = (N_cmap/Max_NC).^gamma;

