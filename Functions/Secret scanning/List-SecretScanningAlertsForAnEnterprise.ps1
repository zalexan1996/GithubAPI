<#
.SYNOPSIS
Lists secret scanning alerts for eligible repositories in an enterprise, from newest to oldest. To use this endpoint, you must be a member of the enterprise, and you must use an access token with the repo scope or security_events scope. Alerts are only returned for organizations in the enterprise for which you are an organization owner or a security manager.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER state
Set to open or resolved to only list secret scanning alerts in a specific state.
         
.PARAMETER secret_type
A comma-separated list of secret types to return. By default all secret types are returned. See "Secret scanning patterns" for a complete list of secret types (API slug).
         
.PARAMETER resolution
A comma-separated list of resolutions. Only secret scanning alerts with one of these resolutions are listed. Valid resolutions are false_positive, wont_fix, revoked, pattern_edited, pattern_deleted or used_in_tests.
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER before
A cursor, as given in the Link header. If specified, the query only searches for events before this cursor.
         
.PARAMETER after
A cursor, as given in the Link header. If specified, the query only searches for events after this cursor.


.LINK
https://docs.github.com/en/rest/reference/secret-scanning
#>
Function List-SecretScanningAlertsForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$secret_type,
		[Parameter(Mandatory=$FALSE)][string]$resolution,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$before,
		[Parameter(Mandatory=$FALSE)][string]$after
    )
    $QueryStrings = @(
        "state=$state",
		"secret_type=$secret_type",
		"resolution=$resolution",
		"per_page=$per_page",
		"before=$before",
		"after=$after"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/secret-scanning/alerts?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/secret-scanning/alerts"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
