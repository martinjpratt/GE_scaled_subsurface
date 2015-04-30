function varargout = scaled_subsurface(varargin)
% SCALED_SUBSURFACE MATLAB code for scaled_subsurface.fig
%      SCALED_SUBSURFACE, by itself, creates a new SCALED_SUBSURFACE or raises the existing
%      singleton*.
%
%      H = SCALED_SUBSURFACE returns the handle to a new SCALED_SUBSURFACE or the handle to
%      the existing singleton*.
%
%      SCALED_SUBSURFACE('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in SCALED_SUBSURFACE.M with the given input arguments.
%
%      SCALED_SUBSURFACE('Property','Value',...) creates a new SCALED_SUBSURFACE or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before scaled_subsurface_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to scaled_subsurface_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help scaled_subsurface

% Last Modified by GUIDE v2.5 28-Apr-2015 13:51:40

%Written by:
%Martin Pratt, 2015
%%
% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @scaled_subsurface_OpeningFcn, ...
                   'gui_OutputFcn',  @scaled_subsurface_OutputFcn, ...
                   'gui_LayoutFcn',  [] , ...
                   'gui_Callback',   []);
if nargin && ischar(varargin{1})
    gui_State.gui_Callback = str2func(varargin{1});
end

if nargout
    [varargout{1:nargout}] = gui_mainfcn(gui_State, varargin{:});
else
    gui_mainfcn(gui_State, varargin{:});
end
% End initialization code - DO NOT EDIT

% --- Executes just before scaled_subsurface is made visible.
function scaled_subsurface_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to scaled_subsurface (see VARARGIN)

% Choose default command line output for scaled_subsurface
handles.output = hObject;
handles.latmax = 90;
handles.latmin = -90;
handles.lonmin = -180;
handles.lonmax = 180;
handles.b_depth = 1000;
handles.src_loc = 1;
handles.infile = 'local_eqs.txt';
handles.outfile = 'eq_example';
handles.mindep = 0;
handles.maxdep = 1000;
handles.minmag = 0;
handles.maxmag = 10;
handles.start_year = datestr(now,'yyyy');
handles.start_month = datestr(now-30,'mm');
handles.start_day = datestr(now,'dd');
handles.start_hour = datestr(now,'HH');
handles.start_minute = datestr(now,'MM');
handles.start_second = datestr(now,'SS');
handles.end_year = datestr(now,'yyyy');
handles.end_month = datestr(now,'mm');
handles.end_day = datestr(now,'dd');
handles.end_hour = datestr(now,'HH');
handles.end_minute = datestr(now,'MM');
handles.end_second = datestr(now,'SS');
handles.slab=zeros(13,3);
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes scaled_subsurface wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = scaled_subsurface_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

%% Scaled Depth

