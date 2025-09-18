% =============================================================================
% Project       : classAB
% Module name   : tb_npn
% File name     : tb_npn.m
% Purpose       : test bench for the NPN model
% Author        : QuBi (nitrogenium@outlook.fr)
% Creation date : Thursday, 18 September 2025
% -----------------------------------------------------------------------------
% Best viewed with space indentation (2 spaces)
% =============================================================================

% =============================================================================
% DESCRIPTION
% =============================================================================
% Basic test for the NPN model.


close all
clear all
clc


% =============================================================================
% SETTINGS
% =============================================================================


nPts = 1000;

% BJT settings
bjtParam.v_be_th = 0.7;
bjtParam.i_th = 5e-3;
bjtParam.g_m = .5;



% =============================================================================
% MAIN
% =============================================================================
v_be = linspace(-.1, .8, nPts)';
i_c = npn(v_be, bjtParam);

plot(v_be, 1000*i_c)
xlabel('Base-Emitter voltage v_{BE} (V)')
ylabel('Collector current I_C (mA)')
grid on
