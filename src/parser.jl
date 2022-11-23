

"""
    stringtojson3array(jsonstring::String)

Take the given string and return an AbstractArray object

# Argument
- `jsonstring::String`: The JSON returned by New Relic NerdGraph API
"""
function stringtojson3array(jsonstring::String)
    jsonparsed = JSON3.read(jsonstring)
    jsonresults = jsonparsed["data"]["actor"]["account"]["nrql"]["results"]
    if isa(jsonresults, JSON3.Array)
        return jsonresults
    else if isa(jsonresults, JSON3.Object)
        return [jsonresults]
    else
        throw(TypeError)
    end
end

"""
    jsonarraytodataframe(jsonarray::JSON3.Array)

Take the given string containing JSON and parse it into a flattened dataframe

# Argument
- `jsonarray::JSON3.Array`: The AbstractArray that is supposed to be turned into a DataFrame
"""
function jsonstringtodataframe(jsonarray::AbstractArray)

    for key in keys(jsonarray[1])
        println(key)
    end
    return
end
