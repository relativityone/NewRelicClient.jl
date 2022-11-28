function finddictkeys(jsonarray::AbstractArray)
    dictkeys = Set()
    for jsonobject in jsonarray
        for key in keys(jsonobject)
            #println(key, ' ', typeof(jsonobject[key]))
            if isa(jsonobject[key], AbstractDict)
                push!(dictkeys, key)
            end                
        end
    end
    if isempty(dictkeys)
        return nothing
    else
        return dictkeys
    end
end

function getuniquekeys(jsonarray::AbstractArray)
    uniquekeys = Set()
    for jsonobject in jsonarray
        push!(uniquekeys, keys(jsonobject))
    end
    return uniquekeys
end