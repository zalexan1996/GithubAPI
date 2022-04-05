
<#
.SYNOPSIS
The self-hosted runner groups REST API is available with GitHub Enterprise Cloud and GitHub Enterprise Server. For more information, see "GitHub's products."
Creates a new self-hosted runner group for an organization.
You must authenticate using an access token with the admin:org scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER name
Required. Name of the runner group.
         
.PARAMETER visibility
Visibility of a runner group. You can select all repositories, select individual repositories, or limit access to private repositories. Can be one of: all, selected, or private.
Default: all
         
.PARAMETER selected_repository_ids
List of repository IDs that can access the runner group.
         
.PARAMETER runners
List of runner IDs to add to the runner group.
         
.PARAMETER allows_public_repositories
Whether the runner group can be used by public repositories.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Create-ASelf-HostedRunnerGroupForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$visibility,
		[Parameter(Mandatory=$FALSE)][string]$selected_repository_ids,
		[Parameter(Mandatory=$FALSE)][string]$runners,
		[Parameter(Mandatory=$FALSE)][string]$allows_public_repositories
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"name" = "$name"
	"visibility" = "$visibility"
	"selected_repository_ids" = "$selected_repository_ids"
	"runners" = "$runners"
	"allows_public_repositories" = "$allows_public_repositories"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

