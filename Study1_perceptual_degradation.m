% Reproduce perceptual-degradation figure panels (manuscript 16 Nov 2026).
% Figure 1G: combined performance space.
% Figure 2: baseline throughput, sensory maps, fitted surfaces and errors.
% Figure 3: bootstrap uncertainty and sensor comparison.
% Requires MATLAB, Curve Fitting Toolbox, Statistics and Machine Learning
% Toolbox, and the external gridfit function (not supplied).
% Run the entire script. Data are embedded as in the original analysis.
clearvars; close all;

%% 1. Participant data (rows: presentation order; columns: participants)
Diam = [1.65,	2.36, 2.44, 2.83, 3.22, 3.61, 3.84, 4.08, 4.17, 4.31, 4.56, 4.74, 4.93, 5.07, 5.18, 5.46, 5.88, 6.1, 6.45, 6.65];
Force = [0.008, 0.02, 0.04, 0.07, 0.16, 0.4, 0.6, 1, 1.4, 2, 4, 6, 8, 10, 15, 26, 60, 100, 180, 300]; %g
%P1
C(:,1) = 329;
cots(:,1) = [0,6,1,4,8,7,3,2,5];
dext1(:,1) = [60*25/85,14,9,9,6,19,20,NaN,NaN];
dext2(:,1) = [13,13,9,9,8,14,17,NaN,NaN];
GO(:,1) = [2,6.61,5.54,3.58,6,3.74,2.25,NaN,NaN];
MF(:,1) = [2.44,4.17,4.56,4.74,4.74,4.56,3.84,NaN,NaN];
%P2
C(:,2) = 132;
cots(:,2) = [0,3,5,4,6,7,2,1,8];
dext1(:,2) = [60*25/71,22,9,10,25,16,14,15,11];
dext2(:,2) = [16,15,3,7,17,12,10,10,6];
GO(:,2) = [3.2,2.22,7.63,7.41,3.25,6.72,7.15,6.86,7];
MF(:,2) = [1.65,2.44,3.61,4.31,2.44,3.22,2.36,3.61,4.93];
%P3
C(:,3) = 214;
cots(:,3) = [0,5,4,1,8,6,3,2,7];
dext1(:,3) = [60*25/68,4,8,11,6,16,17,8,19];
dext2(:,3) = [20,1,7,9,4,15,18,12,13];
GO(:,3) = [1.38,7.04,3.74,4.08,6.72,4.44,2.39,4.4,4.74];
MF(:,3) = [2.36,3.61,4.56,2.44,5.07,2.83,2.44,2.44,2.44];
%P4
C(:,4) = 160;
cots(:,4) = [0,2,4,5,6,7,3,8,1];
dext1(:,4) = [60*25/44.7,17,15,17,25.86,24,29.41,9,19];
dext2(:,4) = [27,13,10,7,23,19,24,7,15];
GO(:,4) = [0.96,5.5,3.03,6.38,2.39,3.73,2.08,6.11,7.42];
MF(:,4) = [1.65,2.44,4.08,2.44,2.36,2.44,2.36,4.74,3.61];
%P5
C(:,5) = 230;
cots(:,5) = [0,2,3,8,6,4,1,7,5];
dext1(:,5) = [60*25/50,7,25,5,25,NaN,NaN,NaN,NaN];
dext2(:,5) = [15,5,16,2,15,NaN,NaN,NaN,NaN];
GO(:,5) = [3.39,5,3.9,7.38,2.06,NaN,NaN,NaN,NaN];
MF(:,5) = [1.65,2.44,2.83,4.74,2.83,NaN,NaN,NaN,NaN];
%P6
C(:,6) = 235;
cots(:,6) = [0,5,4,1,7,2,3,8,6];
dext1(:,6) = [60*25/69,10,11,14,21,29,26,11,26.3];
dext2(:,6) = [15,3,7,10,8,16,17,5,19];
GO(:,6) = [1.38,7.03,3.83,4.98,3.46,4.42,1.75,6.18,1.52];
MF(:,6) = [2.44,3.22,4.31,2.83,3.22,2.44,2.83,4.93,3.61];
%P7
C(:,7) = 260;
cots(:,7) = [0,4,7,2,8,6,5,3,1];
dext1(:,7) = [60*25/63,13,13,16,9,25,15,23,NaN];
dext2(:,7) = [16,7,12,11,8,18,10,17,NaN];
GO(:,7) = [2.15,7.79,6,5.07,7.72,6.69,7.6,5.38,NaN];
MF(:,7) = [2.44,4.56,3.84,2.44,4.93,3.84,3.61,2.44,NaN];
%P8
C(:,8) = 350;
cots(:,8) = [0,2,6,8,1,4,7,5,3];
dext1(:,8) = [60*25/63,8,19,8,11,12,16,10,NaN];
dext2(:,8) = [20,7,18,3,10,12,15,9,NaN];
GO(:,8) = [0.86,7.56,2.03,7.32,5.91,6.21,2.75,7.45,NaN];
MF(:,8) = [2.44,2.44,2.44,4.56,2.83,4.31,3.22,3.84,NaN];
%P9
C(:,9) = 155;
cots(:,9) = [0,1,3,7,5,2,6,8,4];
dext1(:,9) = [60*25/60,8,21,15,10,16,22,12,14];
dext2(:,9) = [18,6,13,12,5,9,21,4,9];
GO(:,9) = [2.09,7.36,5.79,7.15,7.25,6.77,6.19,7.6,7.78];
MF(:,9) = [2.36,3.22,2.44,4.31,3.22,2.44,2.36,4.56,4.31];
%P10
C(:,10) = 225;
cots(:,10) = [0,6,7,1,5,2,4,8,3];
dext1(:,10) = [60*25/51,25,21,16,7,20,15,11,NaN];
dext2(:,10) = [17,15,11,7,5,12,9,3,NaN];
GO(:,10) = [2.04,1.84,5.33,5.93,7.53,7.12,4.17,7.86,NaN];
MF(:,10) = [2.36,2.83,4.08,2.83,4.31,4.31,4.74,5.46,NaN];
%P11
C(:,11) = 148;
cots(:,11) = [0,5,7,1,6,3,8,4,2];
dext1(:,11) = [60*25/54,10,13,14,18,24,10,15,NaN];
dext2(:,11) = [22,8,13,14,19,23,8,13,NaN];
GO(:,11) = [2.43,7.27,4.33,7.38,3.33,3.1,6.61,7.56,NaN];
MF(:,11) = [2.36,2.83,2.83,2.83,2.44,2.44,4.31,3.84,NaN];

