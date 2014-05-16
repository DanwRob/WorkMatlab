function varargout = Main(varargin)
% MAIN MATLAB code for Main.fig
%      MAIN, by itself, creates a new MAIN or raises the existing
%      singleton*.
%
%      H = MAIN returns the handle to a new MAIN or the handle to
%      the existing singleton*.
%
%      MAIN('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in MAIN.M with the given input arguments.
%
%      MAIN('Property','Value',...) creates a new MAIN or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before Main_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to Main_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help Main

% Last Modified by GUIDE v2.5 15-Mar-2014 18:19:50

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @Main_OpeningFcn, ...
                   'gui_OutputFcn',  @Main_OutputFcn, ...
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


% --- Executes just before Main is made visible.
function Main_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to Main (see VARARGIN)

% Choose default command line output for Main
handles.output = hObject;
handles.Path=[];
handles.Image=[];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes Main wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = Main_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in descomprimir.
function descomprimir_Callback(hObject, eventdata, handles)
% hObject    handle to descomprimir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.modificada)
imshow(zeros(255))
[name,path] = uigetfile({'*.dna'},'Selecciona imagen para abrir');
bitstream = fopen(strcat(path, name),'r');
Isalida=descompresor(bitstream);

imshow(Isalida)
%Isalida=mat2gray(Isalida,[0,255]);
%imwrite(Isalida,'rose.png');
guidata(hObject, handles);


% --- Executes on button press in Abrir.
function Abrir_Callback(hObject, eventdata, handles)
% hObject    handle to Abrir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

[FileName,handles.Path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Selecciona imagen para abrir');
I = imread(strcat(handles.Path, FileName));
axes( handles.original );         
imshow(I); 
handles.Image=I; 
set(handles.Comprimir,'Enable','on') 
guidata(hObject, handles);


% --- Executes on button press in Comprimir.
function Comprimir_Callback(hObject, eventdata, handles)
% hObject    handle to Comprimir (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
guidata(hObject, handles);

prompt = {'Capas'};
   dlg_title = 'Numero de capas a guardar';
   num_lines = 1;
   def = {'8'};
   capas = inputdlg(prompt,dlg_title,num_lines,def);
   capas=str2double(capas);
   [bitstream]=compresor(handles.Image,capas);
   prompt = {'Nombre'};
   dlg_title = 'Save as...';
   num_lines = 1;
   def = {''};
   answer = inputdlg(prompt,dlg_title,num_lines,def);
   save=cell2mat(answer);
   save=strcat(handles.Path,save,'.dna');
fid = fopen(save, 'w');
fwrite(fid, bitstream,'ubit1'); 
set(handles.descomprimir,'Enable','on') 
guidata(hObject, handles);
