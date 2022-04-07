<#
.SYNOPSIS
Gets a redirect URL to download an archive for a repository. This URL expires after 1 minute. Look for Location: in the response header to find the URL for the download. The :archive_format must be zip. Anyone with read access to the repository can use this endpoint. If the repository is private you must use an access token with the repo scope. GitHub Apps must have the actions:read permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER artifact_id
artifact_id parameter
         
.PARAMETER archive_format



.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS

#>
Function Download-AnArtifact
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$artifact_id,
		[Parameter(Mandatory=$FALSE)][string]$archive_format
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/artifacts/$artifact_id/$archive_format?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/actions/artifacts/$artifact_id/$archive_format"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
