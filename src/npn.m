% =============================================================================
% Project       : classAB
% Module name   : npn
% File name     : npn.m
% Purpose       : NPN forward model
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Monday, 08 September 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================
%
%

function i_c = npn(v_be, i_0, g_m)

  v_be_th = 0.7;

  % Default current is 0A
  i_c = zeros(size(v_be));
  
  % Cutoff region: v_be < 0.7V
  idxCutoff = (v_be < v_be_th);
  i_c(idxCutoff) = v_be(idxCutoff)*i_0/v_be_th;

  % Active forward region: v_be >= 0.7V
  idxActive = (v_be > v_be_th);
  i_c(idxActive) = g_m*(v_be(idxCutoff) - v_be_th) + i_0;
  
end
