%% Mechanical degradation: Figure 1C and reported statistics
% Task 1: reorientation (120 s); Task 2: screwing (90 s).
% Requires Statistics and Machine Learning Toolbox.
% Original measurements and condition ordering are retained for reproduction.
% See notes below on participant 5 and discrepancies with the workbook.
clearvars; close all; clc;

%% 1. Experimental data
% Each cell contains two tasks (rows) and six trials (columns).
% First column: bare finger. Remaining columns: experimental order.
% Condition codes: 1=2 mm HF, 2=1 mm HF, 3=0 mm HF,
%                  4=2 mm LF, 5=0 mm LF.
% P7: workbook condition labels differ from original script; verify source.
%P1
scores{1,1}(:,1) = [25*120/77,16]; %bare
scores{1,1}(:,2) = [4,0]; %1mm
scores{1,1}(:,3) = [1,0]; %LF
scores{1,1}(:,4) = [9,2]; %2mm
scores{1,1}(:,5) = [2,1]; %2mmLF
scores{1,1}(:,6) = [4,0]; %HF
order(1,:) = [2,5,1,4,3];

%P2
scores{2,1}(:,1) = [25*120/57,21]; %bare
scores{2,1}(:,2) = [8,1]; %2mmLF
scores{2,1}(:,3) = [15,2]; %1mm
scores{2,1}(:,4) = [4,0]; %LF
scores{2,1}(:,5) = [21,4]; %2mm
scores{2,1}(:,6) = [15,0]; %HF
order(2,:) = [4,2,5,1,3];

%P3
scores{3,1}(:,1) = [25*120/90,16]; %bare
scores{3,1}(:,2) = [1,0]; %LF
scores{3,1}(:,3) = [11,2]; %2mm
scores{3,1}(:,4) = [10,2]; %1mm
scores{3,1}(:,5) = [4,1]; %2mmLF
scores{3,1}(:,6) = [4,1]; %HF
order(3,:) = [5,1,2,4,3];

%P4
scores{4,1}(:,1) = [25*120/69,21]; %bare
scores{4,1}(:,2) = [1,1]; %2mmLF
scores{4,1}(:,3) = [7,4]; %1mm
scores{4,1}(:,4) = [1,0]; %LF
scores{4,1}(:,5) = [7,3]; %2mm
scores{4,1}(:,6) = [6,0]; %HF
order(4,:) = [4,2,5,1,3];

%P5
scores{5,1}(:,1) = [25*120/54,19]; %bare
scores{5,1}(:,2) = [10,3]; %HF
scores{5,1}(:,3) = [3,0]; %LF
scores{5,1}(:,4) = [13,2]; %1mm
scores{5,1}(:,5) = [8,4]; %2mm
scores{5,1}(:,6) = [7,1]; %2mmLF
order(5,:) = [3,5,2,1,4];

%P6
scores{6,1}(:,1) = [25*120/71,19]; %bare
scores{6,1}(:,2) = [1,2]; %HF
scores{6,1}(:,3) = [8,5]; %2mm
scores{6,1}(:,4) = [0,0]; %LF
scores{6,1}(:,5) = [6,6]; %1mm
scores{6,1}(:,6) = [4,1]; %2mmLF
order(6,:) = [3,1,5,2,4];

%P7
scores{7,1}(:,1) = [25*120/70,18]; %bare
scores{7,1}(:,2) = [0,0]; %LF
scores{7,1}(:,3) = [9,2]; %1mm
scores{7,1}(:,4) = [0,1]; %2mmLF
scores{7,1}(:,5) = [8,1]; %HF
scores{7,1}(:,6) = [13,6]; %2mm
order(7,:) = [5,2,4,3,1];

%P8
scores{8,1}(:,1) = [25*120/77,12]; %bare
scores{8,1}(:,2) = [12,3]; %2mm
scores{8,1}(:,3) = [4,2]; %HF
scores{8,1}(:,4) = [9,3]; %1mm
scores{8,1}(:,5) = [2,0]; %LF
scores{8,1}(:,6) = [6,1]; %2mmLF
order(8,:) = [1,3,2,5,4];

