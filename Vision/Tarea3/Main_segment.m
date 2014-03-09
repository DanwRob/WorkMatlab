% ------------------------------------------------------------------------
% Materia: Vision por Computadora
%
% Nombre: Dan Williams Robledo Cruz
% 
% Fecha: 5 de Marzo 2014
% 
% Tarea No:3
% 
% Titulo: Segmentación detección de movimiento
% 
% ------------------------------------------------------------------------



function varargout = Main_segment(varargin)
% MAIN_SEGMENT MATLAB code for Main_segment.fig
%      MAIN_SEGMENT, by itself, creates a new MAIN_SEGMENT or raises the existing
%      singleton*.
%
%      H = MAIN_SEGMENT returns the handle to a new MAIN_SEGMENT or the handle to
%      the existing singleton*.
%
%      MAIN_SEGMENT('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN_SEGMENT.M with the given input arguments.
%
%      MAIN_SEGMENT('Property','Value',...) creates a new MAIN_SEGMENT or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_segment_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_segment_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main_segment

% Last Modified by GUIDE v2.5 03-Mar-2014 12:05:04

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_segment_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_segment_OutputFcn, ...
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


% --- Executes just before Main_segment is made visible.
function Main_segment_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main_segment (see VARARGIN)

% Choose default command line output for Main_segment
handles.output = hObject;
handles.Path=[];
handles.fileNames=[];
handles.Salvar=[];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main_segment wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_segment_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in save.
function save_Callback(hObject, eventdata, handles)                     %%Funcion para guardar secuencias de imagenes
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);
%[PathFile]=uigetdir;
[y,x,z]=size(handles.Salvar);
path=strcat(handles.Path,'/secuencias/');
mkdir(path);                                        %crea un directorio para guardar la nueva secuencia
for i=1:z
save=strcat(path,'/segment_',num2str(i),'.tif');
imwrite(handles.Salvar(:,:,i),save);
end


function t_Callback(hObject, eventdata, handles)
% hObject    handle to t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of t as text
%        str2double(get(hObject,'String')) returns contents of t as a double


% --- Executes during object creation, after setting all properties.
function t_CreateFcn(hObject, eventdata, handles)
% hObject    handle to t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in segment.
function segment_Callback(hObject, eventdata, handles)
% hObject    handle to segment (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);

fondo=imread(strcat(handles.Path,'/',handles.fileNames{1}));    %se asigana la imagen de fondo
fondo=double(rgb2gray(fondo));
numFrames = numel(handles.fileNames);                           %total de frames de la secuencia
T = str2num(get(handles.t,'string'));                           %umbral T
Area = str2num(get(handles.area,'string'));                     %Area
[y,x]=size(fondo);  
SE = strel('square',2);                                         %elemento estructurante
handles.Salvar=zeros(y,x,numFrames);                            %matriz para guardar la secuencia nueva
deli=get(handles.delinear,'Value');                             
if deli==0                                                      %deliniear True|False
    for i=2:numFrames
    I=imread(strcat(handles.Path,'/',handles.fileNames{i}));    %lee el siguiente frame
    axes(handles.img_original);
    imshow(I)
    Salida=segmotion(fondo,I,T,Area,SE);                        %llamado a la funcion segmotion
    handles.Salvar(:,:,i)=Salida;
    axes(handles.img_segment);
    imshow(Salida,[]);
    pause(0.01)
    end
else
    for i=2:numFrames
    I=imread(strcat(handles.Path,'/',handles.fileNames{i}));     %lee el siguiente frame
    axes(handles.img_original);hold on;
    imshow(I)
    Salida=segmotion(fondo,I,T,Area,SE);                         %llamado a la funcion segmotion
    handles.Salvar(:,:,i)=Salida;
    [B,~] = bwboundaries(Salida,'noholes');                     %obtiene contorno
    for k = 1:length(B)
         boundary = B{k};
    end
    if(length(B)>0)
        plot(boundary(:,2), boundary(:,1), 'r','LineWidth', 1);     %dibuja contorno
        clear B;        
        hold off;
    end
    axes(handles.img_segment);
    imshow(Salida,[]);
    pause(0.01)
    end
    
end
set(handles.save,'Enable','on')
guidata(hObject,handles);


% --- Executes on button press in open.
function open_Callback(hObject, eventdata, handles)
% hObject    handle to open (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[PathFile]=uigetdir;
dirOutput = dir(fullfile(PathFile,'*.tif'));   %
handles.fileNames = {dirOutput.name};           %
 set(handles.segment,'Enable','on')     %activa boton de segmentar
 set(handles.area,'Enable','on')        %activa EditText de area
 set(handles.t,'Enable','on')           %activa EditText de umbral T
 set(handles.delinear,'Enable','on')    %activa chek botton 
 handles.Path=PathFile;
guidata(hObject,handles);



function area_Callback(hObject, eventdata, handles)
% hObject    handle to area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of area as text
%        str2double(get(hObject,'String')) returns contents of area as a double


% --- Executes during object creation, after setting all properties.
function area_CreateFcn(hObject, eventdata, handles)
% hObject    handle to area (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in delinear.
function delinear_Callback(hObject, eventdata, handles)
% hObject    handle to delinear (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hint: get(hObject,'Value') returns toggle state of delinear
