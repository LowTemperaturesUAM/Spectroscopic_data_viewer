function mustBeLogical(a)
    if ~islogical(a)
        eidType = 'mustbelogical:trueorfalse';
        msgType = 'Input must be a logical value.';
        error(eidType,msgType)
    end
end