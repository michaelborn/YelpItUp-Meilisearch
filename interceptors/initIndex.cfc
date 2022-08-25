component {

    function getClient() provider="Client@cbmeilisearch"{}

    /**
     * Initialize the ElasticSearch index on app load/reinit
     */
    void function afterConfigurationLoad( event, interceptData ){
        setting requesttimeout="500";
        dropAndRecreateIndex();

        populateReviews(
            file = getSetting( "contentPath" ) & "yelp_academic_dataset_review.json",
            maxToPopulate = 1000
        );
    }

    private function populateReviews(
        required string file,
        numeric maxToPopulate = 100,
        numeric maxBatchSize = 100
    ){
        if ( !fileExists( arguments.file ) ){
            throw( "File does not exist", "yelpItUp.interceptors.initIndex", arguments.file );
        }

        var fileObject = fileOpen( arguments.file );
        var populatedCount = 0;
        while(
            !fileIsEOF( fileObject ) 
            && populatedCount < arguments.maxToPopulate
        ){
            var json = fileReadLine( fileObject );
            if ( isJSON( json ) ){
                /**
                 * 1. ADD single document here.
                 */
                getClient().addDocuments(
                    index = "reviews",
                    documents = [ deserializeJSON( json ) ],
                    primaryKey = "review_id"
                );

                populatedCount++;
            }
            /**
             * 2. Add document batch via `documentBatch` array.
             */
        }
        fileClose( fileObject );
    }

    private function dropAndRecreateIndex(){
        var msClient = getClient();

        /**
         * 1. DROP old index
         */
        msClient.deleteIndex( "reviews" );

        /**
         * 2. CREATE new index
         */
        var task = msClient.createIndex(
            uid = "reviews",
            primaryKey = "review_id"
        ).json();

        /**
         * 3. WAIT until index creation is completed
         */
        msClient.waitForTask( task.taskUid );

        /**
         * 4. APPLY new index settings
         */
        var result = msClient.updateSettings( "reviews", {
            "filterableAttributes": [ "stars" ],
            "sortableAttributes" : [ "stars", "useful", "date" ]
            // other settings here...
        } );
    }
}