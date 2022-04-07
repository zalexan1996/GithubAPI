<#
.SYNOPSIS
The self-hosted runner groups REST API is available with GitHub Enterprise Cloud. For more information, see "GitHub's products."
Updates the name and visibility of a self-hosted runner group in an organization.
You must authenticate using an access token with the admin:org scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER runner_group_id
Unique identifier of the self-hosted runner group.
         
.PARAMETER name
Required. Name of the runner group.
         
.PARAMETER visibility
Visibility of a runner group. You can select all repositories, select individual repositories, or all private repositories. Can be one of: all, selected, or private.
         
.PARAMETER allows_public_repositories
Whether the runner group can be used by public repositories.
         
.PARAMETER restricted_to_workflows
If true, the runner group will be restricted to running only the workflows specified in the selected_workflows array.
         
.PARAMETER selected_workflows
List of workflows the runner group should be allowed to run. This setting will be ignored unless restricted_to_workflows is set to true.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS
 {
  "id": 2,
  "name": "octo-runner-group",
  "visibility": "selected",
  "default": false,
  "selected_repositories_url": "https://api.github.com/orgs/octo-org/actions/runner-groups/2/repositories",
  "runners_url": "https://api.github.com/orgs/octo-org/actions/runner_groups/2/runners",
  "inherited": false,
  "allows_public_repositories": true,
  "restricted_to_workflows": true,
  "selected_workflows": [
    "octo-org/octo-repo/.github/workflows/deploy.yaml@refs/heads/main"
  ],
  "workflow_restrictions_read_only": false
}
#>
Function Update-ASelf-HostedRunnerGroupForAnOrganization
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][int]$runner_group_id,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$visibility,
		[Parameter(Mandatory=$FALSE)][bool]$allows_public_repositories,
		[Parameter(Mandatory=$FALSE)][bool]$restricted_to_workflows,
		[Parameter(Mandatory=$FALSE)][string[]]$selected_workflows
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "name",
		"visibility",
		"allows_public_repositories",
		"restricted_to_workflows",
		"selected_workflows" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups/$runner_group_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/runner-groups/$runner_group_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
