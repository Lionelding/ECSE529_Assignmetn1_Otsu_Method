function [level, level_new] = otsu_modified(I)
% Otsu's method from the Internet, with modification together
% Copyright 1993-2015 The MathWorks, Inc.

% Reference:
% N. Otsu, "A Threshold Selection Method from Gray-Level Histograms,"
% IEEE Transactions on Systems, Man, and Cybernetics, vol. 9, no. 1,
% pp. 62-66, 1979.



validateattributes(I,{'uint8','uint16','double','single','int16'},{'nonsparse'}, ...
              mfilename,'I',1);

          
if ~isempty(I)
  %% The following code below is from the Internet  
  % Convert all N-D arrays into a single column.  Convert to uint8 for
  % fastest histogram computation.
  I = im2uint8(I(:));
  num_bins = 256;
  % counts is an array having size of 256*1
  counts = imhist(I,num_bins);  
  
  % Variables names are chosen to be similar to the formulas in
  % the Otsu paper.
  
  % Normalized Histogram
  p = counts / sum(counts);  
  omega = cumsum(p);
  mu = cumsum(p .* (1:num_bins)');
  mu_t = mu(end);
  
  sigma_b_squared = (mu_t * omega - mu).^2 ./ (omega .* (1 - omega));


  % Find the location of the maximum value of sigma_b_squared.
  % The maximum may extend over several bins, so average together the
  % locations.  If maxval is NaN, meaning that sigma_b_squared is all NaN,
  % then return 0.
  maxval = max(sigma_b_squared);
  isfinite_maxval = isfinite(maxval);
  if isfinite_maxval
     idx = mean(find(sigma_b_squared == maxval));
     % Normalize the threshold to the range [0, 1].

     level = (idx - 1) / (num_bins - 1);
  else
     level = 0.0;
     isfinite_maxval = false;
  end
   
    
  %% The following code is from Liqiang Ding
  % Find the T2 (named as idx_new) between range from T1 to 256
  % Select the range between T1 and 256, from the orignial histogram
  counts_new=counts(idx+1:num_bins,1:1);
  p_new = counts_new/sum(counts_new);
  omega_new = cumsum(p_new);
  % Calculate the new mu and mu_t
  mu_new=cumsum(p_new .* (idx+1:num_bins)');
  mu_t_new=mu_new(end);
    
  % Locate the maximum value
  sigma_b_squared_new = (mu_t_new * omega_new - mu_new).^2 ./ (omega_new .* (1 - omega_new));
  maxval_new=max(sigma_b_squared_new);
  isfinite_maxval_new = isfinite(maxval_new);
    
  % If the muaimum value exits, find the index of the maximum value. This
  % is the new threshold, T3
  if isfinite_maxval_new
     idx_new = mean(find(sigma_b_squared_new == maxval_new));
     idx_new=idx_new+idx;
     level_new=(idx_new - 1) / (num_bins - 1);     
  else
     level_new=0;
  end
  
  
  
  
end

  
end



