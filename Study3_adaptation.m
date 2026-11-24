% Supplementary figure: sensory adaptation and bare-finger after-effects.
% Run this script to generate the four-panel figure and statistical results.
% Requires MATLAB with Statistics and Machine Learning Toolbox.
clearvars; close all;

%% 1. Experimental data
% Monofilament codes and corresponding nominal forces (g).
MF = [1.65,	2.36, 2.44, 2.83, 3.22, 3.61, 3.84, 4.08, 4.17, 4.31, 4.56, 4.74, 4.93, 5.07, 5.18, 5.46, 5.88, 6.1, 6.45, 6.65];
Force = [0.008, 0.02, 0.04, 0.07, 0.16, 0.4, 0.6, 1, 1.4, 2, 4, 6, 8, 10, 15, 26, 60, 100, 180, 300]; %g

% Strong cot: rows = participants P1–P16; columns = measurements 1–3.
strongSpatial = [
    7.55 7.14 7.59; % P1
    7.25 7.67 6.93; % P2
    7.85 7.78 7.15; % P3
    6.20 6.78 6.32; % P4
    7.38 7.86 4.95; % P5
    7.74 7.23 5.54; % P6
    7.17 5.36 6.00; % P7
    6.31 7.70 4.28; % P8
    7.62 6.94 6.39; % P9
    7.27 6.75 NaN; % P10
    7.38 7.85 7.38; % P11
    NaN NaN NaN; % P12
    6.80 5.09 5.50; % P13
    7.79 6.59 5.77; % P14
    7.05 7.28 NaN; % P15
    7.62 7.25 NaN; % P16
];

% Strong cot: rows = participants P1–P16; columns = measurements 1–3.
strongCodes = [
    4.93 3.84 3.84; % P1
    4.93 4.56 4.56; % P2
    5.46 4.93 4.93; % P3
    5.07 4.93 4.93; % P4
    4.74 4.56 4.56; % P5
    4.56 4.31 4.17; % P6
    3.22 3.22 3.22; % P7
    4.74 4.74 4.74; % P8
    4.56 4.56 4.56; % P9
    3.22 3.22 3.22; % P10
    4.17 3.84 3.84; % P11
    NaN NaN NaN; % P12
    4.74 4.74 4.74; % P13
    4.56 4.56 4.56; % P14
    3.84 3.84 3.84; % P15
    4.56 4.56 4.56; % P16
];

% Other cot: rows = participants P1–P16; columns = measurements 1–3.
otherSpatial = [
    4.89 4.59 3.92; % P1
    2.88 3.33 1.89; % P2
    1.12 1.53 1.00; % P3
    1.86 0.83 1.98; % P4
    5.89 5.82 5.59; % P5
    1.1 1.61 0.94; % P6
    2.67 1.63 2.43; % P7
    4.71 3.95 4.05; % P8
    6.28 5.75 4.89; % P9
    2.76 2.05 2.27; % P10
    2.28 2.02 2.8; % P11
    7.92 7.91 5.17; % P12
    1.71 1.96 1.15; % P13
    2.50 3.40 1.59; % P14
    3.16 2.32 5.54; % P15
    5.56 6.41 3.82; % P16
];

% Other cot: rows = participants P1–P16; columns = measurements 1–3.
otherCodes = [
    2.44 2.36 2.36; % P1
    2.83 2.44 2.36; % P2
    3.22 2.83 2.83; % P3
    2.44 2.44 4.08; % P4
    2.83 2.44 2.44; % P5
    2.44 2.44 2.83; % P6
    2.36 2.36 2.36; % P7
    4.31 4.17 4.17; % P8
    2.83 2.83 2.83; % P9
    2.36 2.36 2.36; % P10
    2.44 3.22 3.22; % P11
    3.61 2.83 2.83; % P12
    2.36 2.36 2.36; % P13
    2.83 2.44 2.44; % P14
    2.83 3.22 2.44; % P15
    3.84 3.61 3.61; % P16
];

