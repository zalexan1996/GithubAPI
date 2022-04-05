
<#
.SYNOPSIS
Sets the level of access that workflows outside of the repository have to actions and reusable workflows in the repository. This endpoint only applies to internal repositories. For more information, see "Managing GitHub Actions settings for a repository."
You must authenticate using an access token with the repo scope to use this endpoint. GitHub Apps must have the repository administration permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER access_level
Required. Defines the level of access that workflows outside of the repository have to actions and reusable workflows within the repository. none means access is only possible from workflows in this repository. Can be one of none, organization, enterprise.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Set-TheLevelOfAccessForWorkflowsOutsideOfTheRepository
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$access_level
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/permissions/access?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/permissions/access"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"access_level" = "$access_level"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