function edit5_Callback(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.b_depth=str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit5 as text
%        str2double(get(hObject,'String')) returns contents of edit5 as a double


% --- Executes during object creation, after setting all properties.
function edit5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Latitude Minimum

function edit10_Callback(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.latmin=str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit10 as text
%        str2double(get(hObject,'String')) returns contents of edit10 as a double

% --- Executes during object creation, after setting all properties.
function edit10_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Longitude Minimum

function edit11_Callback(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.lonmin=str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit11 as text
%        str2double(get(hObject,'String')) returns contents of edit11 as a double


% --- Executes during object creation, after setting all properties.
function edit11_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Longitude Maximum

function edit12_Callback(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.lonmax=str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit12 as text
%        str2double(get(hObject,'String')) returns contents of edit12 as a double


% --- Executes during object creation, after setting all properties.
function edit12_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Latitude Maximum

function edit13_Callback(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.latmax=str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit13 as text
%        str2double(get(hObject,'String')) returns contents of edit13 as a double


% --- Executes during object creation, after setting all properties.
function edit13_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Bounding Box Creation

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(hObject);
disp(['Latitude range: ' num2str(data.latmin) ' to ' num2str(data.latmax)])
disp(['Longitude range: ' num2str(data.lonmin) ' to ' num2str(data.lonmax)])
disp(' ')
disp(['Scaled Depth: ' num2str(data.b_depth)])
regional_box(data.latmin,data.latmax,data.lonmin,data.lonmax,data.b_depth);
disp('Finished making box.kml')

%% Coastline Creation

% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(hObject);
disp(['Latitude range: ' num2str(data.latmin) ' to ' num2str(data.latmax)])
disp(['Longitude range: ' num2str(data.lonmin) ' to ' num2str(data.lonmax)])
disp(' ')
disp(['Scaled Depth: ' num2str(data.b_depth)])
regional_coast(data.latmin,data.latmax,data.lonmin,data.lonmax,data.b_depth);
disp('Finished making coast.kml')

%% Mantle Discontinuities Creation

% --- Executes on button press in pushbutton11.
function pushbutton11_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(hObject);
disp(['Latitude range: ' num2str(data.latmin) ' to ' num2str(data.latmax)])
disp(['Longitude range: ' num2str(data.lonmin) ' to ' num2str(data.lonmax)])
disp(' ')
disp(['Scaled Depth: ' num2str(data.b_depth)])
regional_discon(data.latmin,data.latmax,data.lonmin,data.lonmax,data.b_depth);
disp('Finished making discontinuities.kml')

%% Earthquake Locations

% --- Executes on button press in pushbutton4.
function pushbutton4_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(hObject);
data.startTime=[handles.start_year '-' handles.start_month '-' handles.start_day ' ' handles.start_hour ':' handles.start_minute ':' handles.start_second];
data.endTime=[handles.end_year '-' handles.end_month '-' handles.end_day ' ' handles.end_hour ':' handles.end_minute ':' handles.end_second];

disp(['Latitude range: ' num2str(data.latmin) ' to ' num2str(data.latmax)])
disp(['Longitude range: ' num2str(data.lonmin) ' to ' num2str(data.lonmax)])
disp(['Depth range: ' num2str(data.mindep) ' to ' num2str(data.maxdep)])
disp(['Magnitude range: ' num2str(data.minmag) ' to ' num2str(data.maxmag)])
disp(' ')
disp(['Scaled Depth: ' num2str(data.b_depth)])
disp(' ')
disp(['Start: ' data.startTime])
disp(['End: ' data.endTime])

regional_earthquake(data.latmin,data.latmax,data.lonmin,data.lonmax,data.b_depth,data.outfile,data.minmag,data.maxmag,data.mindep,data.maxdep,data.startTime,data.endTime,data.src_loc,data.infile)
disp(['Finished making ' data.outfile '.kml'])

%% Global CMT Creation

% --- Executes on button press in pushbutton5.
function pushbutton5_Callback(hObject, eventdata, handles) %#ok<*INUSD>
% hObject    handle to pushbutton5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=guidata(hObject);
data.startTime=[handles.start_year '-' handles.start_month '-' handles.start_day ' ' handles.start_hour ':' handles.start_minute ':' handles.start_second];
data.endTime=[handles.end_year '-' handles.end_month '-' handles.end_day ' ' handles.end_hour ':' handles.end_minute ':' handles.end_second];
disp(['Latitude range: ' num2str(data.latmin) ' to ' num2str(data.latmax)])
disp(['Longitude range: ' num2str(data.lonmin) ' to ' num2str(data.lonmax)])
disp(['Depth range: ' num2str(data.mindep) ' to ' num2str(data.maxdep)])
disp(['Magnitude range: ' num2str(data.minmag) ' to ' num2str(data.maxmag)])
disp(' ')
disp(['Scaled Depth: ' num2str(data.b_depth)])
disp(' ')
disp(['Start: ' data.startTime])
disp(['End: ' data.endTime])
CMTsearch(data.start_year,data.start_month,data.start_day,data.end_year,data.end_month,data.end_day,data.minmag,data.maxmag,data.latmin,data.latmax,data.lonmin,data.lonmax,data.mindep,data.maxdep,data.b_depth)
disp('Finished making beachball.kml')

%% Output file name for Earthquake Location KML

function edit14_Callback(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.outfile=(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit14 as text
%        str2double(get(hObject,'String')) returns contents of edit14 as a double


% --- Executes during object creation, after setting all properties.
function edit14_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit14 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Minimum Magnitude

function edit15_Callback(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.minmag=str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit15 as text
%        str2double(get(hObject,'String')) returns contents of edit15 as a double


% --- Executes during object creation, after setting all properties.
function edit15_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit15 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Maximum Depth

function edit16_Callback(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.maxdep=str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit16 as text
%        str2double(get(hObject,'String')) returns contents of edit16 as a double


% --- Executes during object creation, after setting all properties.
function edit16_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit16 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Selection of input data location

% --- Executes when selected object is changed in uipanel10.
function uipanel10_SelectionChangeFcn(hObject, eventdata, handles)
% hObject    handle to the selected object in uipanel10 
% eventdata  structure with the following fields (see UIBUTTONGROUP)
%	EventName: string 'SelectionChanged' (read only)
%	OldValue: handle of the previously selected object or empty if none was selected
%	NewValue: handle of the currently selected object
% handles    structure with handles and user data (see GUIDATA)
src=get(hObject,'String');
if strcmp(src,'Use irisFetch')
    handles.src_loc=1;
else
    handles.src_loc=2;
end
guidata(hObject,handles);

%% Local Infile Name

function edit17_Callback(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.infile=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit17 as text
%        str2double(get(hObject,'String')) returns contents of edit17 as a double


% --- Executes during object creation, after setting all properties.
function edit17_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit17 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Start Year

function edit29_Callback(hObject, eventdata, handles) %#ok<*DEFNU,*INUSL>
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.start_year=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit29 as text
%        str2double(get(hObject,'String')) returns contents of edit29 as a double


% --- Executes during object creation, after setting all properties.
function edit29_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit29 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Start Month

function edit30_Callback(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.start_month=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit30 as text
%        str2double(get(hObject,'String')) returns contents of edit30 as a double


% --- Executes during object creation, after setting all properties.
function edit30_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit30 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Start Day

function edit31_Callback(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.start_day=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit31 as text
%        str2double(get(hObject,'String')) returns contents of edit31 as a double


% --- Executes during object creation, after setting all properties.
function edit31_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit31 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Start Hour

function edit35_Callback(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.start_hour=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit35 as text
%        str2double(get(hObject,'String')) returns contents of edit35 as a double


% --- Executes during object creation, after setting all properties.
function edit35_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit35 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Start Minute

function edit36_Callback(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.start_minute=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit36 as text
%        str2double(get(hObject,'String')) returns contents of edit36 as a double


% --- Executes during object creation, after setting all properties.
function edit36_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit36 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Maximum Magnitude

function edit39_Callback(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.maxmag=str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit39 as text
%        str2double(get(hObject,'String')) returns contents of edit39 as a double


% --- Executes during object creation, after setting all properties.
function edit39_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit39 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Minimum Depth

function edit40_Callback(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.mindep=str2double(get(hObject,'String'));
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit40 as text
%        str2double(get(hObject,'String')) returns contents of edit40 as a double


% --- Executes during object creation, after setting all properties.
function edit40_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit40 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Start Second

function edit41_Callback(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.start_second=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit41 as text
%        str2double(get(hObject,'String')) returns contents of edit41 as a double


% --- Executes during object creation, after setting all properties.
function edit41_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit41 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% End Year

function edit42_Callback(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.end_year=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit42 as text
%        str2double(get(hObject,'String')) returns contents of edit42 as a double


% --- Executes during object creation, after setting all properties.
function edit42_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit42 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% End Month

function edit43_Callback(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.end_month=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit43 as text
%        str2double(get(hObject,'String')) returns contents of edit43 as a double


% --- Executes during object creation, after setting all properties.
function edit43_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit43 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% End Day

function edit44_Callback(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.end_day=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit44 as text
%        str2double(get(hObject,'String')) returns contents of edit44 as a double


% --- Executes during object creation, after setting all properties.
function edit44_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit44 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% End Hour

function edit45_Callback(hObject, eventdata, handles)
% hObject    handle to edit45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.end_hour=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit45 as text
%        str2double(get(hObject,'String')) returns contents of edit45 as a double


% --- Executes during object creation, after setting all properties.
function edit45_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit45 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% End Minute

function edit46_Callback(hObject, eventdata, handles)
% hObject    handle to edit46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.end_minute=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit46 as text
%        str2double(get(hObject,'String')) returns contents of edit46 as a double


% --- Executes during object creation, after setting all properties.
function edit46_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit46 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% End Second

function edit47_Callback(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
handles.end_second=get(hObject,'String');
guidata(hObject,handles);
% Hints: get(hObject,'String') returns contents of edit47 as text
%        str2double(get(hObject,'String')) returns contents of edit47 as a double


% --- Executes during object creation, after setting all properties.
function edit47_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit47 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end

%% Plate Boundary Creation

% --- Executes on button press in pushbutton6.
function pushbutton6_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data=guidata(hObject);
disp(['Scaled Depth: ' num2str(data.b_depth)])
regional_plate_boundaries(data.b_depth);
disp('Finished makeing plateboundaries_usgs_regional.kml')

%% Aleutian Slab

% --- Executes on button press in checkbox1.
function checkbox1_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(1,:)='alu';
else
    handles.slab(1,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox1

%% Cascadia Slab

% --- Executes on button press in checkbox2.
function checkbox2_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(2,:)='cas';
else
    handles.slab(2,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox2

%% Izu-Bonin Slab

% --- Executes on button press in checkbox3.
function checkbox3_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(3,:)='izu';
else
    handles.slab(3,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox3

%% Kermadec Slab

% --- Executes on button press in checkbox4.
function checkbox4_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(4,:)='ker';
else
    handles.slab(4,:)=[0 0 0];
end
handles.slab
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox4

%% Kuril Slab

% --- Executes on button press in checkbox5.
function checkbox5_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(5,:)='kur';
else
    handles.slab(5,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox5

%% Mexico Slab

% --- Executes on button press in checkbox6.
function checkbox6_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox6 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(6,:)='mex';
else
    handles.slab(6,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox6

%% Philippine Slab

% --- Executes on button press in checkbox7.
function checkbox7_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox7 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(7,:)='phi';
else
    handles.slab(7,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox7

%% Ryukyu Slab

% --- Executes on button press in checkbox8.
function checkbox8_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox8 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(8,:)='ryu';
else
    handles.slab(8,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox8

%% South America Slab

% --- Executes on button press in checkbox9.
function checkbox9_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox9 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(9,:)='sam';
else
    handles.slab(9,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox9

%% Scotia Slab

% --- Executes on button press in checkbox10.
function checkbox10_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(10,:)='sco';
else
    handles.slab(10,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox10

%% Solomon Slab

% --- Executes on button press in checkbox11.
function checkbox11_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox11 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(11,:)='sol';
else
    handles.slab(11,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox11

%% Sumatra Slab

% --- Executes on button press in checkbox12.
function checkbox12_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox12 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(12,:)='sum';
else
    handles.slab(12,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox12

%% Vanuatu Slab

% --- Executes on button press in checkbox13.
function checkbox13_Callback(hObject, eventdata, handles)
% hObject    handle to checkbox13 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
val=get(hObject,'Value');
if val==1
    handles.slab(13,:)='van';
else
    handles.slab(13,:)=[0 0 0];
end
guidata(hObject,handles);
% Hint: get(hObject,'Value') returns toggle state of checkbox13

%% Slab KML Creation

% --- Executes on button press in pushbutton10.
function pushbutton10_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton10 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
data = guidata(hObject);
disp(['Scaled Depth: ' num2str(data.b_depth)])
for n=find(data.slab(:,1))';
    regional_slab(char(data.slab(n,:)),data.b_depth)
    disp(['Finished making ' char(data.slab(n,:)) '.kml'])
end
