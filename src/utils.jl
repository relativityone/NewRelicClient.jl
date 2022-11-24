function finddictkeys(jsonobject::AbstractDict)
    dictkeys = []
    for key in keys(jsonobject)
        println(key, ' ', typeof(jsonobject[key]))
        if isa(jsonobject[key], AbstractDict)
            push!(dictkeys, key)
        end                
    end
    if isempty(dictkeys)
        return nothing
    else
        return dictkeys
    end
end