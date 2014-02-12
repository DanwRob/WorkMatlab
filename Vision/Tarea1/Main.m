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

% Last Modified by GUIDE v2.5 11-Feb-2014 23:05:45

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
addpath('./Global');
addpath('./Local');
addpath('./imagen')
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
handles.a_Image=[];
handles.ImgName=[];
handles.ImgDir=[];
handles.imsave=[];
handles.tipo=[];
handles.t=[];
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
    handles.ImgDir=Path; 
    handles.ImgName=FileName; 
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

handles.imsave=Salida;
handles.tipo='Prewitt_Th';
handles.t=num2str(idx(3));
guidata(hObject, handles);

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
handles.imsave=Salida;
handles.tipo='PrewittII_Th';
handles.t=num2str(idx(3));
guidata(hObject, handles);

% --------------------------------------------------------------------
function Th_g_r_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_r (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,idx,H]=Rosenfeld(img);
N=(0:255)';
axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist ); 
bar(N, H);
xlim([N(1) N(end)])
hold on
plot([idx idx],[0 max(H)],'r--','LineWidth',1.5);
hold off
handles.imsave=Salida;
handles.tipo='Rosenfeld_Th';
handles.t=num2str(idx);
guidata(hObject, handles);

% --------------------------------------------------------------------
function Th_g_t_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_t (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,idx,H]=Tsai(img);
N=(0:255)';
axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist ); 
bar(N, H);
xlim([N(1) N(end)])
hold on
plot([idx idx],[0 max(H)],'r--','LineWidth',1.5);
hold off
handles.imsave=Salida;
handles.tipo='Tsai_Th';
handles.t=num2str(idx);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Th_g_o_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_o (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,idx,H]=Otsu(img);
N=(0:255)';
axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist ); 
bar(N, H);
xlim([N(1) N(end)])
hold on
plot([idx idx],[0 max(H)],'r--','LineWidth',1.5);
hold off
handles.imsave=Salida;
handles.tipo='Otsu_Th';
handles.t=num2str(idx);
guidata(hObject, handles);
% --------------------------------------------------------------------
function Th_g_ri_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_ri (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,idx,H]=Ridler(img);
N=(0:255)';
axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist ); 
bar(N, H);
xlim([N(1) N(end)])
hold on
plot([idx idx],[0 max(H)],'r--','LineWidth',1.5);
hold off
handles.imsave=Salida;
handles.tipo='Ridler_Th';
handles.t=num2str(idx);
guidata(hObject, handles);

% --------------------------------------------------------------------
function Th_g_k_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_k (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,idx,H]=Kittler1(img);
N=(0:255)';
axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist ); 
bar(N, H);
xlim([N(1) N(end)])
hold on
plot([idx idx],[0 max(H)],'r--','LineWidth',1.5);
hold off
handles.imsave=Salida;
handles.tipo='Kittler1_Th';
handles.t=num2str(idx);
guidata(hObject, handles);

% --------------------------------------------------------------------
function Th_g_kII_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_kII (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,idx,H]=Kittler2(img);
N=(0:255)';
axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist ); 
bar(N, H);
xlim([N(1) N(end)])
hold on
plot([idx idx],[0 max(H)],'r--','LineWidth',1.5);
hold off
handles.imsave=Salida;
handles.tipo='KittlerII_Th';
handles.t=num2str(idx);
guidata(hObject, handles);

% --------------------------------------------------------------------
function Th_g_ra_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_ra (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,idx,H]=Ramesh(img);
N=(0:255)';
axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist ); 
bar(N, H);
xlim([N(1) N(end)])
hold on
plot([idx idx],[0 max(H)],'r--','LineWidth',1.5);
hold off
handles.imsave=Salida;
handles.tipo='Ramesh_Th';
handles.t=num2str(idx);
guidata(hObject, handles);

