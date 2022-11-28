"""Client struct details

# Arguments
- `apikey::String`: Your New Relic API Key
- `accountid::String`: The account id for the account you want to query
- `newrelicurl::String`: The url of the newrelic api. Defaults to https://api.newrelic.com/graphql
- `timeout::Int`: The timeout in seconds for a query. Defaults to 60
"""
mutable struct Client
    apikey::String
    accountid::Int
    newrelicurl::String
    timeout::Int
    function Client(apikey::String, accountid::Int)
        return new(apikey, accountid, "https://api.newrelic.com/graphql", 60)
    end
end

"""
    runquery(client::Client, query::String)

This processes the columns and parses them into types that are more reflective of the data

# Argument
- `client::Client`: This is the NR Client 
- `query::String`: A valid NRQL query
"""
function runquery(client::Client, query::String)
    querygraqhql = "{
                       actor {
                         account(id: $(client.accountid)) {
                                nrql(query: \"$(query)\") {
                            results
                                }
                            }
                        }
                    }"
    myjson = Dict("query"=>querygraqhql)
    my_headers = HTTP.mkheaders(["Content-Type" => "application/json" ,"API-Key" => client.apikey])
    r = HTTP.post(client.newrelicurl,my_headers,JSON.json(myjson))
    results = String(r.body)
    resultsjsonobject = stringtojson3array(results)
    resultsdataframe = arraytodataframe(resultsjsonobject)
    resultsdataframe = processdatatypes(resultsdataframe)
    return resultsdataframe
end