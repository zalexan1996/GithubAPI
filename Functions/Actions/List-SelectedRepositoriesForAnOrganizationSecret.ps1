
<#
.SYNOPSIS
Lists all repositories that have been selected when the visibility for repository access to a secret is set to selected. You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the secrets organization permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER secret_name
secret_name parameter
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER per_page
Results per page (max 100)
Default: 30


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function List-SelectedRepositoriesForAnOrganizationSecret
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$secret_name,
		[Parameter(Mandatory=$FALSE)][string]$page,
		[Parameter(Mandatory=$FALSE)][string]$per_page
    )
    $QueryStrings = @("page=$page","per_page=$per_page") | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/secrets/$secret_name/repositories?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/secrets/$secret_name/repositories"
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