%P12
C(:,12) = 180;
cots(:,12) = [0,5,7,1,6,8,3,4,2];
dext1(:,12) = [60*25/61,4,14,11,18,10,25,12,NaN];
dext2(:,12) = [19,4,10,7,17,7,17,13,NaN];
GO(:,12) = [2.56,7.75,2.9,7.5,2.18,7.88,1.47,5.46,NaN];
MF(:,12) = [1.65,2.44,2.83,2.44,3.84,4.31,2.83,3.22,NaN];
%P13
C(:,13) = 149;
cots(:,13) = [0,6,2,3,4,1,8,7,5];
dext1(:,13) = [60*25/62,23,17,23,14,20,5,NaN,NaN];
dext2(:,13) = [15,17,10,16,2,13,5,NaN,NaN];
GO(:,13) = [1.39,1.83,7.72,1.73,6.98,7.62,7.69,NaN,NaN];
MF(:,13) = [1.65,2.36,3.61,2.36,4.74,2.83,5.46,NaN,NaN];
%P14
C(:,14) = 260;
cots(:,14) = [0,8,2,7,5,6,4,3,1];
dext1(:,14) = [60*25/62,7,13,15,13,18,15,22,NaN];
dext2(:,14) = [18,5,12,12,9,19,10,20,NaN];
GO(:,14) = [2.12,7.33,4.9,3.45,4.75,1.77,3.08,2.33,NaN];
MF(:,14) = [2.36,4.31,2.36,3.22,2.83,3.84,3.22,2.83,NaN];
%P15
C(:,15) = 175;
cots(:,15) = [0,6,2,4,5,7,3,8,1];
dext1(:,15) = [60*25/111,15,10,7,7,11,23,NaN,NaN];
dext2(:,15) = [16,13,8,6,6,8,15,NaN,NaN];
GO(:,15) = [2.5,4.25,5.17,5.42,7.75,7.73,2.53,NaN,NaN];
MF(:,15) = [1.65,4.08,2.83,3.84,3.22,3.22,2.44,NaN,NaN];
%P16
C(:,16) = 300;
cots(:,16) = [0,3,5,6,8,1,7,4,2];
dext1(:,16) = [60*25/59,23.4,10,23,12,16,18,15,NaN];
dext2(:,16) = [17,21,9,16,5,11,15,12,NaN];
GO(:,16) = [0.93,1.86,7.77,2.55,4.75,4.05,3.71,4.53,NaN];
MF(:,16) = [2.36,2.83,2.83,3.22,4.56,2.36,2.44,3.61,NaN];

