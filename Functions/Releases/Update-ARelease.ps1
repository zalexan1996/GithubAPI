<#
.SYNOPSIS
Users with push access to the repository can edit a release.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER release_id
release_id parameter
         
.PARAMETER tag_name
The name of the tag.
         
.PARAMETER target_commitish
Specifies the commitish value that determines where the Git tag is created from. Can be any branch or commit SHA. Unused if the Git tag already exists. Default: the repository's default branch (usually master).
         
.PARAMETER name
The name of the release.
         
.PARAMETER body
Text describing the contents of the tag.
         
.PARAMETER draft
true makes the release a draft, and false publishes the release.
         
.PARAMETER prerelease
true to identify the release as a prerelease, false to identify the release as a full release.
         
.PARAMETER discussion_category_name
If specified, a discussion of the specified category is created and linked to the release. The value must be a category that already exists in the repository. If there is already a discussion linked to the release, this parameter is ignored. For more information, see "Managing categories for discussions in your repository."


.LINK
https://docs.github.com/en/rest/reference/releases
#>
Function Update-ARelease
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$release_id,
		[Parameter(Mandatory=$FALSE)][string]$tag_name,
		[Parameter(Mandatory=$FALSE)][string]$target_commitish,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$body,
		[Parameter(Mandatory=$FALSE)][bool]$draft,
		[Parameter(Mandatory=$FALSE)][bool]$prerelease,
		[Parameter(Mandatory=$FALSE)][string]$discussion_category_name
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "tag_name",
		"target_commitish",
		"name",
		"body",
		"draft",
		"prerelease",
		"discussion_category_name" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/releases/$release_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/releases/$release_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
