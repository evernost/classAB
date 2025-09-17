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


close all
clear all
clc


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

for n = 1:nPts
  
  a = -10 + rand*(10-(-10));
  r = 0.1 + rand*(100-0.1);
  b = 1/r;


  [i_fp_active, i_fp_cutoff] = fp_npn(a, b, bjtParam);

  fprintf('a = %0.3f, b = %0.3f\n', a, b);
  fprintf('- I (active) = %0.3f; npn(a+bI) = %0.3f\n', i_fp_active, npn(a+b*i_fp_active, bjtParam));
  fprintf('- I (cutoff) = %0.3f; npn(a+bI) = %0.3f\n', i_fp_cutoff, npn(a+b*i_fp_cutoff, bjtParam));
  fprintf('\n');
end