%% 2. Preprocessing
% Original learning correction applied to bare-finger throughput.
dext1(1,:) = dext1(1,:).*1.107;
dext2(1,:) = dext2(1,:).*1.107;

% Convert monofilament scores to force thresholds in grams.
[known, idx] = ismember(MF, Diam);
assert(all(known(~isnan(MF))), 'Unknown monofilament score.');
MF_f = nan(size(MF));
MF_f(known) = Force(idx(known));

% Flatten measurements and normalize throughput to the corrected baseline.
x1 = GO(:);
y1 = log10(MF_f(:));
z1 = reshape(dext1./dext1(1,:),[],1);
z2 = reshape(dext2./dext2(1,:),[],1);
mask = isfinite(x1) & isfinite(y1) & isfinite(z1) & isfinite(z2);

%% 3. Figure 2A-B: bare-finger throughput
figure;
subplot 121
boxplot(dext1(1,:))
ylabel('bare finger throughput')
ylim([10 40])
subplot 122
boxplot(dext2(1,:))
ylim([10 40])

%% 4. Analytical model for Figures 1G and 3B
% Kept separate from gridfit to avoid overwriting the Figure 2 surfaces.
x = x1(mask); y = y1(mask);
ft = fittype( ...
 @(a0,d0,d1,e0,e1,xx,yy) a0 - (d0.^2 .* xx + d0.*d1 .* xx.^2 + (1/3).*d1.^2 .* xx.^3) ...
 - (e0.^2 .* yy + e0.*e1 .* yy.^2 + (1/3).*e1.^2 .* yy.^3), ...
 'independent', {'xx','yy'}, 'coefficients', {'a0','d0','d1','e0','e1'} );
opts1 = fitoptions(ft);
% Task 1
opts1.StartPoint = [mean(z1(mask))  0 0 0 0]; % Original initialization; verify fit convergence.
opts1.Weights = ones(size(x));
opts1.Weights(z1(mask)<0.4 | z1(mask)==1) = 2;
[f1, gof1] = fit( [x  y], z1(mask), ft, opts1 );
opts2 = fitoptions(ft);
weights = ones(size(x1(mask)));
weights(z2(mask)<0.4) = 2;
weights(z2(mask)==1) = 2;
opts2.Weights    = weights;              % your weights
opts2.StartPoint = [mean(z2(mask))  0 0 0 0];   % simple starting guess
[f2, gof2] = fit( [x  y], z2(mask), ft, opts2 );
opts = fitoptions(ft);
opts.Weights    = ones(size(repmat(x,2,1)));              % your weights
opts.StartPoint = [mean(z2(mask))  0 0 0 0];   % simple starting guess
[f_all, gof] = fit( [repmat(x,2,1)  repmat(y,2,1)], [z1(mask);z2(mask)], ft, opts );

