% =============================================================================
% Project       : classAB
% Module name   : fp_npn
% File name     : fp_npn.m
% Purpose       : fixed point solver for the NPN forward model
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Sunday, 14 September 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% =============================================================================
% DESCRIPTION
% =============================================================================
% Solves the fixed point equation I = npn(a+bI)
% Returns both the active forward and the cutoff solution.
% 
% Even though there are two solutions, only one of them makes sense depending 
% on the context.



% =============================================================================
% PARAMETERS
% =============================================================================
% Description is TODO.



% =============================================================================
% SOLVER
% =============================================================================
function [i_fp_active, i_fp_cutoff] = fp_npn(a, b, param)

  % Model the function I = npn(v_be) as I = u*v_be + v
  % 'u' and 'v' have different values depending on the operating mode.

  % -------------
  % CUTOFF REGION
  % -------------
  u = param.i_th/param.v_be_th;
  v = 0;

  % Solve the 'fixed point' equation I = npn(a + b*I)
  % I = u*(a + b*I) + v
  % I*(1 - u*b) = u*a + v
  % I = (u*a + v)/(1 - u*b)
  i_fp_cutoff = (u*a + v) ./ (1 - u*b);

  % ---------------------
  % ACTIVE FORWARD REGION
  % ---------------------
  % I = u*v_be + v
  u = param.g_m;
  v = param.i_th - (param.g_m*param.v_be_th);
  
  i_fp_active = (u*a + v) ./ (1 - u*b);

end
