function KeyPressSpectraFcn(src,event)
key = event.Key;
modifier = event.Modifier;
switch key
    case 'c' %copy the figure as vector or image
        %get modifiers active during the keypress
        isactive = ismember({'control','shift','alt'}, modifier);
        controlDown = [true,false,false];
        controlAltDown = [true,true,false];
        %chek if control modifier is pressed and copy the figure
        if all(isactive == controlDown)
            copygraphics(src,ContentType = 'vector')
        elseif all(isactive ==controlAltDown)
            copygraphics(src,ContentType = 'image')
        end
end

end