%% 5. Figure 1G: combined performance space
levels = 0.3:0.1:1;
xPerformance = linspace(min(x1(mask)),max(x1(mask)),60);
yPerformance = linspace(min(y1(mask)),max(y1(mask)),60);
[XP,YP] = meshgrid(xPerformance,yPerformance);
figure('Name','Figure 1G - Performance space');
pcolor(XP,10.^YP,f_all(XP,YP)); shading flat; hold on;
contour(XP,10.^YP,f1(XP,YP),levels,'w','LineWidth',1);
contour(XP,10.^YP,f2(XP,YP),levels,'--w','LineWidth',1);
set(gca,'YScale','log'); grid on; box on;
xlabel('Spatial resolution [mm]'); ylabel('Force threshold [g]');
caxis([0 1]); cb = colorbar; cb.Label.String = 'Normalized throughput';

%% 6. Figure 2C-F: sensory maps and nonparametric surfaces
assert(exist('gridfit','file') ~= 0, 'Install gridfit before running this section.');
figure;
subplot 221
hold on
for pp=1:size(cots,2)
scatter(GO(2:end,pp),MF_f(2:end,pp),50,dext1(2:end,pp)./dext1(1,pp),'filled')
set(gca,'yscale','log')
end
colormap jet
set(gca, 'XAxisLocation', 'top');
set(gca, 'YDir', 'reverse');
xlabel('spatial resolution'); ylabel('pressure sensitivity');
grid on
colorbar
caxis([0.2 1])
subplot 222
hold on
for pp=1:size(cots,2)
scatter(GO(2:end,pp),MF_f(2:end,pp),50,dext2(2:end,pp)./dext2(1,pp),'filled')
set(gca,'yscale','log')
end
colormap jet
set(gca, 'XAxisLocation', 'top');
set(gca, 'YDir', 'reverse');
xlabel('spatial resolution'); ylabel('pressure sensitivity');
grid on
colorbar
caxis([0.2 1])
x1 = reshape(GO,[],1);
y1 = log10(reshape(MF_f,[],1));
mask = ~isnan(x1);
z1 = reshape(dext1./dext1(1,:),[],1);
z2 = reshape(dext2./dext2(1,:),[],1);
nx = 60;
ny = 60;

xg = linspace(min(x1(mask)), max(x1(mask)), nx);
yg = linspace(min(y1(mask)), max(y1(mask)), ny);

[Xg,Yg] = meshgrid(xg,yg);
s = 10; % Original gridfit smoothing parameter
Zg1 = gridfit(x1(mask),y1(mask),z1(mask),xg,yg,'smoothness',s,'regularizer','springs');
Zg2 = gridfit(x1(mask),y1(mask),z2(mask),xg,yg,'smoothness',s,'regularizer','springs');
subplot 223
surf(Xg,10.^Yg,Zg1,'EdgeColor','none','FaceAlpha',0.8)
hold on
scatter3(x1(mask),10.^y1(mask),z1(mask),35,'k','filled')
set(gca,'YScale','log')
xlabel('Spatial resolution')
ylabel('Force threshold')
zlabel('Normalized throughput')
zlim([0.2 1])
view(145,25)
camlight
lighting gouraud
subplot 224
surf(Xg,10.^Yg,Zg2,'EdgeColor','none','FaceAlpha',0.8)
hold on
scatter3(x1(mask),10.^y1(mask),z2(mask),35,'k','filled')
set(gca,'YScale','log')
xlabel('Spatial resolution')
ylabel('Force threshold')
zlabel('Normalized throughput')
zlim([0.2 1])
view(145,25)
camlight
lighting gouraud

