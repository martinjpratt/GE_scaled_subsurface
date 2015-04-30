function regional_earthquake(latmin,latmax,lonmin,lonmax,b_depth,output_file,minmag,maxmag,mindepth,maxdepth,startTime,endTime,src_loc,input_file)

R=6378.1; %in km
scaling=R/(R-b_depth);

if src_loc==1
    ev = irisFetch.Events('startTime',startTime,'endTime',endTime,'minimumMagnitude',minmag,'maximumMagnitude',maxmag,'minimumDepth',mindepth,'maximumDepth',maxdepth,'minimumLatitude',latmin,'maximumLatitude',latmax,'minimumLongitude',lonmin,'maximumLongitude',lonmax);
    lonlatdep=[[ev.PreferredLongitude]' [ev.PreferredLatitude]' (b_depth-[ev.PreferredDepth]').*1000.*scaling];
    depth=[ev.PreferredDepth]';
    mag=zeros(length(ev),1);
    timestamp=[];
    for n=1:length(ev)
        mag(n)=ev(n).PreferredMagnitude.Value;
        timestamp=[timestamp;datenum(ev(n).PreferredOrigin.Time)]; %#ok<*AGROW>
    end
    timestamp=datestr(timestamp,'yyyy-mm-ddTHH:MM:SSZ');
elseif src_loc==2
    disp(['Importing data from: ' input_file])
    a=importdata(input_file);
    b=[];
    for n=1:length(a)
        if a(n,7) == 0 || a(n,7) == -999 || a(n,8) == 0 || a(n,8) == -999
            continue
        else
            b=[b;a(n,:)];
        end
    end

    lonlatdep=[b(:,8) b(:,7) (b_depth-b(:,9)).*1000.*scaling];
    timestamp=datenum(num2str([b(:,3) b(:,2) b(:,1) b(:,4) b(:,5) b(:,6)]),'yyyy mm dd HH MM SS');
    timestamp=datestr(timestamp,'yyyy-mm-ddTHH:MM:SSZ');
    depth=b(:,9);
    mag=b(:,10);
end

fid=fopen([output_file '.kml'],'w');
fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">\n');
fprintf(fid,'<Folder>\n');
fprintf(fid,'	<name>eqs</name>\n');
fprintf(fid,'	<LookAt>\n');
fprintf(fid,'		<longitude>-105.2421177493</longitude>\n');
fprintf(fid,'		<latitude>40.01832839721</latitude>\n');
fprintf(fid,'		<altitude>5.420710762655</altitude>\n');
fprintf(fid,'		<heading>334.8495050066</heading>\n');
fprintf(fid,'		<tilt>81.70332356774</tilt>\n');
fprintf(fid,'		<range>24.53937340185</range>\n');
fprintf(fid,'	</LookAt>\n');

s=size(lonlatdep);
for n=1:s(1)
fprintf(fid,'	<Placemark>\n');
fprintf(fid,'		<name>Model</name>\n');
fprintf(fid,'		<Style id="default">\n');
fprintf(fid,'		</Style>\n');
fprintf(fid,'			<LookAt>\n');
fprintf(fid,'				<longitude>');
fprintf(fid,'%f',lonlatdep(n,1));
fprintf(fid,'</longitude>\n');
fprintf(fid,'				<latitude>');
fprintf(fid,'%f',lonlatdep(n,2));
fprintf(fid,'</latitude>\n');
fprintf(fid,'				<altitude>');
fprintf(fid,'%f',lonlatdep(n,3));
fprintf(fid,'</altitude>\n');
fprintf(fid,'				<heading>-6.864197277574752</heading>\n');
fprintf(fid,'				<tilt>0</tilt>\n');
fprintf(fid,'				<range>1498344.725268982</range>\n');
fprintf(fid,'				<gx:altitudeMode>absolute</gx:altitudeMode>\n');
fprintf(fid,'			</LookAt>\n');

fprintf(fid,'		<Model id="model_2">\n');
fprintf(fid,'			<altitudeMode>absolute</altitudeMode>\n');
fprintf(fid,'			<Location>\n');
fprintf(fid,'				<longitude>');
fprintf(fid,'%f',lonlatdep(n,1));
fprintf(fid,'</longitude>\n');
fprintf(fid,'				<latitude>');
fprintf(fid,'%f',lonlatdep(n,2));
fprintf(fid,'</latitude>\n');
fprintf(fid,'				<altitude>');
fprintf(fid,'%f',lonlatdep(n,3));
fprintf(fid,'</altitude>\n');
fprintf(fid,'			</Location>\n');
fprintf(fid,'			<Orientation>\n');
fprintf(fid,'				<heading>-0</heading>\n');
fprintf(fid,'				<tilt>0</tilt>\n');
fprintf(fid,'				<roll>0</roll>\n');
fprintf(fid,'			</Orientation>\n');
fprintf(fid,'			<Scale>\n');

if depth(n) <= 100 %yellow
    if mag(n) >= 9
        fprintf(fid,'				<x>10000</x>\n');
        fprintf(fid,'				<y>10000</y>\n');
        fprintf(fid,'				<z>10000</z>\n');
    elseif mag(n) >= 8 && mag(n) < 9
        fprintf(fid,'				<x>8000</x>\n');
        fprintf(fid,'				<y>8000</y>\n');
        fprintf(fid,'				<z>8000</z>\n');
    elseif mag(n) >= 7 && mag(n) < 8
        fprintf(fid,'				<x>6000</x>\n');
        fprintf(fid,'				<y>6000</y>\n');
        fprintf(fid,'				<z>6000</z>\n');
    elseif mag(n) >= 6 && mag(n) < 7
        fprintf(fid,'				<x>4000</x>\n');
        fprintf(fid,'				<y>4000</y>\n');
        fprintf(fid,'				<z>4000</z>\n');
    else
        fprintf(fid,'				<x>3000</x>\n');
        fprintf(fid,'				<y>3000</y>\n');
        fprintf(fid,'				<z>3000</z>\n');
    end
    fprintf(fid,'			</Scale>\n');
    fprintf(fid,'			<Link>\n');
    fprintf(fid,'				<href>shallow.dae</href>\n');
    fprintf(fid,'			</Link>\n');
elseif depth(n) < 400 && depth(n) > 100 %orange
    if mag(n) >= 9
        fprintf(fid,'				<x>10000</x>\n');
        fprintf(fid,'				<y>10000</y>\n');
        fprintf(fid,'				<z>10000</z>\n');
    elseif mag(n) >= 8 && mag(n) < 9
        fprintf(fid,'				<x>8000</x>\n');
        fprintf(fid,'				<y>8000</y>\n');
        fprintf(fid,'				<z>8000</z>\n');
    elseif mag(n) >= 7 && mag(n) < 8
        fprintf(fid,'				<x>6000</x>\n');
        fprintf(fid,'				<y>6000</y>\n');
        fprintf(fid,'				<z>6000</z>\n');
    elseif mag(n) >= 6 && mag(n) < 7
        fprintf(fid,'				<x>4000</x>\n');
        fprintf(fid,'				<y>4000</y>\n');
        fprintf(fid,'				<z>4000</z>\n');
    else
        fprintf(fid,'				<x>3000</x>\n');
        fprintf(fid,'				<y>3000</y>\n');
        fprintf(fid,'				<z>3000</z>\n');
    end
    fprintf(fid,'			</Scale>\n');
    fprintf(fid,'			<Link>\n');
    fprintf(fid,'				<href>intermediate.dae</href>\n');
    fprintf(fid,'			</Link>\n');
else    %red
    if mag(n) >= 9
        fprintf(fid,'				<x>10000</x>\n');
        fprintf(fid,'				<y>10000</y>\n');
        fprintf(fid,'				<z>10000</z>\n');
    elseif mag(n) >= 8 && mag(n) < 9
        fprintf(fid,'				<x>8000</x>\n');
        fprintf(fid,'				<y>8000</y>\n');
        fprintf(fid,'				<z>8000</z>\n');
    elseif mag(n) >= 7 && mag(n) < 8
        fprintf(fid,'				<x>6000</x>\n');
        fprintf(fid,'				<y>6000</y>\n');
        fprintf(fid,'				<z>6000</z>\n');
    elseif mag(n) >= 6 && mag(n) < 7
        fprintf(fid,'				<x>4000</x>\n');
        fprintf(fid,'				<y>4000</y>\n');
        fprintf(fid,'				<z>4000</z>\n');
    else
        fprintf(fid,'				<x>3000</x>\n');
        fprintf(fid,'				<y>3000</y>\n');
        fprintf(fid,'				<z>3000</z>\n');
    end
    fprintf(fid,'			</Scale>\n');
    fprintf(fid,'			<Link>\n');
    fprintf(fid,'				<href>deep.dae</href>\n');
    fprintf(fid,'			</Link>\n');
end

fprintf(fid,'			<ResourceMap>\n');
fprintf(fid,'			</ResourceMap>\n');
fprintf(fid,'		</Model>\n');
fprintf(fid,'            <TimeStamp>\n');
fprintf(fid,'                <when>');
fprintf(fid,'%s',char(timestamp(n,:)));
fprintf(fid,'</when>\n');
fprintf(fid,'            </TimeStamp>\n');
fprintf(fid,'	</Placemark>\n');
end
fprintf(fid,'</Folder>\n');
fprintf(fid,'</kml>\n');
fclose(fid);
