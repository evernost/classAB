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



bjtParam.v_be_th = 0.7;
bjtParam.i_th = 5e-3;
bjtParam.g_m = 100;


% Draw random values for 'a' and 'b', makes sure 
% that both solutions satisfy I = npn(a+bI)


[i_fp_active, i_fp_cutoff] = fp_npn(a, b, param)

% - a = -10 ... 10 Volts
% - b = 1/r with r = 0.1 ... 100 ohms
