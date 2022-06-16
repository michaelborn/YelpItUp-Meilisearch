component extends="Main" {

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
            var result = getInstance( "Search@cbMeilisearch" )
                            .searchWithPost(
                                index = "reviews",
                                q = event.getValue( "query" ),
                                attributesToHighlight = [ "text" ],
                                attributesToCrop = [ "text" ],
                                cropLength = 10
                            );

            // if ( event.getValue( "stars", "" ) != "" ){
            //     search.filterTerm( "stars", event.getValue( "stars" ) );
            // }
            prc.reviews = result.hits;
        }
    }
}