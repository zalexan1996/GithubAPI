
<#
.SYNOPSIS
Enables a workflow and sets the state of the workflow to active. You can replace workflow_id with the workflow file name. For example, you could use main.yaml.
You must authenticate using an access token with the repo scope to use this endpoint. GitHub Apps must have the actions:write permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER workflow_id
The ID of the workflow. You can also pass the workflow file name as a string.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Enable-AWorkflow
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$workflow_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/enable?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/workflows/$workflow_id/enable"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
