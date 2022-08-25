<cfoutput>
    <!--- <cfdump var="#review#" /><cfabort /> --->
    <article class="p-6 border-solid border-b-2">
        <cfif review.keyExists( "_formatted" ) && !structIsEmpty(review._formatted)>
            <cfif review._formatted.keyExists( "text" )>
                <!--- <cfloop array="#review._formatted.text#" item="highlight">
                    <p class="mb-4 highlight italic">...#highlight#...</p>
                </cfloop> --->
                <p class="mb-4 highlight italic">...#review._formatted.text#...</p>
            </cfif>
        </cfif>
        <!--- <p class="mb-4">#review.text#</p> --->
        <div class="review__footer flex flex-row justify-start">
            <div class="stars px-2">
                <cfloop from="1" to="#int(review.stars)#" index="starCount">
                    <i class="fa fa-star text-yellow-700" aria-hidden="true"></i>
                </cfloop>
            </div>
            <div class="useful px-2">
                <i class="fa fa-thumbs-up text-yellow-800" aria-hidden="true"></i> <span class="text-gray-700 italic">#int(review.useful)# people found this review helpful</span>
            </div>
        </div>
    </article>
</cfoutput>