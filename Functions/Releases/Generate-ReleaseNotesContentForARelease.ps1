
<#
.SYNOPSIS
Generate a name and body describing a release. The body content will be markdown formatted and contain information like the changes since last release and users who contributed. The generated release notes are not saved anywhere. They are intended to be generated and used when creating a new release.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER tag_name
Required. The tag name for the release. This can be an existing tag or a new one.
         
.PARAMETER target_commitish
Specifies the commitish value that will be the target for the release's tag. Required if the supplied tag_name does not reference an existing tag. Ignored if the tag_name already exists.
         
.PARAMETER previous_tag_name
The name of the previous tag to use as the starting point for the release notes. Use to manually specify the range for the set of changes considered as part this release.
         
.PARAMETER configuration_file_path
Specifies a path to a file in the repository containing configuration settings used for generating the release notes. If unspecified, the configuration file located in the repository at '.github/release.yml' or '.github/release.yaml' will be used. If that is not present, the default configuration will be used.


.LINK
https://docs.github.com/en/rest/reference/releases
#>
Function Generate-ReleaseNotesContentForARelease
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$tag_name,
		[Parameter(Mandatory=$FALSE)][string]$target_commitish,
		[Parameter(Mandatory=$FALSE)][string]$previous_tag_name,
		[Parameter(Mandatory=$FALSE)][string]$configuration_file_path
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/releases/generate-notes?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/releases/generate-notes"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"tag_name" = "$tag_name"
	"target_commitish" = "$target_commitish"
	"previous_tag_name" = "$previous_tag_name"
	"configuration_file_path" = "$configuration_file_path"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
