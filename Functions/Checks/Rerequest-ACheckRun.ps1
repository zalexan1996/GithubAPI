
<#
.SYNOPSIS
Triggers GitHub to rerequest an existing check run, without pushing new code to a repository. This endpoint will trigger the check_run webhook event with the action rerequested. When a check run is rerequested, its status is reset to queued and the conclusion is cleared.
To rerequest a check run, your GitHub App must have the checks:read permission on a private repository or pull access to a public repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER check_run_id
check_run_id parameter


.LINK
https://docs.github.com/en/rest/reference/checks
#>
Function Rerequest-ACheckRun
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$check_run_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-runs/$check_run_id/rerequest?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-runs/$check_run_id/rerequest"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

