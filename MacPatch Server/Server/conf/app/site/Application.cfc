<cfcomponent output="false">
	<cfscript>
		// The name of the application
		this.name				= "MP_ADMIN";
		// We wish to enable the session managment
		this.sessionmanagement 	= true;
		// Sets the session timeout to be 15minutes
		this.sessiontimeout 	= CreateTimeSpan( 0, 0, 15, 0 );
	</cfscript>
	
	<!--- ---------------------------------------------
		This is where we can set some variables for the application scope
		http://openbd.org/manual/?/app_application
		--->
	<cffunction name="onApplicationStart">
		<cfset application.starttime = now()>
	</cffunction>
	
	<!--- ---------------------------------------------
		This is called for each request made to a public resource
		We clear down the flag for the user object so they do not accidentally
		log in again
		--->
	<cffunction name="onRequestStart">
		<cfargument name="uri" required="true"/>
		<cfset StructDelete( application, "settings" )>

		<cfset var xFile = "/Library/MacPatch/Server/conf/etc/siteconfig.xml">
  		<cfset var jFile = "/Library/MacPatch/Server/conf/etc/siteconfig.json">
  		
  		<cfif fileExists(jFile)>
			<cfinvoke component="Server.settings" method="getJSONAppSettings" returnvariable="_AppSettings">
				<cfinvokeargument name="cFile" value="#jFile#">
			</cfinvoke>
        <cfelse>
            <cfif fileExists(xFile)>
                <cfinvoke component="Server.settings" method="getAppSettings" returnvariable="_AppSettings">
                    <cfinvokeargument name="cFile" value="#xFile#">
                </cfinvoke>
            <cfelse>
            	<cfthrow message="No App Settings file found.">
            	<cfreturn>
            </cfif>
        </cfif>

	    <cfset application.settings = _AppSettings>
		<cfset StructDelete( session, "loggedin" )>
	</cffunction>

</cfcomponent>