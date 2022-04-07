<#
.SYNOPSIS
Gets a single secret scanning alert detected in an eligible repository. To use this endpoint, you must be an administrator for the repository or for the organization that owns the repository, and you must use a personal access token with the repo scope or security_events scope. For public repositories, you may instead use the public_repo scope.
GitHub Apps must have the secret_scanning_alerts read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER alert_number
The number that identifies an alert. You can find this at the end of the URL for a code scanning alert within GitHub, and in the number field in the response from the GET /repos/{owner}/{repo}/code-scanning/alerts operation.


.LINK
https://docs.github.com/en/rest/reference/secret-scanning

.OUTPUTS
 {
  "number": 42,
  "created_at": "2020-11-06T18:18:30Z",
  "url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/42",
  "html_url": "https://github.com/owner/private-repo/security/secret-scanning/42",
  "locations_url": "https://api.github.com/repos/owner/private-repo/secret-scanning/alerts/42/locations",
  "state": "open",
  "resolution": null,
  "resolved_at": null,
  "resolved_by": null,
  "secret_type": "mailchimp_api_key",
  "secret_type_display_name": "Mailchimp API Key",
  "secret": "XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX-us2"
}
#>
Function Get-ASecretScanningAlert
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$alert_number
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/secret-scanning/alerts/$alert_number?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/secret-scanning/alerts/$alert_number"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
