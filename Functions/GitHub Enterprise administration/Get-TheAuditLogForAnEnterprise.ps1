<#
.SYNOPSIS
Gets the audit log for an enterprise. To use this endpoint, you must be an enterprise admin, and you must use an access token with the admin:enterprise scope.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
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
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30


.LINK
https://docs.github.com/en/rest/reference/enterprise-admin

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
Function Get-TheAuditLogForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$phrase,
		[Parameter(Mandatory=$FALSE)][string]$include,
		[Parameter(Mandatory=$FALSE)][string]$after,
		[Parameter(Mandatory=$FALSE)][string]$before,
		[Parameter(Mandatory=$FALSE)][string]$order,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][int]$per_page
    )
    $Querys = @()
    $QueryStrings = @(
        "phrase",
		"include",
		"after",
		"before",
		"order",
		"page",
		"per_page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/audit-log?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/audit-log"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
