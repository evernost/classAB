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
title('NPN model transfer curve I_C = f(v_{BE})')
xlabel('Base-Emitter voltage v_{BE} (V)')
ylabel('Collector current I_C (mA)')
grid on

ax = gca;
x_start = 0.4;            y_start = 0.4;
x_th = bjtParam.v_be_th;  y_th = bjtParam.i_th*1000;
xfig = (x_th - ax.XLim(1)) / diff(ax.XLim) * ax.Position(3) + ax.Position(1);
yfig = (y_th - ax.YLim(1)) / diff(ax.YLim) * ax.Position(4) + ax.Position(2);

annotation('textarrow', [x_start xfig], [y_start yfig], 'String', 'threshold');

