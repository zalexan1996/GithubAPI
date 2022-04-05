
<#
.SYNOPSIS
Users with push access to the repository can create a release.
This endpoint triggers notifications. Creating content too quickly using this endpoint may result in secondary rate limiting. See "Secondary rate limits" and "Dealing with secondary rate limits" for details.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER tag_name
Required. The name of the tag.
         
.PARAMETER target_commitish
Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch (usually master).
         
.PARAMETER name
The name of the release.
         
.PARAMETER body
Text describing the contents of the tag.
         
.PARAMETER draft
true to create a draft (unpublished) release, false to create a published one.
         
.PARAMETER prerelease
true to identify the release as a prerelease. false to identify the release as a full release.
         
.PARAMETER discussion_category_name
If specified, a discussion of the specified category is created and linked to the release. The value must be a category that already exists in the repository. For more information, see "Managing categories for discussions in your repository."
         
.PARAMETER generate_release_notes
Whether to automatically generate the name and body for this release. If name is specified, the specified name will be used; otherwise, a name will be automatically generated. If body is specified, the body will be pre-pended to the automatically generated notes.


.LINK
https://docs.github.com/en/rest/reference/releases
#>
Function Create-ARelease
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$tag_name,
		[Parameter(Mandatory=$FALSE)][string]$target_commitish,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$body,
		[Parameter(Mandatory=$FALSE)][string]$draft,
		[Parameter(Mandatory=$FALSE)][string]$prerelease,
		[Parameter(Mandatory=$FALSE)][string]$discussion_category_name,
		[Parameter(Mandatory=$FALSE)][string]$generate_release_notes
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/releases?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/releases"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"tag_name" = "$tag_name"
	"target_commitish" = "$target_commitish"
	"name" = "$name"
	"body" = "$body"
	"draft" = "$draft"
	"prerelease" = "$prerelease"
	"discussion_category_name" = "$discussion_category_name"
	"generate_release_notes" = "$generate_release_notes"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

