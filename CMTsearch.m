function CMTsearch(yr,mo,day,oyr,omo,oday,lmw,umw,llat,ulat,llon,ulon,lhd,uhd,b_depth)

%Searches the Global CMT archive using a URL.
%
%GlobalCMT
%Ekström, G., M. Nettles, and A. M. Dziewonski, The global CMT project 2004-2010: Centroid-moment tensors for 13,017 earthquakes, Phys. Earth Planet. Inter., 200-201, 1-9, 2012. doi:10.1016/j.pepi.2012.04.002
%
%Written by:
%Martin Pratt, 2015

R=6378.1; %in km
scaling=R/(R-b_depth);

itype='ymd';  %input start type ymd/jul
jyr='2014';   %start julian year
jday='1';     %start julian day
ojyr='2014';  %end julian year
ojday='1';    %end julian day
otype='ymd';  %input end type ymd/jul/nd
nday='1';     %use number of days after start (including starting day)
lmw=num2str(lmw);
umw=num2str(umw);
lms='0';      %min surface wave magnitude
ums='10';     %max surface wave magnitude
lmb='0';      %min body wave magnitude
umb='10';     %max body wave magnitude
llat=num2str(llat);
ulat=num2str(ulat);
llon=num2str(llon);
ulon=num2str(ulon);
lhd=num2str(lhd);
uhd=num2str(uhd);
lts='-9999';  %min centroid time shift (s)
uts='9999';   %max centroid time shift
lpe1='0';     %min tension axis plunge (0 to 90 degrees)
upe1='90';    %max tension axis plunge
lpe2='0';     %min null axis plunge (0 to 90 degrees)
upe2='90';    %max null axis plunge
%list='2';     %list format type 0=standard 1=list of event names 2=GMT psvelomeca 6=GMT psmeca 4=CMTSOLUTION 5=full

a1=urlread(['http://www.globalcmt.org/cgi-bin/globalcmt-cgi-bin/CMT4/form?itype=' itype '&yr=' yr '&mo=' mo '&day=' day '&oyr=' oyr '&omo=' omo '&oday=' oday '&jyr=' jyr '&jday=' jday '&ojyr=' ojyr '&ojday=' ojday '&otype=' otype '&nday=' nday '&lmw=' lmw '&umw=' umw '&lms=' lms '&ums=' ums '&lmb=' lmb '&umb=' umb '&llat=' llat '&ulat=' ulat '&llon=' llon '&ulon=' ulon '&lhd=' lhd '&uhd=' uhd '&lts=' lts '&uts=' uts '&lpe1=' lpe1 '&upe1=' upe1 '&lpe2=' lpe2 '&upe2=' upe2 '&list=2']);
a2=urlread(['http://www.globalcmt.org/cgi-bin/globalcmt-cgi-bin/CMT4/form?itype=' itype '&yr=' yr '&mo=' mo '&day=' day '&oyr=' oyr '&omo=' omo '&oday=' oday '&jyr=' jyr '&jday=' jday '&ojyr=' ojyr '&ojday=' ojday '&otype=' otype '&nday=' nday '&lmw=' lmw '&umw=' umw '&lms=' lms '&ums=' ums '&lmb=' lmb '&umb=' umb '&llat=' llat '&ulat=' ulat '&llon=' llon '&ulon=' ulon '&lhd=' lhd '&uhd=' uhd '&lts=' lts '&uts=' uts '&lpe1=' lpe1 '&upe1=' upe1 '&lpe2=' lpe2 '&upe2=' upe2 '&list=6']);

fid=fopen('cmtsearch1.txt','w');
fprintf(fid,a1);
fclose(fid);

fid=fopen('cmtsearch2.txt','w');
fprintf(fid,a2);
fclose(fid);

[s,w] = system('wc -l cmtsearch1.txt'); %#ok<*ASGLU>
[nlines fname] = strtok( w, ' '); %#ok<*NASGU>
Nrows1=str2double(nlines);
[s,w] = system('wc -l cmtsearch2.txt');
[nlines fname] = strtok( w, ' ');
Nrows2=str2double(nlines);

fid=fopen('cmtsearch1.txt');
a=textscan(fid,'%s',25,'delimiter','\n');
data=textscan(fid,'%f %f %f %f %f %f %f %f %f %f %s',Nrows1);
fclose(fid);

fid=fopen('cmtsearch2.txt');
a=textscan(fid,'%s',25,'delimiter','\n');
data1=textscan(fid,'%f %f %f %f %f %f %f %f %f %f %s %s %s',Nrows2);
fclose(fid);