% Additional bare-finger manipulation data (six participants)
% Columns = 6 participants. Rows 1:3 = consecutive measurements during
% manipulation; row 4 = post-manipulation measurement (after-effect).
GO_bare_manip = [0.88 1.32 1.33 1.77 0.83 1.11; ...
                 1.11 2.43 2.17 0.91 0.83 2.12; ...
                 1.38 0.79 1.21 1.11 0.75 3.31; ...
                 1.03 1.38 0.96 0.83 0.87 2.42];
MF_bare_codes = [1.65 2.36 2.36 2.36 2.36 2.36; ...
                 1.65 2.36 2.36 2.36 1.65 2.36; ...
                 1.65 2.36 2.36 1.65 1.65 2.36; ...
                 1.65 1.65 2.36 1.65 1.65 1.65];

%% 2. Preprocessing and experimental groups
strongForce = convertForce(strongCodes, MF, Force);
otherForce = convertForce(otherCodes, MF, Force);
MF_bare_manip = convertForce(MF_bare_codes, MF, Force);
bareManipForce = MF_bare_manip(1:3,:)';
bareManipSpatial = GO_bare_manip(1:3,:)';

manip=[1:6,11:12]; control=[7:10,13:16];
noncompress=[1:3,5,8:9,12,16]; % P1 P2 P3 P5 P8 P9 P12 P16
compress=[4,6:7,10:11,13:15];  % P4 P6 P7 P10 P11 P13 P14 P15
% Preserve group membership from the revised figure, including P15.

%% 3. Figure layout and plotting
purple=[0.43 0.23 0.64]; grey=[0.35 0.38 0.42];
blue=[0.12 0.42 0.75]; rose=[0.73 0.27 0.46];
time=[0 90 180];
fig=figure('Color','w','Position',[80 80 1320 900]);
t=tiledlayout(fig,2,2,'TileSpacing','loose','Padding','compact');

%% A. Experimental sequence (schematic)
axA=nexttile(t,1); hold(axA,'on'); axis(axA,[0 10 0 5]); axis(axA,'off');
steps={'Bare finger','Cot exposure 1','Cot exposure 2','Bare finger'};
subs={'Baseline','0 / 90 / 180 s','0 / 90 / 180 s','After exposure'};
for k=1:4
    x=0.25+(k-1)*2.55;
    if k==1 || k==4, bg=[0.88 0.90 0.93]; else, bg=[0.81 0.92 0.91]; end
    rectangle(axA,'Position',[x 1.8 2.05 1.7],'Curvature',0.12,'FaceColor',bg,'EdgeColor','none');
    text(axA,x+1.025,2.85,steps{k},'HorizontalAlignment','center','FontWeight','bold','FontSize',11);
    text(axA,x+1.025,2.35,subs{k},'HorizontalAlignment','center','FontSize',10);
    if k<4
        quiver(axA,x+2.08,2.65,0.39,0,0,'Color',[0.25 0.25 0.25], ...
            'MaxHeadSize',0.8,'LineWidth',1.4);
    end
end
text(axA,5,0.95,'Sensory measurements repeated during each cot exposure', ...
    'HorizontalAlignment','center','FontSize',10);
title(axA,'A   Experimental sequence','FontWeight','bold','FontSize',14);

%% B. Strongest sensory degradation: force AND spatial acuity
% Two vertically stacked plots for the same active/passive groups.
axB=nexttile(t,2); axis(axB,'off');
title(axB,'B   Highest sensory degradation','FontSize',14);
posB=axB.Position;
left=posB(1)+0.16*posB(3);
width=0.78*posB(3);
height=0.34*posB(4);

% B1: Force detection threshold relative to each participant at 0 s.
aB1=axes('Position',[left,posB(2)+0.56*posB(4),width,height]); hold(aB1,'on');
relStrong=strongForce ./ strongForce(:,1);
plotGroup(aB1,time,relStrong(manip,:),purple,0);
plotGroup(aB1,time,relStrong(control,:),grey,0);
yline(aB1,1,':','Color',[0.55 0.55 0.55],'HandleVisibility','off');
set(aB1,'YScale','log','XTick',time,'XLim',[-10 190]);
ylabel(aB1,'Force / initial');
legend(aB1,{'Active manipulation','Passive waiting'}, ...
    'Location','northeast','Box','off','FontSize',8);
