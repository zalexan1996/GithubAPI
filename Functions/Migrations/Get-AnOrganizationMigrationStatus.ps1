
<#
.SYNOPSIS
Fetches the status of a migration.
The state of a migration can be one of the following values:
pending, which means the migration hasn't started yet.
exporting, which means the migration is in progress.
exported, which means the migration finished successfully.
failed, which means the migration failed.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER migration_id
migration_id parameter
         
.PARAMETER exclude
Exclude attributes from the API response to improve performance


.LINK
https://docs.github.com/en/rest/reference/migrations
#>
Function Get-AnOrganizationMigrationStatus
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$migration_id,
		[Parameter(Mandatory=$FALSE)][string]$exclude
    )
    $QueryStrings = @("exclude=$exclude") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/migrations/$migration_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/migrations/$migration_id"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
