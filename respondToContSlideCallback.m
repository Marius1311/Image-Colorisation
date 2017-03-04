 % --- Executes on slider movement.
 function respondToContSlideCallback(hObject, eventdata)
 % hObject    handle to slider1 (see GCBO)
 % eventdata  reserved - to be defined in a future version of MATLAB

 % Hints: get(hObject,'Value') returns position of slider
 %        get(hObject,'Min') and get(hObject,'Max') to determine range of sli
 % first we need the handles structure which we can get from hObject
 handles = guidata(hObject);

 % get the slider value and convert it to the nearest integer that is less
 % than this value
 newVal = floor(get(hObject,'Value'));

 % set the slider value to this integer which will be in the set {1,2,3,...,12,13}
 set(hObject,'Value',newVal);
 
 % now only do something in response to the slider movement if the 
 % new value is different from the last slider value
 if newVal ~= handles.lastSliderVal
 % it is different, so we have moved up or down from the previous intege
     % save the new value
     handles.lastSliderVal = newVal;
     guidata(hObject,handles);
     set(handles.pixelsNumber, 'String', ['n =  ' num2str(get(hObject,'Value'))]);
     handles.npixels = get(hObject,'Value');
    % display the current value of the slider
   % disp(['at slider value ' num2str(get(hObject,'Value'))]);
 end
 
 % Update handles structure
guidata(hObject, handles);

 end
 
