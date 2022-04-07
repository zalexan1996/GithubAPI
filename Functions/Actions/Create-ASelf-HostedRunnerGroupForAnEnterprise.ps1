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
  "selected_organizations_url": "https://api.github.com/enterprises/octo-corp/actions/runner-groups/2/organizations",
  "runners_url": "https://api.github.com/enterprises/octo-corp/actions/runner-groups/2/runners",
  "allows_public_repositories": false,
  "restricted_to_workflows": true,
  "selected_workflows": [
    "octo-org/octo-repo/.github/workflows/deploy.yaml@refs/heads/main"
  ],
  "workflow_restrictions_read_only": false
}
#>
Function Create-ASelf-HostedRunnerGroupForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$visibility,
		[Parameter(Mandatory=$FALSE)][int[]]$selected_organization_ids,
		[Parameter(Mandatory=$FALSE)][int[]]$runners,
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
		"selected_organization_ids",
		"runners",
		"allows_public_repositories",
		"restricted_to_workflows",
		"selected_workflows" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
