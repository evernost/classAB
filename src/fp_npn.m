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
% Solves the fixed point equation for 'I': 
% I = npn(a+bI) 
% where a,b are constants.
%
% The function returns the solution for each region of the model:
% - reverse
% - cutoff
% - active forward
% 
% Most of the time, only one region can have a solution.
% In that case, the regions that have no solutions will return "NaN".
%
% Though there can be special values of a, b where there is a valid physical 
% solution in two or more regions.
%
% But in the real world, it usually leads to oscillations, or some of the
% solutions will be 'repulsive' (i.e. unstable) and hence unreachable.
%
% DERIVATION
% Solve the 'fixed point' equation I = npn(a + b*I)
% Assuming I(v_be) = g_m*v_be + I_0, then:
% I = g_m*(a + b*I) + I_0
% I*(1 - g_m*b) = g_m*a + I_0
% I = (g_m*a + I_0)/(1 - g_m*b)


% =============================================================================
% PARAMETERS
% =============================================================================
% None.



% =============================================================================
% SOLVER
% =============================================================================
function [i_fp_active, i_fp_cutoff, i_fp_reverse] = fp_npn(a, b, param)

  % Model the function I = npn(v_be) as I = g_m*v_be + I_0
  % 'g_m' and 'I_0' have different values depending on the operating mode.

  % --------------
  % REVERSE REGION
  % --------------
  g_m = 0;
  I_0 = 0;

  i_fp_reverse = (g_m*a + I_0)/(1 - g_m*b);
  
  v_op = a + b*i_fp_reverse;
  if (v_op >= 0.0)
    i_fp_reverse = NaN;
  end

  % -------------
  % CUTOFF REGION
  % -------------
  g_m = param.i_th/param.v_be_th;
  I_0 = 0;

  i_fp_cutoff = (g_m*a + I_0)/(1 - g_m*b);

  v_op = a + b*i_fp_cutoff;
  if (v_op < 0.0) || (v_op >= param.v_be_th)
    i_fp_cutoff = NaN;
  end

  % ---------------------
  % ACTIVE FORWARD REGION
  % ---------------------
  g_m = param.g_m;
  I_0 = param.i_th - (param.g_m*param.v_be_th);
  
  i_fp_active = (g_m*a + I_0)/(1 - g_m*b);

  v_op = a + b*i_fp_cutoff;
  if ((v_op < param.v_be_th) || (i_fp_active < 0))
    i_fp_active = NaN;
  end


end