%% 2. Normalize throughput and reorder conditions
nParticipants = numel(scores);
conditions = {'HC-HF','MC-HF','LC-HF','HC-LF','LC-LF'};
[~,order_idx] = sort(order,2);
scores1_cots = nan(5,nParticipants);
scores2_cots = nan(5,nParticipants);
for pp = 1:nParticipants
    normalized = scores{pp}(:,order_idx(pp,:)+1)./scores{pp}(:,1);
    scores1_cots(:,pp) = normalized(1,:)';
    scores2_cots(:,pp) = normalized(2,:)';
end

%% 3. Figure 1C: Mechanical degradation
figure('Name','Figure 1C - Mechanical degradation','Color','w');

order_plot = [1,5,3,2,4];

data1 = scores1_cots(order_plot,:)';   % reorientation
data2 = scores2_cots(order_plot,:)';   % screwing
data_all = [data1; data2];

% Explicit labels in exactly the same order as the columns
labels = conditions(order_plot);

% Boxplot
boxplot(data_all, 'Labels', labels, ...
    'Colors',[0.25 0.35 0.7], ...
    'Symbol','');

hold on

% Individual points
for c = 1:size(data_all,2)

    % Reorientation
    scatter(repmat(c-0.04, size(data1,1),1), ...
        data1(:,c), 30, 'o', ...
        'filled', ...
        'MarkerFaceAlpha',0.5);

    % Screwing
    scatter(repmat(c+0.04, size(data2,1),1), ...
        data2(:,c), 35, '^', ...
        'filled', ...
        'MarkerFaceAlpha',0.5);
end

ylabel('Normalized task throughput')

ylim([0 1])
box off
set(gca,'FontSize',12)

%% 4. Reported mixed-effects model (reorientation task)
% Preserve original exclusion of P5; reason must be confirmed by authors.
% Original model is additive, without a friction-compliance interaction.
included = [1:4,6:nParticipants];
perf1 = reshape(scores1_cots(:,included),[],1);
friction = categorical(repmat({'high';'high';'high';'low';'low'},numel(included),1));
compliance = categorical(repmat({'high';'med';'low';'high';'low'},numel(included),1));
subj = categorical(repelem(compose("P%02d",included(:)),5));
T1 = table(perf1,friction,compliance,subj);

% Mixed model: random intercept per subject
lme = fitlme(T1, 'perf1 ~ friction + compliance + (1|subj)');
disp(lme);
anovaTbl = anova(lme,'DFMethod','Satterthwaite')

terms   = anovaTbl.Term;
F       = anovaTbl.FStat;
df1     = anovaTbl.DF1;
df2     = anovaTbl.DF2;

% Residual Mean Square:
MS_res = lme.MSE;
df_resid = max(df2);

% ---- Sum of squares for each effect ----
idx_fric = strcmp(terms,'friction');
idx_comp = strcmp(terms,'compliance');

SS_friction   = F(idx_fric)   * MS_res * df1(idx_fric);
SS_compliance = F(idx_comp)   * MS_res * df1(idx_comp);
SS_residual   = MS_res * df_resid;

SS_total = SS_friction + SS_compliance + SS_residual;
% Eta squared: proportion of (effect + residual) variance
eta2_friction   = SS_friction   / SS_total;
eta2_compliance = SS_compliance / SS_total;

% Partial eta squared: effect vs. effect+residual
eta2p_friction   = SS_friction   / (SS_friction   + SS_residual);
eta2p_compliance = SS_compliance / (SS_compliance + SS_residual);

fprintf('\n=== Eta-squared (%% of total variance) ===\n');
fprintf('Friction:   %.1f %%\n', 100*eta2_friction);
fprintf('Compliance: %.1f %%\n', 100*eta2_compliance);

fprintf('\n=== Partial eta-squared (effect size) ===\n');
fprintf('Friction:   %.1f %%\n', 100*eta2p_friction);
fprintf('Compliance: %.1f %%\n', 100*eta2p_compliance);



