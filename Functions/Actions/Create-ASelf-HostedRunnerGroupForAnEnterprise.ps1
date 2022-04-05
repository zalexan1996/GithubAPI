
<#
.SYNOPSIS
Creates a new self-hosted runner group for an enterprise.
You must authenticate using an access token with the manage_runners:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER name
Required. Name of the runner group.
         
.PARAMETER visibility
Visibility of a runner group. You can select all organizations or select individual organization. Can be one of: all or selected
         
.PARAMETER selected_organization_ids
List of organization IDs that can access the runner group.
         
.PARAMETER runners
List of runner IDs to add to the runner group.
         
.PARAMETER allows_public_repositories
Whether the runner group can be used by public repositories.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Create-ASelf-HostedRunnerGroupForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$visibility,
		[Parameter(Mandatory=$FALSE)][string]$selected_organization_ids,
		[Parameter(Mandatory=$FALSE)][string]$runners,
		[Parameter(Mandatory=$FALSE)][string]$allows_public_repositories
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"name" = "$name"
	"visibility" = "$visibility"
	"selected_organization_ids" = "$selected_organization_ids"
	"runners" = "$runners"
	"allows_public_repositories" = "$allows_public_repositories"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

