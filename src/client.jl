"""Client struct details

# Arguments
- `apikey::String`: Your New Relic API Key
- `accountid::String`: The account id for the account you want to query
"""
mutable struct Client
    apikey::String
    accountid::Int
    timeout::Int
    function Client(apikey::String, accountid::Int)
        return new(apikey, accountid, 60)
    end
end