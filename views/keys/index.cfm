<cfoutput>
    <main>
        <div class="container mx-auto py-8 px-4">
            <h1 class="text-3xl font-bold mb-8">Meilisearch API Keys</h1>
            <cfloop array="#prc.records.results#" item="key" index="i">
                <div class="mb-8 border-b-2 pb-8">
                    <h4 class="text-xl font-bold mb-4">#key.name#</h4>
                    <p>#key.description#</p>
                    <pre class="my-2 p-4 bg-gray-200 text-red-800"><code>#key.key#</code></pre>
                    <ul class="italic text-gray-700">
                        <li class="mb-1">Created #dateTimeFormat( key.createdAt, "YYYY-mm-dd hh:nn:ss" )#</li>
                        <li class="mb-1">Last updated #dateTimeFormat( key.updatedAt, "YYYY-mm-dd hh:nn:ss" )#</li>
                        <li class="mb-1">Expires: <cfif isNull( key.expiresAt )><span class="font-bold">Never</span><cfelse>#dateTimeFormat( key.expiresAt, "YYYY-mm-dd hh:nn:ss" )#</cfif></li>
                    </ul>
                </div>
            </cfloop>
        </div>
    </main>
</cfoutput>