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
         
.PARAMETER restricted_to_workflows
If true, the runner group will be restricted to running only the workflows specified in the selected_workflows array.
         
.PARAMETER selected_workflows
List of workflows the runner group should be allowed to run. This setting will be ignored unless restricted_to_workflows is set to true.


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
		[Parameter(Mandatory=$FALSE)][int[]]$selected_repository_ids,
		[Parameter(Mandatory=$FALSE)][int[]]$runners,
		[Parameter(Mandatory=$FALSE)][bool]$allows_public_repositories,
		[Parameter(Mandatory=$FALSE)][bool]$restricted_to_workflows,
		[Parameter(Mandatory=$FALSE)][string[]]$selected_workflows
    )
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
        "name",
		"visibility",
		"selected_repository_ids",
		"runners",
		"allows_public_repositories",
		"restricted_to_workflows",
		"selected_workflows" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
