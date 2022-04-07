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

.OUTPUTS
 [
  {
    "@timestamp": 1606929874512,
    "action": "team.add_member",
    "actor": "octocat",
    "created_at": 1606929874512,
    "_document_id": "xJJFlFOhQ6b-5vaAFy9Rjw",
    "org": "octo-corp",
    "team": "octo-corp/example-team",
    "user": "monalisa"
  },
  {
    "@timestamp": 1606507117008,
    "action": "org.create",
    "actor": "octocat",
    "created_at": 1606507117008,
    "_document_id": "Vqvg6kZ4MYqwWRKFDzlMoQ",
    "org": "octocat-test-org"
  },
  {
    "@timestamp": 1605719148837,
    "action": "repo.destroy",
    "actor": "monalisa",
    "created_at": 1605719148837,
    "_document_id": "LwW2vpJZCDS-WUmo9Z-ifw",
    "org": "mona-org",
    "repo": "mona-org/mona-test-repo",
    "visibility": "private"
  }
]
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
		[Parameter(Mandatory=$FALSE)][int]$per_page
    )
    $Querys = @()
    $QueryStrings = @(
        "phrase",
		"include",
		"after",
		"before",
		"order",
		"per_page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/audit-log?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/audit-log"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
