
<#
.SYNOPSIS
Remove a custom label from a self-hosted runner configured in a repository. Returns the remaining labels from the runner.
This endpoint returns a 404 Not Found status if the custom label is not present on the runner.
You must authenticate using an access token with the repo scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER runner_id
Unique identifier of the self-hosted runner.
         
.PARAMETER name
The name of a self-hosted runner's custom label.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Remove-ACustomLabelFromASelf-HostedRunnerForARepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$runner_id,
		[Parameter(Mandatory=$FALSE)][string]$name
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runners/$runner_id/labels/$name?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/runners/$runner_id/labels/$name"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method DELETE -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
