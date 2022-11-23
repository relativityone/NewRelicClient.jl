"""
    jsonstringtodataframe(jsonstring::String)

Take the given string containing JSON and parse it into a flattened dataframe

# Argument
- `jsonstring::String`: The JSON returned by New Relic NerdGraph API
"""
function jsonstringtodataframe(jsonstring::String)