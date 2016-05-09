function varargout = faceDetection(varargin)
% Edit the above text to modify the response to help faceDetection

% Last Modified by GUIDE v2.5 08-May-2016 22:02:56

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @faceDetection_OpeningFcn, ...
                   'gui_OutputFcn',  @faceDetection_OutputFcn, ...
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


% --- Executes just before faceDetection is made visible.
function faceDetection_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to faceDetection (see VARARGIN)

% Choose default command line output for faceDetection
handles.output = hObject;
handles.img = 0;
% Update handles structure
guidata(hObject, handles);

% UIWAIT makes faceDetection wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = faceDetection_OutputFcn(hObject, eventdata, handles) 
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;


% --- Executes on button press in faceDetection.
function faceDetection_Callback(hObject, eventdata, handles)
% hObject    handle to faceDetection (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
if(handles.img == 0)
    return;
end
faceDetector = vision.CascadeObjectDetector();
% 读取图像并进行人脸检测.
bbox= step(faceDetector,handles.img);
% 在检测到的人脸周围画一个矩形.
handles.img = insertShape(handles.img, 'Rectangle', bbox);
% clf
imshow(handles.img);
guidata(hObject, handles);
% --- Executes on button press in OpenImage.
function OpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to OpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.jpg', '读取图片文件'); %选择图片文件
if ~isequal(filename,0)   %判断是否选择
   pathfile=fullfile(pathname, filename);  %获得图片路径
   handles.img = imread(pathfile);     %将图片读入矩阵
   imshow(handles.img);
   guidata(hObject, handles);
end
% title('人脸检测');

% --- Executes on button press in ClearImage.
function ClearImage_Callback(hObject, eventdata, handles)
% hObject    handle to ClearImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% axis(handles.myAxis);
cla
handles.img = 0;
guidata(hObject, handles);
