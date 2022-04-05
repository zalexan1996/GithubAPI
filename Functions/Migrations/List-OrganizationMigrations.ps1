
<#
.SYNOPSIS
Lists the most recent migrations.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER exclude
Exclude attributes from the API response to improve performance


.LINK
https://docs.github.com/en/rest/reference/migrations
#>
Function List-OrganizationMigrations
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$per_page,
		[Parameter(Mandatory=$FALSE)][string]$page,
		[Parameter(Mandatory=$FALSE)][string]$exclude
    )
    $QueryStrings = @("per_page=$per_page","page=$page","exclude=$exclude") | ? { $PSBoundParameters.ContainsKey($_) }

    
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
        
    }

    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
