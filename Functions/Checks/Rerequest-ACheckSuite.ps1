
<#
.SYNOPSIS
Triggers GitHub to rerequest an existing check suite, without pushing new code to a repository. This endpoint will trigger the check_suite webhook event with the action rerequested. When a check suite is rerequested, its status is reset to queued and the conclusion is cleared.
To rerequest a check suite, your GitHub App must have the checks:read permission on a private repository or pull access to a public repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER check_suite_id
check_suite_id parameter


.LINK
https://docs.github.com/en/rest/reference/checks
#>
Function Rerequest-ACheckSuite
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$check_suite_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-suites/$check_suite_id/rerequest?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/check-suites/$check_suite_id/rerequest"
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

