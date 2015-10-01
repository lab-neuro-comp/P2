function value_error=checkvalue(handle)
value=str2num(get(handle,'string'));
switch isempty(value)
    case 1
        msgbox('Definition error')
        set(handle,'string','error')
        value_error=1;
        return
    case 0
        dim=size(value);
        if max(dim)>1
            msgbox('Definition error')
            set(handle,'string','error')
            value_error=1;
            return
        end
end
value_error=0;