function regional_discon(latmin,latmax,lonmin,lonmax,b_depth)

%Creates translucent surfaces to represent the mantle discontinuities at
%410 and 660km.
%
%Written by:
%Martin Pratt, 2015

R=6378.1; %in km
scaling=R/(R-b_depth);

fid=fopen('discontinuities.kml','w');
fprintf(fid,'<?xml version="1.0" encoding="UTF-8"?>\n');
fprintf(fid,'<kml xmlns="http://www.opengis.net/kml/2.2">\n');
fprintf(fid,'<Folder>\n');
fprintf(fid,'<GroundOverlay>\n');
fprintf(fid,'   <name>410km Discontinuity</name>\n');
fprintf(fid,'   <color>4Dffffff</color>\n');
fprintf(fid,'   <drawOrder>1</drawOrder>\n');
fprintf(fid,'   <Icon>\n');
fprintf(fid,'      <refreshMode>onInterval</refreshMode>\n');
fprintf(fid,'      <refreshInterval>86400</refreshInterval>\n');
fprintf(fid,'      <viewBoundScale>0.75</viewBoundScale>\n');
fprintf(fid,'   </Icon>\n');
fprintf(fid,'   <altitudeMode>absolute</altitudeMode>\n');
fprintf(fid,'   <altitude>');
fprintf(fid,num2str((b_depth-410)*1000*scaling));
fprintf(fid,'</altitude>\n');
fprintf(fid,'   <LatLonBox>\n');
fprintf(fid,['			<north>' num2str(latmax) '</north>\n']);
fprintf(fid,['			<south>' num2str(latmin) '</south>\n']);
fprintf(fid,['			<east>' num2str(lonmax) '</east>\n']);
fprintf(fid,['			<west>' num2str(lonmin) '</west>\n']);
fprintf(fid,'  </LatLonBox>\n');
fprintf(fid,'</GroundOverlay>\n');
fprintf(fid,'<GroundOverlay>\n');
fprintf(fid,'   <name>660km Discontinuity</name>\n');
fprintf(fid,'   <color>4Dffffff</color>\n');
fprintf(fid,'   <drawOrder>1</drawOrder>\n');
fprintf(fid,'   <Icon>\n');
fprintf(fid,'      <refreshMode>onInterval</refreshMode>\n');
fprintf(fid,'      <refreshInterval>86400</refreshInterval>\n');
fprintf(fid,'      <viewBoundScale>0.75</viewBoundScale>\n');
fprintf(fid,'   </Icon>\n');
fprintf(fid,'   <altitudeMode>absolute</altitudeMode>\n');
fprintf(fid,'   <altitude>');
fprintf(fid,num2str((b_depth-660)*1000*scaling));
fprintf(fid,'</altitude>\n');
fprintf(fid,'   <LatLonBox>\n');
fprintf(fid,['			<north>' num2str(latmax) '</north>\n']);
fprintf(fid,['			<south>' num2str(latmin) '</south>\n']);
fprintf(fid,['			<east>' num2str(lonmax) '</east>\n']);
fprintf(fid,['			<west>' num2str(lonmin) '</west>\n']);
fprintf(fid,'  </LatLonBox>\n');
fprintf(fid,'</GroundOverlay>\n');
fprintf(fid,'</Folder>\n');
fprintf(fid,'</kml>\n');
fclose(fid);
end