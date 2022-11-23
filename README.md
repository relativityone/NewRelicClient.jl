# NewRelicClient
This is an **unofficial** client for the [New Relic GraphQL API](https://docs.newrelic.com/docs/apis/nerdgraph/get-started/introduction-new-relic-nerdgraph/). This project is **not** affiliated with or endorsed by New Relic.  

# New Relic Information
## New Relic NerdGraph
This is the [New Relic GraphQL API](https://docs.newrelic.com/docs/apis/nerdgraph/get-started/introduction-new-relic-nerdgraph/) that supports querying for your account's observability data. 

### New Relic Queries
To learn the New Relic query language please see [here](https://docs.newrelic.com/docs/query-your-data/nrql-new-relic-query-language/get-started/nrql-syntax-clauses-functions/)

### Exploring NerdGraph
New Relic built an [explorer](https://docs.newrelic.com/docs/apis/nerdgraph/get-started/nerdgraph-explorer) to get familiar with their NerdGraph API

# Client Description
This unoffical client is aimed at the use case of **querying** your observability data from the NerdGraph api. 

## Requirements for use
In order to use this API you need:
1. [User API Key](https://docs.newrelic.com/docs/apis/intro-apis/new-relic-api-keys/)
2. Account id for the account you want to query your data from

## Installing the client
```julia
using Pkg; Pkg.add("NewRelicClient")
```
