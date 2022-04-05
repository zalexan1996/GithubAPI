
<#
.SYNOPSIS
Initiates the generation of a user migration archive.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER lock_repositories
Lock the repositories being migrated at the start of the migration
         
.PARAMETER exclude_attachments
Do not include attachments in the migration
         
.PARAMETER exclude_releases
Do not include releases in the migration
         
.PARAMETER exclude_owner_projects
Indicates whether projects owned by the organization or users should be excluded.
         
.PARAMETER exclude
Exclude attributes from the API response to improve performance
         
.PARAMETER repositories
Required.


.LINK
https://docs.github.com/en/rest/reference/migrations
#>
Function Start-AUserMigration
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$lock_repositories,
		[Parameter(Mandatory=$FALSE)][string]$exclude_attachments,
		[Parameter(Mandatory=$FALSE)][string]$exclude_releases,
		[Parameter(Mandatory=$FALSE)][string]$exclude_owner_projects,
		[Parameter(Mandatory=$FALSE)][string]$exclude,
		[Parameter(Mandatory=$FALSE)][string]$repositories
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/migrations?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/migrations"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"lock_repositories" = "$lock_repositories"
	"exclude_attachments" = "$exclude_attachments"
	"exclude_releases" = "$exclude_releases"
	"exclude_owner_projects" = "$exclude_owner_projects"
	"exclude" = "$exclude"
	"repositories" = "$repositories"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

