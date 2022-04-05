
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
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"vcs_username" = "$vcs_username"
	"vcs_password" = "$vcs_password"
	"vcs" = "$vcs"
	"tfvc_project" = "$tfvc_project"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

