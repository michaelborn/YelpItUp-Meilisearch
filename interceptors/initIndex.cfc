component {

    /**
     * Initialize the ElasticSearch index on app load/reinit
     */
    void function afterConfigurationLoad( event, interceptData ){
        setting requesttimeout="500";

        ensureMeilisearchReachable();
        dropAndRecreateIndex();

        populateReviews(
            file = getSetting( "contentPath" ) & "yelp_academic_dataset_review.json",
            maxToPopulate = 1000
        );
    }

    private function ensureMeilisearchReachable(){
        /**
         * 1. Check Meilisearch version
         * 2. Call parseAndThrow() to throw if connection error
         */
    }

    private function dropAndRecreateIndex(){

        /**
         * 1. DROP old index
         */

        /**
         * 2. CREATE new index
         */

        /**
         * 3. WAIT until index creation is completed
         */

        /**
         * 4. APPLY new index settings
         */
    }

    private function populateReviews(
        required string file,
        numeric maxToPopulate = 100,
        numeric maxBatchSize = 100
    ){
        if ( !fileExists( arguments.file ) ){
            throw( "File does not exist #arguments.file#" );
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

                populatedCount++;
            }
            /**
             * 2. Add document batch via `documentBatch` array.
             */
        }
        fileClose( fileObject );
    }
}