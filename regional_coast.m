function regional_coast(latmin,latmax,lonmin,lonmax,b_depth)

%Creates a KML for the coastlines within the latitude and longitude 
%boundary limits. Requires the file coast.mat in the path which should be
%standard if the Matlab Mapping Toolbox is installed.
%
%Written by:
%Martin Pratt, 2015

load coast.mat
R=6378.1; %in km
zero_surf=R-410;
scaling=R/(R-b_depth);
scaling_surf=(b_depth-0).*1000*scaling;
latlon=[lat long ones(length(lat),1).*scaling_surf];
x=[];
chk=1;
ncl=0;
for m=1:length(latlon)
    if latlon(m,1) <= latmax && latlon(m) >= latmin && latlon(m,2) <= lonmax && latlon(m,2) >= lonmin
        x=[x;latlon(m,:)];
    elseif m-1 == 0
        x=[x;NaN NaN NaN];
    elseif isnan(x(m-chk,1))
        chk=chk+1;
        continue
    else
        x=[x;NaN NaN NaN];
        ncl=ncl+1;
    end
end

cl=cell(1,ncl+1);
chk=1;
for n=1:length(x)
    if isnan(x(n,1))
        chk=chk+1;
        continue
    else
        cl{chk}=[cl{chk};x(n,:)];
    end
end

fid=fopen('coast.kml','w');
fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">\n');
fprintf(fid,'<Document>\n');
fprintf(fid,'	<name>coastline</name>\n');
for n=1:length(cl)
fprintf(fid,'	<Placemark>\n');
fprintf(fid,'		<name></name>\n');
fprintf(fid,'		<LineString>\n');
fprintf(fid,'			<gx:altitudeMode>absolute</gx:altitudeMode>\n');
fprintf(fid,'			<coordinates>\n');
fprintf(fid,'				');
for m=1:(numel(cl{n})/3)
fprintf(fid,num2str(cl{n}(m,2)));
fprintf(fid,',');
fprintf(fid,num2str(cl{n}(m,1)));
fprintf(fid,',');
fprintf(fid,num2str(cl{n}(m,3)));
fprintf(fid,' ');
end
fprintf(fid,'\n');
fprintf(fid,'			</coordinates>\n');
fprintf(fid,'		</LineString>\n');
fprintf(fid,'	</Placemark>\n');
end
fprintf(fid,'</Document>\n');
fprintf(fid,'</kml>\n');
fclose(fid);
end