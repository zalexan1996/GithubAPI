
<#
.SYNOPSIS
Adds a repository to an organization secret when the visibility for repository access is set to selected. The visibility is set when you Create or update an organization secret. You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the secrets organization permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER secret_name
secret_name parameter
         
.PARAMETER repository_id



.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Add-SelectedRepositoryToAnOrganizationSecret
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$secret_name,
		[Parameter(Mandatory=$FALSE)][string]$repository_id
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/secrets/$secret_name/repositories/$repository_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/secrets/$secret_name/repositories/$repository_id"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
