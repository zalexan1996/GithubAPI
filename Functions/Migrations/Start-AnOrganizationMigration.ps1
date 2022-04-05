
<#
.SYNOPSIS
Initiates the generation of a migration archive.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER repositories
Required. A list of arrays indicating which repositories should be migrated.
         
.PARAMETER lock_repositories
Indicates whether repositories should be locked (to prevent manipulation) while migrating data.
         
.PARAMETER exclude_attachments
Indicates whether attachments should be excluded from the migration (to reduce migration archive file size).
         
.PARAMETER exclude_releases
Indicates whether releases should be excluded from the migration (to reduce migration archive file size).
         
.PARAMETER exclude_owner_projects
Indicates whether projects owned by the organization or users should be excluded. from the migration.
         
.PARAMETER exclude



.LINK
https://docs.github.com/en/rest/reference/migrations
#>
Function Start-AnOrganizationMigration
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$repositories,
		[Parameter(Mandatory=$FALSE)][string]$lock_repositories,
		[Parameter(Mandatory=$FALSE)][string]$exclude_attachments,
		[Parameter(Mandatory=$FALSE)][string]$exclude_releases,
		[Parameter(Mandatory=$FALSE)][string]$exclude_owner_projects,
		[Parameter(Mandatory=$FALSE)][string]$exclude
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/migrations?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/migrations"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"repositories" = "$repositories"
	"lock_repositories" = "$lock_repositories"
	"exclude_attachments" = "$exclude_attachments"
	"exclude_releases" = "$exclude_releases"
	"exclude_owner_projects" = "$exclude_owner_projects"
	"exclude" = "$exclude"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

