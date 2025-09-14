% =============================================================================
% Project       : classAB
% Module name   : tb_fp_npn
% File name     : tb_fp_npn.m
% Purpose       : test bench for the NPN fixed point solver
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Sunday, 14 September 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% =============================================================================
% DESCRIPTION
% =============================================================================
% Description is TODO.
% Just be patient.



% =============================================================================
% SETTINGS
% =============================================================================

% Number of test cases
nPts = 100;

% BJT settings
bjtParam.v_be_th = 0.7;
bjtParam.i_th = 5e-3;
bjtParam.g_m = 100;



% =============================================================================
% MAIN
% =============================================================================
% Draw random values for 'a' and 'b', make sure that both solutions returned by 
% 'fp_npn' satisfy I = npn(a+bI)
% - a = -10 ... 10 Volts
% - b = 1/r with r = 0.1 ... 100 ohms

[i_fp_active, i_fp_cutoff] = fp_npn(a, b, param)

