<cfoutput>
    <!DOCTYPE html>
    <html lang="en">
    <head>
        <meta charset="utf-8">
        <title>YelpItUp</title>
        <meta name="description" content="Sample Elasticsearch app for CFML">
        <meta name="author" content="Michael Born">
        <!---Base URL --->
        <base href="#event.getHTMLBaseURL()#" />
        <!---css --->
        <link href="https://unpkg.com/tailwindcss@^1.0/dist/tailwind.min.css" rel="stylesheet">
        <link rel="stylesheet" href="https://use.fontawesome.com/releases/v5.3.1/css/all.css" integrity="sha384-mzrmE5qonljUremFsqc01SB46JvROS7bZs3IO2EmfFsd15uHvIt+Y8vEf7N7fWAU" crossorigin="anonymous">
    </head>
    <body>
        
        <header class="bg-gray-300 block w-full py-10">
            <div class="container mx-auto px-4">
                <div class="flex justify-between">
                    <h1 class="text-3xl flex-shrink mr-4 py-2"><a href="/">YelpItUp</a></h1>

                    <nav class="flex-grow mx-24">
                        <ul class="block flex w-full">
                            <li><a href="/" class="block p-4 hover:bg-blue-800 hover:text-white">Home</a></li>
                            <li><a href="/search/reviews" class="block p-4 hover:bg-blue-800 hover:text-white">Search</a></li>
                            <li><a href="/keys" class="block p-4 hover:bg-blue-800 hover:text-white">Keys</a></li>
                        </ul>
                    </nav>
                    
                    #renderView( "partials/minimal_form" )#
                </div>
            </div>
        </header>
    
        <!---Container And Views --->
        <div style="min-height:72vh">#renderView()#</div>
    
        <footer class="border-top py-3 mt-5 bg-gray-900 text-white">
            <div class="container mx-auto">
                <div class="px-4 py-8">
                    <p class="text-center">Sample CBElasticsearch app by <a href="https://michaelborn.me">Michael Born</a></p>
                </div>
            </div>
        </footer>

        <!--- Scripts --->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/alpinejs/3.10.3/cdn.js" integrity="sha512-KnYVZoWDMDmJwjmoUEcEd//9bap1dhg0ltiMWtdoKwvVdmEFZGoKsFhYBzuwP2v2iHGnstBor8tjPcFQNgI5cA==" crossorigin="anonymous" referrerpolicy="no-referrer"></script>
    </body>
    </html>
</cfoutput>