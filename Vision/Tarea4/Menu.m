function varargout = Menu(varargin)
% MENU MATLAB code for Menu.fig
%      MENU, by itself, creates a new MENU or raises the existing
%      singleton*.
%
%      H = MENU returns the handle to a new MENU or the handle to
%      the existing singleton*.
%
%      MENU('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MENU.M with the given input arguments.
%
%      MENU('Property','Value',...) creates a new MENU or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Menu_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Menu_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Menu

% Last Modified by GUIDE v2.5 10-Mar-2014 17:43:24

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Menu_OpeningFcn, ...
                   'gui_OutputFcn',  @Menu_OutputFcn, ...
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


% --- Executes just before Menu is made visible.
function Menu_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Menu (see VARARGIN)

% Choose default command line output for Menu
handles.output = hObject;
handles.Imagen=[];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Menu wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Menu_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in abrir.
function abrir_Callback(hObject, eventdata, handles)
% hObject    handle to abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,Path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Selecciona imagen para abrir');
if ~isequal(FileName, 0)
 handles.Imagen = imread(strcat(Path, FileName));
    axes( handles.imagen );
    imshow(handles.Imagen);
     set(handles.INICIAR,'Enable','on')  
 guidata(hObject, handles);
end

% --- Executes on button press in INICIAR.
function INICIAR_Callback(hObject, eventdata, handles)
% hObject    handle to INICIAR (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
     I=mat2gray(handles.Imagen);
     r=str2num(get(handles.r,'string')); 
     iteracion = str2num(get(handles.iter,'string'));   
    uno = get(handles.PCNN,'Value');
    dos = get(handles.ICM,'Value');
    tres = get(handles.SPCNN1,'Value');
    cuatro = get(handles.SPCNN2,'Value');
    axes( handles.imagen );
    if uno == 1
           prompt = {'Af','Al','At','Vf','Vl','Vt','B'};
           dlg_title = 'Datos para la funcion';
           num_lines = 1;
           def = {'0.1','1.0','1.0','0.5','0.2','20','0.1'};
           answer = inputdlg(prompt,dlg_title,num_lines,def);
           Q=str2double(answer);
         Out=pcnn(I,Q(1),Q(2),Q(3),Q(4),Q(5),Q(6),Q(7),r,iteracion);
     elseif dos == 1
           prompt = {'F','G','H'};
           dlg_title = 'Datos para la funcion';
           num_lines = 1;
           def = {'0.9','0.8','20'};
           answer = inputdlg(prompt,dlg_title,num_lines,def);
           Q=str2double(answer);
         Out=icm(I,Q(1),Q(2),Q(3),r,iteracion);  
     elseif tres == 1
           prompt = {'At','Vt','B'};
           dlg_title = 'Datos para la funcion';
           num_lines = 1;
           def = {'1.0','20','0.1'};
           answer = inputdlg(prompt,dlg_title,num_lines,def);
           Q=str2double(answer);
         Out=spcnn1(I,Q(1),Q(2),Q(3),r,iteracion);
     elseif cuatro == 1
           prompt = {'At','B'};
           dlg_title = 'Datos para la funcion';
           num_lines = 1;
           def = {'1.0','0.1'};
           answer = inputdlg(prompt,dlg_title,num_lines,def);
           Q=str2double(answer);
         Out=spcnn2(I,Q(1),Q(2),r,iteracion);    

     end



function r_Callback(hObject, eventdata, handles)
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of r as text
%        str2double(get(hObject,'String')) returns contents of r as a double


% --- Executes during object creation, after setting all properties.
function r_CreateFcn(hObject, eventdata, handles)
% hObject    handle to r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function iter_Callback(hObject, eventdata, handles)
% hObject    handle to iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of iter as text
%        str2double(get(hObject,'String')) returns contents of iter as a double


% --- Executes during object creation, after setting all properties.
function iter_CreateFcn(hObject, eventdata, handles)
% hObject    handle to iter (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end
