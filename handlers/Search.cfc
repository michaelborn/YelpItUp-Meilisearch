component extends="Main" {

    /**
     * INJECT cbMeilisearch API client
     */

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
            /**
             * SEARCH
             */

            /**
             * ERROR HANDLING
             */

            /**
             * SET search results
             */
        }
    }
}