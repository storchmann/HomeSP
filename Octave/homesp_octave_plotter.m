# HomeSP Octave Plotter
close all
format long g

# LogFileName, Naming, SubPlot
SensorLogs = {
'Sensor_28-D8-29-23-03-00-00-6C_2011.log', 'Warmwasser', 		1, [204,000,000]/255;
'Sensor_28-44-5C-23-03-00-00-1F_2011.log', 'Warmwasseraustausch', 	1, [204,204,000]/255;
'Sensor_28-6E-19-23-03-00-00-5D_2011.log', 'Heizung kalt', 		2, [102,102,255]/255;
'Sensor_28-A3-22-23-03-00-00-7C_2011.log', 'Heizung warm', 		2, [255,102,102]/255;
};


figure

for SensorLog = 1:size(SensorLogs,1)
	M=csvread(cell2mat(SensorLogs(SensorLog,1)) );

	index_zeros = find(M(:,4) < 10);

	t=M(:,1);
	t(index_zeros) = [];
	t_now = 86400*(datenum(date(now)) - datenum(1970,1,1));
	t_h_delta = (t - t_now) / (3600);
	t_h_max = ceil(max(t_h_delta));
	
	y=M(:,4);
	y(index_zeros) = [];

	subplot(2,1,cell2mat(SensorLogs(SensorLog,3)) )
	p = plot(t_h_delta,y);
	hold on;
	set(p,'Color',cell2mat(SensorLogs(SensorLog,4)),'LineWidth',2)
	legend(cell2mat(SensorLogs(SensorLog,2)));

	xtick_t = (-24:1:0) + t_h_max;
	set(gca,'XTick',xtick_t');

	labels = xtick_t;
	labels(labels < 0) = labels(labels < 0) + 24;
	set(gca,'XTickLabel',num2str(labels',"%1.0f"))

	grid on
end

