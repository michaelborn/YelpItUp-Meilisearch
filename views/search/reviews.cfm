<cfscript>
    stars = event.getValue( "stars", "0" );
    queryText = event.getValue( "query", "" );
    sortBy = event.getValue( "sortBy", "" );
</cfscript>
<cfoutput>
    <main>
        <div class="container mx-auto">
            <div class="flex flex-wrap">
                <div class="<cfif NOT prc.reviews.len()>flex-grow<cfelse>md:w-1/3</cfif>">
                    #renderView( "partials/form" )#
                </div>
    
                <cfif NOT prc.reviews.len()>
                    <p class="bg-orange-300 text-black p-4 mt-8 w-full block">
                        No results found for your search.
                    </p>
                <cfelse>
                    <div class="reviews px-4 md:w-2/3">
                        <form action="/search/reviews" class="flex justify-end my-4" x-data="{}" x-ref="form">
                            <input type="hidden" name="query" value="#queryText#" />
                            <input type="hidden" name="stars" value="#stars#" />

                            <div class="flex flex-row w-64">
                                <div class="flex flex-grow">
                                    <label for="sortby" class="p-4 flex-grow">Sort</label>
                                    <select name="sortby" id="sortby" @input="$refs.form.submit()" class="block p-4 bg-gray text-gray-900 flex-grow">
                                        <option value=""<cfif sortBy == ""> selected</cfif>>Most relevant first</option>
                                        <option value="useful:desc"<cfif sortBy == "useful:desc"> selected</cfif>>Most useful first</option>
                                        <option value="stars:desc"<cfif sortBy == "stars:desc"> selected</cfif>>Most stars first</option>
                                    </select>
                                </div>
                            </div>
                        </form>
                        #renderView(
                            view = "search/review",
                            collection="#prc.reviews#"
                        )#
                    </div>
                </cfif>
            </div>
        </div>
    </main>
</cfoutput>
<style>
.highlight em {
    background: yellow;
    border-bottom: 1px dashed;
    font-style: normal;
}
</style>