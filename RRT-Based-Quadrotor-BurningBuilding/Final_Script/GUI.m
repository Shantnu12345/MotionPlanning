function varargout = GUI(varargin)
% GUI MATLAB code for GUI.fig
%      GUI, by itself, creates a new GUI or raises the existing
%      singleton*.
%
%      H = GUI returns the handle to a new GUI or the handle to
%      the existing singleton*.
%
%      GUI('CALLBACK',hObject,eventData,handles,...) calls the local
%      function named CALLBACK in GUI.M with the given input arguments.
%
%      GUI('Property','Value',...) creates a new GUI or raises the
%      existing singleton*.  Starting from the left, property value pairs are
%      applied to the GUI before GUI_OpeningFcn gets called.  An
%      unrecognized property name or invalid value makes property application
%      stop.  All inputs are passed to GUI_OpeningFcn via varargin.
%
%      *See GUI Options on GUIDE's Tools menu.  Choose "GUI allows only one
%      instance to run (singleton)".
%
% See also: GUIDE, GUIDATA, GUIHANDLES

% Edit the above text to modify the response to help GUI

% Last Modified by GUIDE v2.5 02-Dec-2015 12:13:18

% Begin initialization code - DO NOT EDIT
gui_Singleton = 1;
gui_State = struct('gui_Name',       mfilename, ...
                   'gui_Singleton',  gui_Singleton, ...
                   'gui_OpeningFcn', @GUI_OpeningFcn, ...
                   'gui_OutputFcn',  @GUI_OutputFcn, ...
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

% --- Executes just before GUI is made visible.
function GUI_OpeningFcn(hObject, eventdata, handles, varargin)
% This function has no output args, see OutputFcn.
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
% varargin   command line arguments to GUI (see VARARGIN)

% Choose default command line output for GUI
handles.output = hObject;

% Update handles structure
guidata(hObject, handles);
plot([-10000000 -10000000],'b')
axes(handles.axes1);
xlim([0 10]);
ylim([0 10]);

% This sets up the initial plot - only do when we are invisible
% so window can get raised using GUI.
%if strcmp(get(hObject,'Visible'),'off')
%    plot(rand(5));
%end

% UIWAIT makes GUI wait for user response (see UIRESUME)
% uiwait(handles.figure1);


% --- Outputs from this function are returned to the command line.
function varargout = GUI_OutputFcn(hObject, eventdata, handles)
% varargout  cell array for returning output args (see VARARGOUT);
% hObject    handle to figure
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Get default command line output from handles structure
varargout{1} = handles.output;

% --- Executes on button press in pushbutton1.
function pushbutton1_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
cla(handles.axes1,'reset');
axes(handles.axes1);
x_min=str2double(get(handles.edit1,'String'));
x_max=str2double(get(handles.edit2,'String'));
xlim([x_min x_max]);
y_min=str2double(get(handles.edit3,'String'));
y_max=str2double(get(handles.edit4,'String'));
ylim([y_min y_max]);



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
file = uigetfile('*.fig');
if ~isequal(file, 0)
    open(file);
end

% --------------------------------------------------------------------
function PrintMenuItem_Callback(hObject, eventdata, handles)
% hObject    handle to PrintMenuItem (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
printdlg(handles.figure1)

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


% --- Executes on selection change in popupmenu1.
function popupmenu1_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = get(hObject,'String') returns popupmenu1 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu1


% --- Executes during object creation, after setting all properties.
function popupmenu1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
     set(hObject,'BackgroundColor','white');
end

set(hObject, 'String', {'plot(rand(5))', 'plot(sin(1:0.01:25))', 'bar(1:.5:10)', 'plot(membrane)', 'surf(peaks)'});


% --------------------------------------------------------------------
function Untitled_1_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function Untitled_2_Callback(hObject, eventdata, handles)
% hObject    handle to Untitled_2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)


% --------------------------------------------------------------------
function line_Callback(hObject, eventdata, handles)
% hObject    handle to line (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
imline;


% --------------------------------------------------------------------
function draw_Callback(hObject, eventdata, handles)
% hObject    handle to draw (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)



function edit1_Callback(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit1 as text
%        str2double(get(hObject,'String')) returns contents of edit1 as a double


% --- Executes during object creation, after setting all properties.
function edit1_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit1 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit2_Callback(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit2 as text
%        str2double(get(hObject,'String')) returns contents of edit2 as a double


% --- Executes during object creation, after setting all properties.
function edit2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit3_Callback(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit3 as text
%        str2double(get(hObject,'String')) returns contents of edit3 as a double


% --- Executes during object creation, after setting all properties.
function edit3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end



function edit4_Callback(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: get(hObject,'String') returns contents of edit4 as text
%        str2double(get(hObject,'String')) returns contents of edit4 as a double


% --- Executes during object creation, after setting all properties.
function edit4_CreateFcn(hObject, eventdata, handles)
% hObject    handle to edit4 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: edit controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton2.
function pushbutton2_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
axes(handles.axes1);
x_min=str2double(get(handles.edit1,'String'));
x_max=str2double(get(handles.edit2,'String'));
xlim([x_min x_max]);
y_min=str2double(get(handles.edit3,'String'));
y_max=str2double(get(handles.edit4,'String'));
ylim([y_min y_max]);

popup_sel_index = get(handles.popupmenu5, 'Value');
shape_sel_index = get(handles.popupmenu2, 'Value');
level_sel_index = get(handles.popupmenu3, 'Value');

%color definitions:
obs_color=[139/255 0 0];
spoint_color=[255/255 105/255 180/255];
gpoint_color=[80/255 0 139/255];
wall_color=[65/255 105/255 225/255];
door_color=[0 128/255 0];
danger_low=[255/255 255/255 0];
danger_med=[255/255 127/255 0];
danger_high=[255/255 0 0];
danger_color=[danger_low;danger_med;danger_high];

switch popup_sel_index
    case 2
        start_point=impoint;
        start_point.setColor(spoint_color);
        pos=start_point.getPosition();
        start_point.delete();
        axes(handles.axes1);
        plot(pos(1),pos(2),'.','Color',spoint_color);
        hold on
        xlim([x_min x_max]);
        ylim([y_min y_max]);
    case 3
        goal_point=impoint;
        goal_point.setColor(gpoint_color)
        pos=goal_point.getPosition();
        goal_point.delete();
        axes(handles.axes1);
        plot(pos(1),pos(2),'.','Color',gpoint_color);
        hold on
        xlim([x_min x_max]);
        ylim([y_min y_max]);
    case 4
        wall_line=imline;
        wall_line.setColor(wall_color)
        pos=wall_line.getPosition();
        wall_line.delete();
        line(pos(:,1),pos(:,2),'LineWidth',6,'Color',wall_color);
        hold on
    case 5
        door_line=imline;
        door_line.setColor(door_color)
        pos=door_line.getPosition();
        door_line.delete();
        line(pos(:,1),pos(:,2),'LineWidth',8,'Color',door_color);
        hold on
    case 6
        switch shape_sel_index
            case 2
                obs=imrect;
                obs.setColor(obs_color);
                obs.setResizable(0);
                pos=obs.getPosition();
                obs.delete();
                rectangle('Position',pos,'FaceColor',obs_color,'EdgeColor',obs_color);
                hold on
            case 3
                obs=imellipse;
                obs.setColor(obs_color);
                obs.setResizable(0);
                pos=obs.getPosition();
                obs.delete();
                FilledEllipse([pos(1)+pos(3)/2 pos(2)+pos(4)/2],pos(3)/2, pos(4)/2,100,obs_color);   
                hold on
                xlim([x_min x_max]);
                ylim([y_min y_max]);
        end
    case 7
        switch shape_sel_index
            case 2
                danger=imrect;
                danger.setColor(danger_color(level_sel_index-1,:))
                danger.setResizable(0);
                pos=danger.getPosition();
                danger.delete();
                rectangle('Position',pos,'FaceColor',danger_color(level_sel_index-1,:),'EdgeColor',danger_color(level_sel_index-1,:));
                hold on
            case 3
                danger=imellipse;
                danger.setColor(danger_color(level_sel_index-1,:))
                danger.setResizable(0);
                pos=danger.getPosition();
                danger.delete();
                FilledEllipse([pos(1)+pos(3)/2 pos(2)+pos(4)/2],pos(3)/2, pos(4)/2,100,danger_color(level_sel_index-1,:));   
                hold on
                xlim([x_min x_max]);
                ylim([y_min y_max]);
        end
end


% --- Executes on selection change in popupmenu2.
function popupmenu2_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu2 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu2


% --- Executes during object creation, after setting all properties.
function popupmenu2_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu2 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu3.
function popupmenu3_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu3 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu3


% --- Executes during object creation, after setting all properties.
function popupmenu3_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on selection change in popupmenu5.
function popupmenu5_Callback(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)

% Hints: contents = cellstr(get(hObject,'String')) returns popupmenu5 contents as cell array
%        contents{get(hObject,'Value')} returns selected item from popupmenu5


% --- Executes during object creation, after setting all properties.
function popupmenu5_CreateFcn(hObject, eventdata, handles)
% hObject    handle to popupmenu5 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    empty - handles not created until after all CreateFcns called

% Hint: popupmenu controls usually have a white background on Windows.
%       See ISPC and COMPUTER.
if ispc && isequal(get(hObject,'BackgroundColor'), get(0,'defaultUicontrolBackgroundColor'))
    set(hObject,'BackgroundColor','white');
end


% --- Executes on button press in pushbutton3.
function pushbutton3_Callback(hObject, eventdata, handles)
% hObject    handle to pushbutton3 (see GCBO)
% eventdata  reserved - to be defined in a future version of MATLAB
% handles    structure with handles and user data (see GUIDATA)
F = getframe(handles.axes1);
Image = frame2im(F);
imwrite(Image, 'environment.jpg')
%% Xiang He
h = getframe(handles.axes1);
org_img = im2double(h.cdata);
[img_H, img_W] = size(org_img);
img_W = img_W/3;
fid_high=fopen('Map_Highresolution.dat','w+');
fid_low=fopen('Map_Lowresolution.dat','w+');
for i = 1:img_H
    for j = 1:img_W
        if (abs(org_img(i,j,1)-65/255)<0.04 && abs(org_img(i,j,2)-105/255)<0.04) && abs(org_img(i,j,3)-225/255)<0.04
            fprintf(fid_high,'w');%Wall
        elseif (abs(org_img(i,j,1)-255/255)<0.04 && abs(org_img(i,j,2)-105/255)<0.04) && abs(org_img(i,j,3)-180/255)<0.04
            fprintf(fid_high,'s');%Start
        elseif (abs(org_img(i,j,1)-80/255)<0.04 && abs(org_img(i,j,2)-0/255)<0.04) && abs(org_img(i,j,3)-139/255)<0.04
            fprintf(fid_high,'g');%Goal
        elseif (abs(org_img(i,j,1)-0/255)<0.04 && abs(org_img(i,j,2)-128/255)<0.04) && abs(org_img(i,j,3)-0/255)<0.04
            fprintf(fid_high,'0');%Door
        elseif (abs(org_img(i,j,1)-255/255)<0.04 && abs(org_img(i,j,2)-255/255)<0.04) && abs(org_img(i,j,3)-0/255)<0.04
            fprintf(fid_high,'l');%Low
        elseif (abs(org_img(i,j,1)-255/255)<0.04 && abs(org_img(i,j,2)-127/255)<0.04) && abs(org_img(i,j,3)-0/255)<0.04
            fprintf(fid_high,'m');%Medium
        elseif (abs(org_img(i,j,1)-255/255)<0.04 && abs(org_img(i,j,2)-0/255)<0.04) && abs(org_img(i,j,3)-0/255)<0.04
            fprintf(fid_high,'h');%High
        elseif (abs(org_img(i,j,1)-139/255)<0.04 && abs(org_img(i,j,2)-0/255)<0.04) && abs(org_img(i,j,3)-0/255)<0.04
            fprintf(fid_high,'o');%Obstacle
        else
            fprintf(fid_high,'0');
        end
    end
    fprintf(fid_high,'\n');
end
obstacle = 0;
for i = 1:20:img_H-20
    for j = 1:20:img_W-20
        for ii = i:i+19
            for jj = j:j+19
                if org_img(ii,jj,1)<235 || org_img(ii,jj,2)<235 || org_img(ii,jj,3)<235
                    obstacle = 1;
                end
            end
        end
        if obstacle == 1
            fprintf(fid_low,'x');
        else
            fprintf(fid_low,'0');
        end
        obstacle = 0;
    end
    fprintf(fid_low,'\n');
end
fclose(fid_high);
fclose(fid_low);
