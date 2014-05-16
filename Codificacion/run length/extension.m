function varargout = extension(varargin)
% EXTENSION MATLAB code for extension.fig
%      EXTENSION, by itself, creates a new EXTENSION or raises the existing
%      singleton*.
%
%      H = EXTENSION returns the handle to a new EXTENSION or the handle to
%      the existing singleton*.
%
%      EXTENSION('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in EXTENSION.M with the given input arguments.
%
%      EXTENSION('Property','Value',...) creates a new EXTENSION or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before extension_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to extension_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help extension

% Last Modified by GUIDE v2.5 18-Mar-2014 18:31:00

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @extension_OpeningFcn, ...
                   'gui_OutputFcn',  @extension_OutputFcn, ...
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


% --- Executes just before extension is made visible.
function extension_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to extension (see VARARGIN)

% Choose default command line output for extension
handles.output = hObject;
handles.Path=[];
handles.Image=[];
handles.Isalida_ruido=[];
handles.Isalida=[];
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes extension wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = extension_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --------------------------------------------------------------------
function uipushtool2_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,handles.Path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Selecciona imagen para abrir');
I = imread(strcat(handles.Path, FileName));
 
handles.Image=I; 
   prompt = {'Capas'};
   dlg_title = 'Numero de capas a guardar';
   num_lines = 1;
   def = {'8'};
   capas = inputdlg(prompt,dlg_title,num_lines,def);
   capas=str2double(capas);
   [bitstream]=compresor(handles.Image,capas);
   [name_save]=save(bitstream,handles.Path);
   
   axes(handles.im)
    imshow(zeros(255))
    
   axes(handles.im_ruido)
    imshow(zeros(255))
    
    bitstream = fopen(name_save,'r');
    [handles.Isalida,handles.Isalida_ruido]=descompresor2(bitstream);

   axes(handles.im)
    imshow(handles.Isalida)
   axes(handles.im_ruido)
    imshow(handles.Isalida_ruido)
    
   
   axes(handles.hist_ruido)
    [H,N]=imhist(handles.Isalida_ruido);
    bar(N,H)
    xlim([N(1) N(end)])
   axes(handles.hist)
    [H,N]=imhist(handles.Isalida);
    bar(N,H)
    xlim([N(1) N(end)])
    
   set(handles.uipushtool4,'Enable','on') 
guidata(hObject, handles);

function save=save(bitstream,path)
prompt = {'Nombre'};
   dlg_title = 'Save as...';
   num_lines = 1;
   def = {''};
   answer = inputdlg(prompt,dlg_title,num_lines,def);
   save=cell2mat(answer);
   save=strcat(path,save,'.dna');
fid = fopen(save, 'w');
fwrite(fid, bitstream,'ubit1'); 


% --------------------------------------------------------------------
function uipushtool4_ClickedCallback(hObject, eventdata, handles)
% hObject    handle to uipushtool4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'Nombre'};
   dlg_title = 'Save as...';
   num_lines = 1;
   def = {''};
   answer = inputdlg(prompt,dlg_title,num_lines,def);
   name=cell2mat(answer);
   ruido=strcat(handles.Path,name,'_ruido.png');
   normal=strcat(handles.Path,name,'.png');
 handles.Isalida=mat2gray(handles.Isalida,[0,255]);
  imwrite(handles.Isalida,normal);
 handles.Isalida_ruido=mat2gray(handles.Isalida_ruido,[0,255]);
  imwrite(handles.Isalida_ruido,ruido);
