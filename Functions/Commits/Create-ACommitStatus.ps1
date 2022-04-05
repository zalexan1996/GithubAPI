
<#
.SYNOPSIS
Users with push access in a repository can create commit statuses for a given SHA.
Note: there is a limit of 1000 statuses per sha and context within a repository. Attempts to create more than 1000 statuses will result in a validation error.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER sha

         
.PARAMETER state
Required. The state of the status. Can be one of error, failure, pending, or success.
         
.PARAMETER target_url
The target URL to associate with this status. This URL will be linked from the GitHub UI to allow users to easily see the source of the status.
For example, if your continuous integration system is posting build status, you would want to provide the deep link for the build output for this specific SHA:
http://ci.example.com/user/repo/build/sha
         
.PARAMETER description
A short description of the status.
         
.PARAMETER context
A string label to differentiate this status from the status of other systems. This field is case-insensitive.
Default: default


.LINK
https://docs.github.com/en/rest/reference/commits
#>
Function Create-ACommitStatus
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$sha,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$target_url,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$context
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/statuses/$sha?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/statuses/$sha"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"state" = "$state"
	"target_url" = "$target_url"
	"description" = "$description"
	"context" = "$context"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

