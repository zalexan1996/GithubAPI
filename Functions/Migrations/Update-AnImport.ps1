<#
.SYNOPSIS
An import can be updated with credentials or a project choice by passing in the appropriate parameters in this API request. If no parameters are provided, the import will be restarted.
Some servers (e.g. TFS servers) can have several projects at a single URL. In those cases the import progress will have the status detection_found_multiple and the Import Progress response will include a project_choices array. You can select the project to import by providing one of the objects in the project_choices array in the update request.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER vcs_username
The username to provide to the originating repository.
         
.PARAMETER vcs_password
The password to provide to the originating repository.
         
.PARAMETER vcs
The type of version control system you are migrating from.
         
.PARAMETER tfvc_project
For a tfvc import, the name of the project that is being imported.


.LINK
https://docs.github.com/en/rest/reference/migrations

.OUTPUTS
 {
  "vcs": "subversion",
  "use_lfs": true,
  "vcs_url": "http://svn.mycompany.com/svn/myproject",
  "status": "detecting",
  "url": "https://api.github.com/repos/octocat/socm/import",
  "html_url": "https://import.github.com/octocat/socm/import",
  "authors_url": "https://api.github.com/repos/octocat/socm/import/authors",
  "repository_url": "https://api.github.com/repos/octocat/socm"
}  {
  "vcs": "tfvc",
  "use_lfs": true,
  "vcs_url": "http://tfs.mycompany.com/tfs/myproject",
  "tfvc_project": "project1",
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
}  {
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
Function Update-AnImport
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$vcs_username,
		[Parameter(Mandatory=$FALSE)][string]$vcs_password,
		[Parameter(Mandatory=$FALSE)][string]$vcs,
		[Parameter(Mandatory=$FALSE)][string]$tfvc_project
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "vcs_username",
		"vcs_password",
		"vcs",
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
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