styleAxes(aB1);

% B2: Absolute change in spatial resolution, in mm (not a ratio).
aB2=axes('Position',[left,posB(2)+0.10*posB(4),width,height]); hold(aB2,'on');
changeStrongSpatial=strongSpatial-strongSpatial(:,1);
plotGroup(aB2,time,changeStrongSpatial(manip,:),purple,0);
plotGroup(aB2,time,changeStrongSpatial(control,:),grey,0);
yline(aB2,0,':','Color',[0.55 0.55 0.55],'HandleVisibility','off');
set(aB2,'XTick',time,'XLim',[-10 190]);
ylabel(aB2,'Spatial change (mm)');
xlabel(aB2,'Exposure time (s)');
styleAxes(aB2);

%% C. Other cots and bare-finger manipulation: 2 rows x 3 columns
axC=nexttile(t,3); axis(axC,'off');
title(axC,'C   Other cots and bare-finger manipulation','FontSize',14);
pos=axC.Position;
w=pos(3)*0.255; h=pos(4)*0.34;
xx=pos(1)+pos(3)*[0.11 0.405 0.70];
yy=[pos(2)+0.54*pos(4),pos(2)+0.10*pos(4)];
for col=1:3
    if col==1
        ids=noncompress; clr=blue; nm='Non-compressing';
        x=time; forceVals=otherForce(ids,:)./otherForce(ids,1);
        spatialVals=otherSpatial(ids,:)-otherSpatial(ids,1);
    elseif col==2
        ids=compress; clr=rose; nm='Compressing';
        x=time; forceVals=otherForce(ids,:)./otherForce(ids,1);
        spatialVals=otherSpatial(ids,:)-otherSpatial(ids,1);
    else
        clr=grey; nm='Bare finger'; x=1:3;
        forceVals=bareManipForce./bareManipForce(:,1);
        spatialVals=bareManipSpatial-bareManipSpatial(:,1);
    end
    a=axes('Position',[xx(col),yy(1),w,h]); hold(a,'on');
    plotGroup(a,x,forceVals,clr,0);
    yline(a,1,':','Color',[0.55 0.55 0.55],'HandleVisibility','off');
    set(a,'YScale','log');
    ylim([0.1 10])
    if col<3
        set(a,'XTick',time,'XLim',[-10 190]);
    else
        set(a,'XTick',1:3,'XTickLabel',{'1','2','3'},'XLim',[0.8 3.2]);
    end
    if col==1, ylabel(a,'Force / initial'); end
    title(a,nm,'FontSize',10); styleAxes(a);

    a=axes('Position',[xx(col),yy(2),w,h]); hold(a,'on');
    plotGroup(a,x,spatialVals,clr,0);
    yline(a,0,':','Color',[0.55 0.55 0.55],'HandleVisibility','off');
    if col<3
        set(a,'XTick',time,'XLim',[-10 190]);
        xlabel(a,'Time (s)');
    else
        set(a,'XTick',1:3,'XTickLabel',{'1','2','3'},'XLim',[0.8 3.2]);
        xlabel(a,'Measurement number');
    end
    if col==1, ylabel(a,'Spatial change (mm)'); end
    ylim([-2.2 2.2])
    styleAxes(a);
end

%% D. Bare finger after-effect: BOTH force and spatial resolution
% Matches bare_finger_adapt.m: post measurement minus the mean of the
% first three consecutive measurements. Force change is relative;
% spatial-resolution change is absolute (mm).
barePreForce=mean(MF_bare_manip(1:3,:),1,'omitnan');
barePostForce=MF_bare_manip(4,:);
barePreSpatial=mean(GO_bare_manip(1:3,:),1,'omitnan');
barePostSpatial=GO_bare_manip(4,:);
bareForceAfter=(barePostForce-barePreForce)./barePreForce;
bareSpatialAfter=barePostSpatial-barePreSpatial;
axD=nexttile(t,4); axis(axD,'off');
title(axD,'D   Bare-finger after-effects','FontSize',14);
posD=axD.Position;
axD1=axes('Position',[posD(1)+.15*posD(3),posD(2)+.57*posD(4), ...
                     .77*posD(3),.28*posD(4)]); hold(axD1,'on');
