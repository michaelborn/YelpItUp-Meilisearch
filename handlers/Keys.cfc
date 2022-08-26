component extends="Main"{

    property name="msClient" inject="Client@cbMeilisearch";

    function index( event, rc, prc ){
        var hyperResponse = msClient.getAllKeys();
        msClient.parseAndThrow( hyperResponse );

        prc.records = hyperResponse.json();
        event.setView( "keys/index" );
    }
}