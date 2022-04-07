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

.OUTPUTS
 {
  "subscribed": true,
  "ignored": false,
  "reason": null,
  "created_at": "2012-10-06T21:34:12Z",
  "url": "https://api.github.com/repos/octocat/example/subscription",
  "repository_url": "https://api.github.com/repos/octocat/example"
}
#>
Function Set-ARepositorySubscription
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][bool]$subscribed,
		[Parameter(Mandatory=$FALSE)][bool]$ignored
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "subscribed",
		"ignored" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/subscription?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/subscription"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
