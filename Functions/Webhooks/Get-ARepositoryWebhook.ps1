
<#
.SYNOPSIS
Returns a webhook configured in a repository. To get only the webhook config properties, see "Get a webhook configuration for a repository."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER hook_id



.LINK
https://docs.github.com/en/rest/reference/webhooks
#>
Function Get-ARepositoryWebhook
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$hook_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/hooks/$hook_id"
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