%% 7. Figure 2: prediction errors and OOD/ID comparison
% Use the gridfit surfaces, not the alternative analytical fit.
z1_pred = interp2( Xg, Yg, Zg1, x1, y1, 'linear', NaN);

residuals1 = z1 - z1_pred;         % signed difference
abs_error1 = abs(residuals1);      % absolute deviation
rmse1 = sqrt(nanmean(residuals1.^2)); % root mean squared error

fprintf('Fit 1 RMSE = %.4f\n', rmse1);

% z2_pred = feval(f2, x1, y1);
z2_pred = interp2( Xg, Yg, Zg2, x1, y1, 'linear', NaN);
residuals2 = z2 - z2_pred;
abs_error2 = abs(residuals2);
rmse2 = sqrt(nanmean(residuals2.^2));

fprintf('Fit 2 RMSE = %.4f\n', rmse2);

% --- Cross task ---
residuals1_2 = z1 - z2_pred;         % signed difference
abs_error1_2 = abs(residuals1_2);      % absolute deviation
rmse1_2 = sqrt(nanmean(residuals1_2.^2)); % root mean squared error

fprintf('Points 1 Fit 2 RMSE = %.4f\n', rmse1_2);

residuals2_1 = z2 - z1_pred;
abs_error2_1 = abs(residuals2_1);
rmse2_1 = sqrt(nanmean(residuals2_1.^2));

fprintf('Points 2 Fit 1 RMSE = %.4f\n', rmse2_1);
mask = ~isnan(x1) & ~isnan(y1) & ~isnan(z1);
X = [x1(mask), y1(mask)];   % y1 is log10(MF_f)
Z1 = z1(mask);
Z2 = z2(mask);
Z = mean([Z1,Z2],2);

% Normalize for fair distance in x vs y
mu = mean(X,1);  sig = std(X,[],1);
Xn = (X - mu) ./ sig;

% kNN-based sparsity (OOD score per point)
k = 10;  % try 5–15 depending on dataset size
[idx, dist] = knnsearch(Xn, Xn, 'K', k+1); % includes self at column 1
q = 20; % Original 20th-percentile cutoff (not top 20%); verify against manuscript.
thr = prctile(dist(:,end), q);
sparse = dist(:,end) > thr; % distance to k-th neighbor

% boundary: convex hull
K = convhull(X(:,1), X(:,2));
is_hull = false(size(X,1),1);
is_hull(K) = true;

OOD_pts = sparse & is_hull;
ID_pts  = ~OOD_pts;
err1 = abs(Z1 - z1_pred(mask));
err2 = abs(Z2 - z2_pred(mask));
err1_ood = err1; err1_ood(ID_pts) = NaN;
err1_id = err1; err1_id(OOD_pts) = NaN;
err2_ood = err2; err2_ood(ID_pts) = NaN;
err2_id = err2; err2_id(OOD_pts) = NaN;

rmse_all1 = sqrt(mean(err1.^2, 'omitnan'));
rmse_id1  = sqrt(mean(err1(ID_pts).^2, 'omitnan'));
rmse_ood1 = sqrt(mean(err1(OOD_pts).^2,'omitnan'));
rmse_all2 = sqrt(mean(err2.^2, 'omitnan'));
rmse_id2  = sqrt(mean(err2(ID_pts).^2, 'omitnan'));
rmse_ood2 = sqrt(mean(err2(OOD_pts).^2,'omitnan'));

figure; boxplot([err1_ood,err1_id,err2_ood,err2_id],'labels',{'OOD1';'ID1';'OOD2';'ID2'})
ylim([0 0.4]);ylabel('absolute error');

