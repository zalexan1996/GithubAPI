
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
		[Parameter(Mandatory=$FALSE)][string]$page,
		[Parameter(Mandatory=$FALSE)][string]$per_page
    )
    $QueryStrings = @("phrase=$phrase","include=$include","after=$after","before=$before","order=$order","page=$page","per_page=$per_page") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/audit-log?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/audit-log"
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

