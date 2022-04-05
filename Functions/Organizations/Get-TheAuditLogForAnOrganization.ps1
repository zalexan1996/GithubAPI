
<#
.SYNOPSIS
Gets the audit log for an organization. For more information, see "Reviewing the audit log for your organization."
This endpoint is available for organizations on GitHub Enterprise Cloud. To use this endpoint, you must be an organization owner, and you must use an access token with the admin:org scope. GitHub Apps must have the organization_administration read permission to use this endpoint.
By default, the response includes up to 30 events from the past three months. Use the phrase parameter to filter results and retrieve older events. For example, use the phrase parameter with the created qualifier to filter events based on when the events occurred. For more information, see "Reviewing the audit log for your organization."
Use pagination to retrieve fewer or more than 30 events. For more information, see "Resources in the REST API."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER phrase
A search phrase. For more information, see Searching the audit log.
         
.PARAMETER include
The event types to include:
web - returns web (non-Git) events.
git - returns Git events.
all - returns both web and Git events.
The default is web.
         
.PARAMETER after
A cursor, as given in the Link header. If specified, the query only searches for events after this cursor.
         
.PARAMETER before
A cursor, as given in the Link header. If specified, the query only searches for events before this cursor.
         
.PARAMETER order
The order of audit log events. To list newest events first, specify desc. To list oldest events first, specify asc.
The default is desc.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30


.LINK
https://docs.github.com/en/rest/reference/orgs
#>
Function Get-TheAuditLogForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$phrase,
		[Parameter(Mandatory=$FALSE)][string]$include,
		[Parameter(Mandatory=$FALSE)][string]$after,
		[Parameter(Mandatory=$FALSE)][string]$before,
		[Parameter(Mandatory=$FALSE)][string]$order,
		[Parameter(Mandatory=$FALSE)][string]$per_page
    )
    $QueryStrings = @("phrase=$phrase","include=$include","after=$after","before=$before","order=$order","per_page=$per_page") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/audit-log?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/audit-log"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