%% 8. Figure 3A: bootstrap uncertainty
sensor = {'Gelsight','GelSlim','DIGIT','TacTip','BioTac','Roboskin','uskin','Shadow','Tekscan'};
cat =    {'opt'     ,'opt'    ,'opt'  ,'opt'   ,'capa'  ,'capa'    ,'mag'  ,'mag'   ,'piezo'  };
SR_sensor = [ 0.1   ,   1     ,  0.2  , 2.4    ,    2   ,   2      , 7.7   ,  5     ,0.2      ];
PS_sensor = [0.05   ,0.05     ,0.005  ,0.03    ,0.076   ,0.05      ,0.01   ,0.2     ,1        ].*0.102e3; %N/g [grams]
rng(0,'twister'); % Fixed seed for reproducibility (new).
B = 200;
% Log-spaced grid
xg2 = linspace(min([x1(mask);SR_sensor']), max([x1(mask);SR_sensor']), 60);
ylogg2 = linspace(min([y1(mask);log10(PS_sensor)']), max([y1(mask);log10(PS_sensor)']), 60);
[Xg2, Ylogg2] = meshgrid(xg2, ylogg2);
Zboot = zeros([numel(Xg2), B]);

for b = 1:B
    ib = randsample(size(X,1), size(X,1), true); % bootstrap indices
    Xb = X(ib,:);
    Zb = Z(ib);

    opts = fitoptions(ft);
    opts.StartPoint = [mean(Zb) 0 0 0 0];
    fb = fit(Xb, Zb, ft, opts);

    Zboot(:,b) = fb(Xg2(:), Ylogg2(:));
end

Zmean = reshape(mean(Zboot,2), size(Xg2));
Zstd  = reshape(std(Zboot,[],2), size(Xg2));   % uncertainty map

figure; hold on; box on;
surf(Xg2, 10.^Ylogg2, zeros(size(Zstd)), Zstd, 'EdgeColor','none');
view(2); % Preserve actual logarithmic grid spacing.
colormap gray
set(gca,'YScale','log'); axis tight;
set(gca, 'XAxisLocation', 'top');
set(gca, 'YDir', 'reverse');
xlabel('spatial resolution'); ylabel('pressure sensitivity');
title('Bootstrap uncertainty (std of prediction)');
colorbar; caxis([0 0.15])
ylim([1e-2 1e3])

% Overlay datapoints
mask = ~isnan(x1) & ~isnan(y1);
scatter(x1(mask), 10.^y1(mask), 10, 'w', 'filled', 'MarkerEdgeColor','k');
% scatter(X(OOD_pts,1),10.^X(OOD_pts,2),10,'k','filled', 'MarkerEdgeColor','k');
scatter(SR_sensor,PS_sensor,20,'r','filled')
text(SR_sensor+0.1,PS_sensor,sensor)

%% 9. Figure 3B: sensor map with iso-performance curves only
% Extend the analytical curves to cover the sensor locations.
xSensor = linspace(min([xPerformance,SR_sensor]),max([xPerformance,SR_sensor]),200);
ySensor = linspace(min([yPerformance,log10(PS_sensor)]),max([yPerformance,log10(PS_sensor)]),200);
[XS,YS] = meshgrid(xSensor,ySensor);
figure('Name','Figure 3B - Robotic tactile sensors'); hold on; box on;
[~,h1] = contour(XS,10.^YS,f1(XS,YS),levels,'k','LineWidth',1);
[~,h2] = contour(XS,10.^YS,f2(XS,YS),levels,'--k','LineWidth',1);
hs = scatter(SR_sensor,PS_sensor,30,'k','filled');
text(SR_sensor+0.1,PS_sensor,sensor);
set(gca,'YScale','log'); grid on;
xlabel('Spatial resolution [mm]'); ylabel('Force threshold [g]');
xlim([0 8]); ylim(10.^[min(ySensor),max(ySensor)]);
legend([h1,h2,hs],{'Task 1','Task 2','Robotic tactile sensors'},'Location','best');