% --------------------------------------------------------------------
function Th_g_kr_Callback(hObject, eventdata, handles)
% hObject    handle to Th_g_kr (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
img=handles.a_Image;              %Lectura de la imagen
[Salida,idx,H]=Kapur(img);
N=(0:255)';
axes(handles.img_salida);
imshow(Salida);
axes( handles.Hist ); 
bar(N, H);
xlim([N(1) N(end)])
hold on
plot([idx idx],[0 max(H)],'r--','LineWidth',1.5);
hold off
handles.imsave=Salida;
handles.tipo='Kapur_Th';
handles.t=num2str(idx);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Th_l_ni_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l_ni (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'b:','k'};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'15','-0.2'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

img=handles.a_Image;              %Lectura de la imagen
[Salida]=Niblack(img,answer);

axes(handles.img_salida);
imshow(Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=Salida;
handles.tipo='Niblack_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);




% --------------------------------------------------------------------
function Th_l_sa_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l_sa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'b=','k=','R='};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'15','0.2','128'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

img=handles.a_Image;              %Lectura de la imagen
[Salida]=Sauvola(img,answer);

axes(handles.img_salida);
imshow(Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=Salida;
handles.tipo='Sauvola_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);



% --------------------------------------------------------------------
function Th_l_we_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l_we (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'t=','b='};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'15','15'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

img=handles.a_Image;              %Lectura de la imagen
[Salida]=Wellner(img,answer);

axes(handles.img_salida);
imshow(Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=Salida;
handles.tipo='Wellner_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);

% --------------------------------------------------------------------
function Th_l_wh_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l_wh (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'b=','w='};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'15','5'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

img=handles.a_Image;              %Lectura de la imagen
[Salida]=White(img,answer);

axes(handles.img_salida);
imshow(Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=Salida;
handles.tipo='White_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Th_l_be_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l_be (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'b=','t='};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'15','15'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

img=handles.a_Image;              %Lectura de la imagen
[Salida]=Bersen(img,answer);

axes(handles.img_salida);
imshow(Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=Salida;
handles.tipo='Bersen_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Th_l_ya_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l_ya (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'w=','T1=','T2=','T3=','T4='};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'5','20','20','200','200'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
valor=str2double(answer);
img=handles.a_Image;              %Lectura de la imagen
[Salida]=Yasuda(img,valor);

axes(handles.img_salida);
imshow(~Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=~Salida;
handles.tipo='Yasuda_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);

% --------------------------------------------------------------------
function Th_l_ei_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l_ei (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'t='};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'15'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

img=handles.a_Image;              %Lectura de la imagen
[Salida]=th_eikvil(img,answer);

axes(handles.img_salida);
imshow(~Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=~Salida;
handles.tipo='Eikvil_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Th_l_ka_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l_ka (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'b=','T0='};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'3','5'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
valor=str2double(answer);
img=handles.a_Image;              %Lectura de la imagen
[Salida]=th_kamel(img,valor(1),valor(2));
Salida=~Salida;
axes(handles.img_salida);
imshow(Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=Salida;
handles.tipo='Kamel_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);


% --------------------------------------------------------------------
function Th_l_pa_Callback(hObject, eventdata, handles)
% hObject    handle to Th_l_pa (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'b=','m0=','s0=','k='};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'15','-1','1','-1'};
answer = inputdlg(prompt,dlg_title,num_lines,def);

img=handles.a_Image;              %Lectura de la imagen
[Salida]=Parker(img,answer);

axes(handles.img_salida);
imshow(Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=Salida;
handles.tipo='Parker_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);


% --------------------------------------------------------------------
function th_l_p_Callback(hObject, eventdata, handles)
% hObject    handle to th_l_p (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
prompt = {'T1=','T2=','T3=','T4=','T5'};
dlg_title = 'Datos para la funcion';
num_lines = 1;
def = {'15','15','0.84','0.90','2'};
answer = inputdlg(prompt,dlg_title,num_lines,def);
valor=str2double(answer);
img=handles.a_Image;              %Lectura de la imagen
[Salida]=th_palumbo(img,valor);

axes(handles.img_salida);
imshow(~Salida);

axes( handles.Hist ); 
[H,N]=imhist(img);
bar(N,H)
xlim([N(1) N(end)])
handles.imsave=~Salida;
handles.tipo='Palumbo_Th';
handles.t=num2str(NaN);
guidata(hObject, handles);


% --------------------------------------------------------------------
function save_Callback(hObject, eventdata, handles)
% hObject    handle to save (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
  [ruta,name,ext]=fileparts(strcat(handles.ImgDir,handles.ImgName));
  
  save=strcat(ruta,'/',name,'_',handles.tipo,'_',handles.t,'.bmp');
  imwrite(handles.imsave,save);