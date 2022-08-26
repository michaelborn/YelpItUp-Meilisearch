# Live Coding

## Meilisearch Startup

With no API key:

```bash
docker run --detach --rm \
    -p 7700:7700 \
    getmeili/meilisearch \
    meilisearch --env="development"
```

With an API key:

```bash
docker run --detach --rm \
    -p 7700:7700 \
    -e MEILI_MASTER_KEY='mySecretKey'\
    getmeili/meilisearch \
    meilisearch --env="development"
```

## Connecting to Meilisearch

Set some config in `config/ColdBox.cfc`:

```js
moduleSettings = {
    "cbMeilisearch" : {
        "MEILISEARCH_HOST" : "localhost",
        "MEILISEARCH_PORT" : 7700,
        "MEILISEARCH_MASTER_KEY" : ""
    }
};
```

Or in the `.env`:

```bash
# CBElasticsearch module configuration
MEILISEARCH_HOST=http://127.0.0.1
MEILISEARCH_PORT=7700
MEILISEARCH_MASTER_KEY=mySecretKey
```

## Ensuring Meilisearch is Reachable

```js
var response = getClient().version();
if ( !response.isSuccess() ){
    throw(
        message = "Meilisearch Unavailable",
        type="MeilisearchConnectionFailed",
        extendedInfo = serializeJSON( response.getMemento() )
    );
}
```

## Managing Indexes

Pretty simple. An index is like a database table.

A document is like a row in the table.

### Deleting an index

```js
msClient.deleteIndex( "reviews" );
```

### Create an Index

```js
var task = msClient.createIndex(
    uid = "reviews",
    primaryKey = "review_id"
).json();
```

## Adding Documents

```js
msClient.addDocuments(
    index = "reviews",
    documents = [ deSerializeJSON( json ) ],
    primaryKey = "review_id"
);
```

## Searching

Pretty easy - call `client.search()`, pass an index uid, and a struct of options.

```js
var response = msClient.search( "reviews", {});
```

Use the `.json().hits` to grab the actual result from a successful response.

```js
prc.reviews = response.json().hits;
```

A NOT successful response, though, may not be JSON at all. We need proper error handling:

### Error Handling

```js
var response = msClient.search( "reviews", {});
if( response.isError() ){
    throw(
        message = "MeilisearchAPIException",
        type = "MeilisearchAPIException",
        detail = response.getData(),
        extendedInfo = serializeJSON( response.getMemento() )
    );
}
```

### Filters

To search with a filter, use the `filter` parameter:

```js
var response = msClient.search( "reviews", {
    "q"                     = event.getValue( "query", "" ),
    "filter"                = "stars >= #event.getValue( 'stars', 0 )#"
} );
```

This will fail because we didn't set the `filterableAttributes` on the index.

## Set Filterable Attributes

To set this single setting:

```js
var response = msClient.updateFilterableAttributes( "reviews", [ "stars" ] );
```

To set this along with some other settings:

```js
var response = msClient.updateSettings( "reviews", {
    "filterableAttributes": [ "stars" ],
    // other settings here...
} );
```

However, this call will likely error if run from our `InitIndex` interceptor, because the index has not been created yet. That is, the index creation is done asynchronously... and may not be completed by the time our next API call goes out.

### Async Index Creation

To fix this, we need to wait synchronously for the index creation to complete, use `waitForTask()` with the returned task id.

```js
msClient.waitForTask( task.taskUid );
```

### Sorting

To show MOST useful first:

```js
var response = msClient.search( "reviews", {
    "q"   : event.getValue( "query", "" ),
    "sort": [ "useful:desc" ]
});
```

To show LEAST useful first:

```js
var response = msClient.search( "reviews", {
    "q"   : event.getValue( "query", "" ),
    "sort": [ "useful:asc" ]
});
```

To use the selector:

```js
var response = msClient.search( "reviews", {
    "q"                    : event.getValue( "query", "" ),
    "attributesToHighlight": [ "text" ],
    "sort"                 : [ event.getValue( "sortBy", "" ) ]
});
```

### Using Search Opts

Because, sadly, we don't have a great way to conditionally add an argument.

```js
var searchOpts = {
    "q"                    : event.getValue( "query", "" ),
    "filter"               : "stars >= #event.getValue( 'stars', 0 )#",
    "attributesToHighlight": [ "text" ]
};
if ( event.getValue( "sortBy", "" ) != "" ){
    searchOpts[ "sort" ] = [ event.getValue( "sortBy", "" ) ];
}
var response = msClient.search( "reviews", searchOpts);
```

### Set Sortable Attributes


```js
var response = msClient.updateSettings( "reviews", {
    "filterableAttributes": [ "stars" ],
    "sortableAttributes" : [ "stars", "useful", "date" ]
    // other settings here...
} );
```

### Highlighting

To highlight matching terms, use the `attributesToHighlight` parameter:

```js
var response = msClient.search( "reviews", {
    "q"                     = event.getValue( "query", "" ),
    "attributesToHighlight" : [ "text" ]
});
```

Then you'll see Meilisearch returns the `_formatted` struct along with each document in the response. Each highlighted term is wrapped in `<em></em>` tags.

## Advanced (large batch) Document Imports

Change `populateReviews()`'s inner loop to this:

```js
var currentBatchSize = 0;
var documentBatch = [];
while(
    !fileIsEOF( fileObject )
    && populatedCount < arguments.maxToPopulate
    && currentBatchSize < arguments.maxBatchSize 
){
    var json = fileReadLine( fileObject );
    if ( isJSON( json ) ){
        documentBatch.append( deSerializeJSON( json ) );

        populatedCount++;
        currentBatchSize++;
    }
}
getClient().addDocuments(
    index = "reviews",
    documents = documentBatch,
    primaryKey = "review_id"
);
documentBatch = [];
```

This will batch the documents to serialize MUCH quicker, allowing us to serialize perhaps 10k in a minute or two.

Watch the document count go up on the Meilisearch dashboard:

http://localhost:7700/

Watch the docker container memory and CPU stats:

```bash
docker stats
```

## Managing API Keys 

```js
msClient.doSomething();
```

## Stats

```js
msClient.doSomething();
```

## Version

```js
msClient.doSomething();
```

## Dumps