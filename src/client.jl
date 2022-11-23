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


