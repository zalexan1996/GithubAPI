<#
.SYNOPSIS
Start a source import to a GitHub repository using GitHub Importer.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER vcs_url
Required. The URL of the originating repository.
         
.PARAMETER vcs
The originating VCS type. Can be one of subversion, git, mercurial, or tfvc. Please be aware that without this parameter, the import job will take additional time to detect the VCS type before beginning the import. This detection step will be reflected in the response.
         
.PARAMETER vcs_username
If authentication is required, the username to provide to vcs_url.
         
.PARAMETER vcs_password
If authentication is required, the password to provide to vcs_url.
         
.PARAMETER tfvc_project
For a tfvc import, the name of the project that is being imported.


.LINK
https://docs.github.com/en/rest/reference/migrations

.OUTPUTS
 {
  "vcs": "subversion",
  "use_lfs": true,
  "vcs_url": "http://svn.mycompany.com/svn/myproject",
  "status": "importing",
  "status_text": "Importing...",
  "has_large_files": false,
  "large_files_size": 0,
  "large_files_count": 0,
  "authors_count": 0,
  "commit_count": 1042,
  "url": "https://api.github.com/repos/octocat/socm/import",
  "html_url": "https://import.github.com/octocat/socm/import",
  "authors_url": "https://api.github.com/repos/octocat/socm/import/authors",
  "repository_url": "https://api.github.com/repos/octocat/socm"
}
#>
Function Start-AnImport
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$vcs_url,
		[Parameter(Mandatory=$FALSE)][string]$vcs,
		[Parameter(Mandatory=$FALSE)][string]$vcs_username,
		[Parameter(Mandatory=$FALSE)][string]$vcs_password,
		[Parameter(Mandatory=$FALSE)][string]$tfvc_project
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "vcs_url",
		"vcs",
		"vcs_username",
		"vcs_password",
		"tfvc_project" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
