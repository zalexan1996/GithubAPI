
<#
.SYNOPSIS
If you would like to watch a repository, set subscribed to true. If you would like to ignore notifications made within a repository, set ignored to true. If you would like to stop watching a repository, delete the repository's subscription completely.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER subscribed
Determines if notifications should be received from this repository.
         
.PARAMETER ignored
Determines if all notifications should be blocked from this repository.


.LINK
https://docs.github.com/en/rest/reference/activity
#>
Function Set-ARepositorySubscription
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$subscribed,
		[Parameter(Mandatory=$FALSE)][string]$ignored
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/subscription?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/subscription"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"subscribed" = "$subscribed"
	"ignored" = "$ignored"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

