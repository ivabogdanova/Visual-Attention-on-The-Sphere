function N_cmap = weight_w_norm(cmap)

w = max(max(cmap))/mean2(cmap);                                     
N_cmap = cmap*w;