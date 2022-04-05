
<#
.SYNOPSIS
Shows which type of GitHub user can interact with your public repositories and when the restriction expires.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/interactions
#>
Function Get-InteractionRestrictionsForYourPublicRepositories
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/interaction-limits?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/interaction-limits"
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

