component extends="Main" {

    property name="msClient" inject="Client@cbMeilisearch";

    /**
     * API handler /search/reviews
     *
     * @event url arguments and form arguments (form scope) here
     * @rc 
     * @prc 
     */
    function reviews( event, rc, prc ){
        prc.reviews = [];

        if ( event.getValue( "query", "" ) != "" ){
            var searchOpts = {
                "q"                    : event.getValue( "query", "" ),
                "filter"               : "stars >= #event.getValue( 'stars', 0 )#",
                "attributesToHighlight": [ "text" ]
            };
            if ( event.getValue( "sortBy", "" ) != "" ){
                searchOpts[ "sort" ] = [ event.getValue( "sortBy", "" ) ];
            }
            var result = msClient.search( "reviews", searchOpts);
            if( result.isError() ){
                throw(
                    message = "MeilisearchAPIException",
                    type = "MeilisearchAPIException",
                    detail = result.getData(),
                    extendedInfo = serializeJSON( result.getMemento() )
                );
            }
            prc.reviews = result.json().hits;
        }
    }
}