"""
    stringtojson3array(jsonstring::String)

Take the given string and return an AbstractArray object

# Argument
- `jsonstring::String`: The JSON returned by New Relic NerdGraph API
"""
function stringtojson3array(jsonstring::String)
    jsonparsed = JSON3.read(jsonstring)
    try
        jsonresults = jsonparsed["data"]["actor"]["account"]["nrql"]["results"]
        if isa(jsonresults, JSON3.Array)
            return jsonresults
        elseif isa(jsonresults, JSON3.Object)
            return [jsonresults]
        else
            throw(TypeError)
        end
    catch e
        if isa(e, KeyError)
            println("This is not a New Relic Formatted String.")
            return e 
        end
    end
end

"""
    arraytodataframe(jsonarray::AbstractArray)

Take the given abstractarray of abstractdicts and parse it into a flattened dataframe

# Argument
- `jsonarray::AbstractArray`: The AbstractArray that is supposed to be turned into a DataFrame
"""
function arraytodataframe(jsonarray::AbstractArray)
    dictkeys = finddictkeys(jsonarray)
    resultsdf = DataFrame()
    for jsonobject in jsonarray
        if !isnothing(dictkeys) && !isempty(intersect(keys(jsonobject), dictkeys))
            jsoncopy = copy(jsonobject)
            for key in intersect(keys(jsoncopy), dictkeys)
                tempdict = jsoncopy[key]
                for (tempkey, value) in tempdict
                    jsoncopy[Symbol("$(key)_$(tempkey)")] = value
                end
                pop!(jsoncopy, key)
            end
            push!(resultsdf, jsoncopy, cols=:union)
            
        else
            push!(resultsdf, jsonobject, cols=:union)
        end
    end
    return resultsdf
end

"""
    processdatatypes(nrdataframe::DataFrame)

This processes the columns and parses them into types that are more reflective of the data

# Argument
- `nrdataframe::DataFrame`: This is the results data frame from a NR query
"""
function processdatatypes(nrdataframe::DataFrame)
    for n in names(nrdataframe)
        if n == "endTimeSeconds" || n == "beginTimeSeconds"
            nrdataframe[!, n] = Dates.unix2datetime.(nrdataframe[:,n])
        elseif isa(nrdataframe[!, n], Vector{Union{Missing, String}}) || isa(nrdataframe[!, n], Float64) || isa(nrdataframe[!, n], Int)
            resultsstore = []
            for row in eachrow(nrdataframe)
                if ismissing(row[n]) || isempty(row[n])
                    push!(resultsstore, missing)
                elseif length(row[n]) < 20
                    break
                elseif row[n][begin:2] == "20" && row[n][end] == 'Z'
                    println(row[n][begin:19])
                    if contains(row[n], "T")
                        push!(resultsstore, DateTime(row[n][begin:19]))
                    else
                        push!(resultsstore, DateTime(row[n][begin:19], DateFormat("y-m-d H:M:S")))
                    end
                else
                    break
                end
            end
            if size(resultsstore) == size(nrdataframe[!, n])
                nrdataframe[!, n] = resultsstore
            end
        end
    end
    return nrdataframe
end

"""
    extractfacets(nrdataframe::DataFrame, query::String)

This processes the columns and extracts the facet data into their own columns

# Argument
- `nrdataframe::DataFrame`: This is the results data frame from a NR query
- `query::String`: This is the query string which we need to extract the facet information
"""
function extractfacets!(nrdataframe::DataFrame, query::String)
    facets = getfacetnames(query)
    for facet in facets
        nrdataframe[:, facet] .= ""
    end
    for row in eachrow(nrdataframe)
        facetvalues = row["facet"]
        for (key, value) in zip(facets, facetvalues)
            row[key] = value
        end
    end
end