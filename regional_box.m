function regional_box(latmin,latmax,lonmin,lonmax,b_depth)

%Creates a bounding box around a sprecific area of interest to help define
%the regional scaled depth. The vertical lines of the box are labelled in 
%100km increments for reference.
%
%Written by:
%Martin Pratt, 2015


lat=latmin:latmax;
lon=lonmin:lonmax;

edges=[lat' ones(length(lat),1).*min(lon)
       ones(length(lon),1).*max(lat) lon'
       flipud(lat') ones(length(lat),1).*max(lon)
       ones(length(lon),1).*min(lat) flipud(lon')];

corners=[lat(1) lon(1);lat(1) lon(end);lat(end) lon(1);lat(end) lon(end)];

R=6378.1; %in km

zero_surf=R-410;
scaling=R/(R-b_depth);
scaling_surf=(b_depth-0).*1000*scaling;
scalebar=0:100:b_depth;

fid=fopen('box.kml','w');
fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2" xmlns:gx="http://www.google.com/kml/ext/2.2" xmlns:kml="http://www.opengis.net/kml/2.2" xmlns:atom="http://www.w3.org/2005/Atom">\n');
fprintf(fid,'<Document>\n');
fprintf(fid,'	<name>bounding box</name>\n');
fprintf(fid,'	<StyleMap id="default">\n');
fprintf(fid,'		<Pair>\n');
fprintf(fid,'			<key>normal</key>\n');
fprintf(fid,'			<styleUrl>#default0</styleUrl>\n');
fprintf(fid,'		</Pair>\n');
fprintf(fid,'		<Pair>\n');
fprintf(fid,'			<key>highlight</key>\n');
fprintf(fid,'			<styleUrl>#hl</styleUrl>\n');
fprintf(fid,'		</Pair>\n');
fprintf(fid,'	</StyleMap>\n');
fprintf(fid,'	<Style id="hl">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<ListStyle>\n');
fprintf(fid,'		</ListStyle>\n');
fprintf(fid,'	</Style>\n');
fprintf(fid,'	<Style id="default0">\n');
fprintf(fid,'		<IconStyle>\n');
fprintf(fid,'			<Icon>\n');
fprintf(fid,'			</Icon>\n');
fprintf(fid,'		</IconStyle>\n');
fprintf(fid,'		<ListStyle>\n');
fprintf(fid,'		</ListStyle>\n');
fprintf(fid,'	</Style>\n');
fprintf(fid,'	<Placemark>\n');
fprintf(fid,'		<name>box</name>\n');
fprintf(fid,'		<LineString>\n');
fprintf(fid,'			<gx:altitudeMode>absolute</gx:altitudeMode>\n');
fprintf(fid,'			<coordinates>\n');
fprintf(fid,'				');
for n=1:length(edges)
fprintf(fid,num2str(edges(n,2)));
fprintf(fid,',');
fprintf(fid,num2str(edges(n,1)));
fprintf(fid,',');
fprintf(fid,num2str((b_depth-0).*1000*scaling));
fprintf(fid,' ');
end
fprintf(fid,'\n');
fprintf(fid,'			</coordinates>\n');
fprintf(fid,'		</LineString>\n');
fprintf(fid,'	</Placemark>\n');
fprintf(fid,'	<Placemark>\n');
fprintf(fid,'		<name>box</name>\n');
fprintf(fid,'		<LineString>\n');
fprintf(fid,'			<gx:altitudeMode>clampToGround</gx:altitudeMode>\n');
fprintf(fid,'			<coordinates>\n');
fprintf(fid,'				');
for n=1:length(edges)
fprintf(fid,num2str(edges(n,2)));
fprintf(fid,',');
fprintf(fid,num2str(edges(n,1)));
fprintf(fid,',');
fprintf(fid,num2str((b_depth-0).*1000*scaling));
fprintf(fid,' ');
end
fprintf(fid,'\n');
fprintf(fid,'			</coordinates>\n');
fprintf(fid,'		</LineString>\n');
fprintf(fid,'	</Placemark>\n');
for n=1:length(corners)
    fprintf(fid,'	<Placemark>\n');
fprintf(fid,'		<name></name>\n');
fprintf(fid,'		<LineString>\n');
fprintf(fid,'			<gx:altitudeMode>absolute</gx:altitudeMode>\n');
fprintf(fid,'			<coordinates>\n');
fprintf(fid,'				');
fprintf(fid,num2str(corners(n,2)));
fprintf(fid,',');
fprintf(fid,num2str(corners(n,1)));
fprintf(fid,',');
fprintf(fid,num2str((b_depth-0).*1000*scaling));
fprintf(fid,' ');
fprintf(fid,num2str(corners(n,2)));
fprintf(fid,',');
fprintf(fid,num2str(corners(n,1)));
fprintf(fid,',');
fprintf(fid,'0\n');
fprintf(fid,'			</coordinates>\n');
fprintf(fid,'		</LineString>\n');
fprintf(fid,'	</Placemark>\n');
end

for n=1:length(scalebar)
fprintf(fid,'<Placemark>\n');
fprintf(fid,'      <name>');
fprintf(fid,num2str(scalebar(n)));
fprintf(fid,'</name>\n');
fprintf(fid,'      <styleUrl>#default</styleUrl>\n');
fprintf(fid,'      <Point>\n');
fprintf(fid,'	      <gx:altitudeMode>absolute</gx:altitudeMode>\n');
fprintf(fid,'         <coordinates>');
fprintf(fid,num2str(lon(end)));
fprintf(fid,',');
fprintf(fid,num2str(lat(end)));
fprintf(fid,',');
fprintf(fid,num2str((b_depth-scalebar(n)).*1000*scaling));
fprintf(fid,'</coordinates>\n');
fprintf(fid,'      </Point>\n');
fprintf(fid,'   </Placemark>\n');
end

for n=1:length(scalebar)
fprintf(fid,'<Placemark>\n');
fprintf(fid,'      <name>');
fprintf(fid,num2str(scalebar(n)));
fprintf(fid,'</name>\n');
fprintf(fid,'      <styleUrl>#default</styleUrl>\n');
fprintf(fid,'      <Point>\n');
fprintf(fid,'	      <gx:altitudeMode>absolute</gx:altitudeMode>\n');
fprintf(fid,'         <coordinates>');
fprintf(fid,num2str(lon(1)));
fprintf(fid,',');
fprintf(fid,num2str(lat(end)));
fprintf(fid,',');
fprintf(fid,num2str((b_depth-scalebar(n)).*1000*scaling));
fprintf(fid,'</coordinates>\n');
fprintf(fid,'      </Point>\n');
fprintf(fid,'   </Placemark>\n');
end

for n=1:length(scalebar)
fprintf(fid,'<Placemark>\n');
fprintf(fid,'      <name>');
fprintf(fid,num2str(scalebar(n)));
fprintf(fid,'</name>\n');
fprintf(fid,'      <styleUrl>#default</styleUrl>\n');
fprintf(fid,'      <Point>\n');
fprintf(fid,'	      <gx:altitudeMode>absolute</gx:altitudeMode>\n');
fprintf(fid,'         <coordinates>');
fprintf(fid,num2str(lon(end)));
fprintf(fid,',');
fprintf(fid,num2str(lat(1)));
fprintf(fid,',');
fprintf(fid,num2str((b_depth-scalebar(n)).*1000*scaling));
fprintf(fid,'</coordinates>\n');
fprintf(fid,'      </Point>\n');
fprintf(fid,'   </Placemark>\n');
end

for n=1:length(scalebar)
fprintf(fid,'<Placemark>\n');
fprintf(fid,'      <name>');
fprintf(fid,num2str(scalebar(n)));
fprintf(fid,'</name>\n');
fprintf(fid,'      <styleUrl>#default</styleUrl>\n');
fprintf(fid,'      <Point>\n');
fprintf(fid,'	      <gx:altitudeMode>absolute</gx:altitudeMode>\n');
fprintf(fid,'         <coordinates>');
fprintf(fid,num2str(lon(1)));
fprintf(fid,',');
fprintf(fid,num2str(lat(1)));
fprintf(fid,',');
fprintf(fid,num2str((b_depth-scalebar(n)).*1000*scaling));
fprintf(fid,'</coordinates>\n');
fprintf(fid,'      </Point>\n');
fprintf(fid,'   </Placemark>\n');
end

fprintf(fid,'<Placemark>\n');
fprintf(fid,'      <name>');
fprintf(fid,num2str(b_depth));
fprintf(fid,'</name>\n');
fprintf(fid,'      <styleUrl>#default</styleUrl>\n');
fprintf(fid,'      <Point>\n');
fprintf(fid,'         <coordinates>');
fprintf(fid,num2str(lon(end)));
fprintf(fid,',');
fprintf(fid,num2str(lat(end)));
fprintf(fid,',');
fprintf(fid,'0</coordinates>\n');
fprintf(fid,'      </Point>\n');
fprintf(fid,'   </Placemark>\n');
fprintf(fid,'</Document>\n');
fprintf(fid,'</kml>\n');
fclose(fid);
end