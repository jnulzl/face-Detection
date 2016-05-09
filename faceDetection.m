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
% detecting face in the handles.img.
bbox= step(faceDetector,handles.img);
% plot a rectangle around the detected face.
handles.img = insertShape(handles.img, 'Rectangle', bbox);
imshow(handles.img);%show image  
guidata(hObject, handles);%update data

% --- Executes on button press in OpenImage.
function OpenImage_Callback(hObject, eventdata, handles)
% hObject    handle to OpenImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
[filename, pathname] = uigetfile('*.jpg', 'Select a jpg image'); %select a image
if ~isequal(filename,0)   
   pathfile=fullfile(pathname, filename);  %get image path
   handles.img = imread(pathfile);     %read a image using 'pathfile'
   imshow(handles.img);%show image  
   guidata(hObject, handles);%update data
end

% --- Executes on button press in ClearImage.
function ClearImage_Callback(hObject, eventdata, handles)
% hObject    handle to ClearImage (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla
handles.img = 0;
guidata(hObject, handles);
