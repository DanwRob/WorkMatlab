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

% Last Modified by GUIDE v2.5 08-Feb-2014 14:01:50

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
clc;
handles.output = hObject;
handle.a_Image=[];
% Update handles structure
guidata(hObject, handles);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using Main.
%if strcmp(get(hObject,'Visible'),'off')
 %   plot(rand(5));
%end

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



% --------------------------------------------------------------------
function FileMenu_Callback(hObject, eventdata, handles)
% hObject    handle to FileMenu (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function OpenMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to OpenMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[FileName,Path] = uigetfile({'*.jpg;*.bmp;*.png;*.tif'},'Selecciona imagen para abrir');
if ~isequal(FileName, 0)
    Imagen = imread(strcat(Path, FileName));
    axes( handles.imagen );         
    imshow(Imagen); 
    handles.a_Image=Imagen; 
    
    [I,N]=imhist(Imagen);      
     I = I/sum(I);           
     axes( handles.Hist); 
    bar(N,I)
    xlim([N(1) N(end)])
    guidata(hObject, handles); 
end


% --------------------------------------------------------------------
function CloseMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to CloseMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
selection = questdlg(['Close ' get(handles.figure1,'Name') '?'],...
                     ['Close ' get(handles.figure1,'Name') '...'],...
                     'Yes','No','Yes');
if strcmp(selection,'No')
    return;
end

delete(handles.figure1)


% --------------------------------------------------------------------
function Th_Callback(hObject, eventdata, handles)
% hObject    handle to Th (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Th_g_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Th_l_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Th_g_p_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,Hist,idx]=prewitt_1(img);
N=(0:255)';

axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist );         
bar(N, Hist);
xlim([N(1) N(end)])
hold on
plot([idx(1) idx(1)],[0 max(Hist)],'r--','LineWidth',1.5);
plot([idx(3) idx(3)],[0 max(Hist)],'m--','LineWidth',1.5);
plot([idx(2) idx(2)],[0 max(Hist)],'r--','LineWidth',1.5);
hold off

% --------------------------------------------------------------------
function Th_g_pII_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_pII (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,Hist,idx]=prewitt_2(img);
N=(0:255)';

axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist );         
bar(N, Hist);
xlim([N(1) N(end)])
hold on
plot([idx(1) idx(1)],[0 max(Hist)],'r--','LineWidth',1.5);
plot([idx(3) idx(3)],[0 max(Hist)],'m--','LineWidth',1.5);
plot([idx(2) idx(2)],[0 max(Hist)],'r--','LineWidth',1.5);
hold off


% --------------------------------------------------------------------
function Th_g_r_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Th_g_t_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Th_g_o_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_o (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Th_g_ri_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_ri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Th_g_k_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Th_g_kII_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_kII (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Th_g_ra_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_ra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