H=data{1};
G=data{2};
I=data1{3};
P=data{3};
Q=data{4};
R=data{5};
name=data{11};
ne=numel(name);
ss=zeros(ne,1);
name=cell2mat(name);
dates=datestr([str2num(name(:,1:4)),str2num(name(:,5:6)),str2num(name(:,7:8)),str2num(name(:,9:10)),str2num(name(:,11:12)),ss]); %#ok<*ST2NM>
latlondep=[G,H,(b_depth-I).*1000.*scaling]; %centroid locations lat lon depth
sds=[P-270,Q-90,R.*-1]; %strike, dip, slip
disp(['Number of CMT solutions: ' num2str(length(data{1}))]);

fid=fopen('beachball.kml','w');
fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">\n');
fprintf(fid,'<Folder>\n');
fprintf(fid,'	<name>beachball</name>\n');
fprintf(fid,'	<open>1</open>\n');
fprintf(fid,'	<LookAt>\n');
fprintf(fid,'		<longitude>13.362</longitude>\n');
fprintf(fid,'		<latitude>42.326</latitude>\n');
fprintf(fid,'		<altitude>6355747.53</altitude>\n');
fprintf(fid,'		<heading>259.333684207</heading>\n');
fprintf(fid,'		<tilt>29.73159830921</tilt>\n');
fprintf(fid,'		<range>3.566164349464</range>\n');
fprintf(fid,'	</LookAt>\n');

for n=1:length(G);
    
fprintf(fid,'	<Placemark>\n');
fprintf(fid,'		<name>');
fprintf(fid,dates(n,:));
fprintf(fid,'</name>\n');
fprintf(fid,'		<description><![CDATA[\n');
fprintf(fid,'		<ul><li>Origin time: ');
fprintf(fid,dates(n,:));
fprintf(fid,'</li>\n');
fprintf(fid,'		<li>Depth: ');
fprintf(fid,num2str(I(n)));
fprintf(fid,'</li>\n');
fprintf(fid,'		<li>Strike: ');
fprintf(fid,num2str(P(n)));
fprintf(fid,'		<li> Dip: ');
fprintf(fid,num2str(Q(n)));
fprintf(fid,'		<li> Rake: ');
fprintf(fid,num2str(R(n)));
fprintf(fid,'</li>\n');
fprintf(fid,'		<li>Source: GlobalCMT Project</li>\n');
fprintf(fid,'		</ul>\n');
fprintf(fid,'		]]>\n');
fprintf(fid,'		</description>\n');
fprintf(fid,'		<Model id="model_5">\n');
fprintf(fid,'			<altitudeMode>absolute</altitudeMode>\n');
fprintf(fid,'			<Location>\n');
fprintf(fid,'				<longitude>');
fprintf(fid,num2str(latlondep(n,2)));
fprintf(fid,'</longitude>\n');
fprintf(fid,'				<latitude>');
fprintf(fid,num2str(latlondep(n,1)));
fprintf(fid,'</latitude>\n');
fprintf(fid,'				<altitude>');
fprintf(fid,num2str(latlondep(n,3)));
fprintf(fid,'</altitude>\n');
fprintf(fid,'			</Location>\n');
fprintf(fid,'			<Orientation>\n');
fprintf(fid,'				<heading>');
fprintf(fid,num2str(sds(n,1)));
fprintf(fid,'</heading>\n');
fprintf(fid,'				<tilt>');
fprintf(fid,num2str(sds(n,2)));
fprintf(fid,'</tilt>\n');
fprintf(fid,'				<roll>');
fprintf(fid,num2str(sds(n,3)));
fprintf(fid,'</roll>\n');
fprintf(fid,'			</Orientation>\n');
fprintf(fid,'			<Scale>\n');
fprintf(fid,'				<x>100000</x>\n');
fprintf(fid,'				<y>100000</y>\n');
fprintf(fid,'				<z>100000</z>\n');
fprintf(fid,'			</Scale>\n');
fprintf(fid,'			<Link>\n');
fprintf(fid,'				<href>beachball.dae</href>\n');
fprintf(fid,'			</Link>\n');
fprintf(fid,'			<ResourceMap>\n');
fprintf(fid,'			</ResourceMap>\n');
fprintf(fid,'		</Model>\n');
fprintf(fid,'	</Placemark>\n');
end
fprintf(fid,'</Folder>\n');
fprintf(fid,'</kml>\n');

%tidy up
delete cmtsearch1.txt
delete cmtsearch2.txt
end