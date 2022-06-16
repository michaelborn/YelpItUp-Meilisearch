component {

    /**
     * Initialize the ElasticSearch index on app load/reinit
     */
    void function afterConfigurationLoad( event, interceptData ){
        try {
            setting requesttimeout="500";
            var recreateIndex = true;

            if( recreateIndex ){
                getIndexClient().delete( "reviews" );
            }

            // if ( !getESClient().indexExists( "reviews" ) ){
                var result = getIndexClient().create(
                    uid = "reviews",
                    primaryKey = "review_id"
                );
            // }

            if ( recreateIndex ){
                populateReviews(
                    file = getSetting( "contentPath" ) & "yelp_academic_dataset_review.json",
                    index = "reviews",
                    primaryKey = "review_id",
                    maxToPopulate = 1000
                );
            }

        } catch( io.searchbox.client.config.exception.CouldNotConnectException exception ){
            writeOutput( "Unable to connect to ElasticSearch." );
            abort;
        }
    }

    function populateReviews(
        required string file,
        required string index,
        required string primaryKey,
        numeric maxToPopulate = 100
    ){
        if ( !fileExists( arguments.file ) ){
            throw( "File does not exist", "yelpItUp.interceptors.initIndex", arguments.file );
        }

        var fileObject = fileOpen( arguments.file );
        var populatedCount = 0;
        while( !fileIsEOF( fileObject ) && populatedCount < arguments.maxToPopulate ){

            var json = fileReadLine( fileObject );
            if ( isJSON( json ) ){
                var data = deSerializeJSON( json );

                // clean up bad values
                data["date"] = dateTimeFormat( lsParseDateTime( data["date"] ), "yyyy-MM-dd'T'HH:nn:ssXXX");
                getDocumentClient().addOrReplace(
                    index = arguments.index,
                    documents = [ data ],
                    primaryKey = primaryKey
                );

                populatedCount++;
            }
            
        }
        fileClose( fileObject );
    }

    Indexes function getIndexClient() provider="Indexes@cbmeilisearch"{}

    Documents function getDocumentClient() provider="Documents@cbmeilisearch"{}
}