plotAfterEffect(axD1,bareForceAfter,purple);
ylabel(axD1,'Force change / pre');
styleAxes(axD1);
axD2=axes('Position',[posD(1)+.15*posD(3),posD(2)+.13*posD(4), ...
                     .77*posD(3),.28*posD(4)]); hold(axD2,'on');
plotAfterEffect(axD2,bareSpatialAfter,blue);
ylabel(axD2,'Spatial change (mm)');
xlabel(axD2,'After minus mean of measurements 1–3');
styleAxes(axD2);

%% 4. Statistical comparisons
[~,pActive]=ttest(relStrong(manip,2)-1);
[~,pPassive]=ttest(relStrong(control,2)-1);
[~,pBetween]=ttest2(relStrong(manip,2)-1,relStrong(control,2)-1);
[~,pBareForce]=ttest(bareForceAfter);
[~,pBareSpatial]=ttest(bareSpatialAfter);
fprintf('Strong cot: active 0 vs 90 s p=%.4g; passive p=%.4g; between-group change p=%.4g\n',pActive,pPassive,pBetween);
[~,pSpatialActive]=ttest(changeStrongSpatial(manip,2));
[~,pSpatialPassive]=ttest(changeStrongSpatial(control,2));
[~,pSpatialBetween]=ttest2(changeStrongSpatial(manip,2),changeStrongSpatial(control,2));
fprintf('Spatial acuity (strong cot), 0 to 90 s: active p=%.4g; passive p=%.4g; between-group p=%.4g\n',pSpatialActive,pSpatialPassive,pSpatialBetween);
fprintf('Bare finger after-effect (n=%d): relative force p=%.4g; spatial change p=%.4g\n',numel(bareForceAfter),pBareForce,pBareSpatial);


%% Local functions
function values = convertForce(codes, MF, Force)
    values = nan(size(codes));
    valid = ~isnan(codes);
    [found, idx] = ismember(codes(valid), MF);
    assert(all(found), 'Unknown monofilament code.');
    values(valid) = Force(idx);
end
function plotGroup(ax,time,vals,color,xoffset)
    % vals: participant x time. Missing observations are ignored.
    for i=1:size(vals,1)
        plot(ax,time+xoffset,vals(i,:),'o-','Color',0.72*[1 1 1]+0.28*color, ...
            'MarkerSize',3,'LineWidth',0.8,'HandleVisibility','off');
    end
    mu=mean(vals,1,'omitnan');
    nn=sum(isfinite(vals),1);
    se=std(vals,0,1,'omitnan')./sqrt(nn);
    errorbar(ax,time+xoffset,mu,se,'o-','Color',color, ...
        'MarkerFaceColor',color,'MarkerSize',6,'LineWidth',2, ...
        'CapSize',6,'HandleVisibility','off');
    % Dummy legend handle, if needed by parent plot.
    plot(ax,nan,nan,'o-','Color',color,'LineWidth',2,'MarkerFaceColor',color);
end
function styleAxes(ax)
    set(ax,'Box','off','FontSize',10,'LineWidth',1,'TickDir','out');
end

function plotAfterEffect(ax,values,color)
    values=values(isfinite(values));
    x=1:numel(values);
    scatter(ax,x,values,28,'MarkerFaceColor',[.73 .73 .73], ...
        'MarkerEdgeColor','none');
    yline(ax,0,':','Color',[.45 .45 .45]);
    mu=mean(values);
    se=std(values)/sqrt(numel(values));
    errorbar(ax,(numel(values)+1)/2,mu,se,'o','Color',color, ...
        'MarkerFaceColor',color,'LineWidth',2,'CapSize',8,'MarkerSize',7);
    set(ax,'XTick',[],'XLim',[0 numel(values)+1]);
end
