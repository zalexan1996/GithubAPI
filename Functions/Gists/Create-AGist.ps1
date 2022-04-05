
<#
.SYNOPSIS
Allows you to add a new gist with one or more files.
Note: Don't name your files "gistfile" with a numerical suffix. This is the format of the automatic naming scheme that Gist uses internally.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER description
Description of the gist
         
.PARAMETER files
Required. Names and content for the files that make up the gist
         
.PARAMETER public
Flag indicating whether the gist is public


.LINK
https://docs.github.com/en/rest/reference/gists
#>
Function Create-AGist
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$files,
		[Parameter(Mandatory=$FALSE)][string]$public
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/gists?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/gists"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"description" = "$description"
	"files" = "$files"
	"public" = "$public"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

