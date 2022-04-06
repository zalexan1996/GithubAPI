<#
.SYNOPSIS
Updates the name and visibility of a self-hosted runner group in an enterprise.
You must authenticate using an access token with the manage_runners:enterprise scope to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER enterprise
The slug version of the enterprise name. You can also substitute this value with the enterprise id.
         
.PARAMETER runner_group_id
Unique identifier of the self-hosted runner group.
         
.PARAMETER name
Name of the runner group.
         
.PARAMETER visibility
Visibility of a runner group. You can select all organizations or select individual organizations. Can be one of: all or selected
Default: all
         
.PARAMETER allows_public_repositories
Whether the runner group can be used by public repositories.
         
.PARAMETER restricted_to_workflows
If true, the runner group will be restricted to running only the workflows specified in the selected_workflows array.
         
.PARAMETER selected_workflows
List of workflows the runner group should be allowed to run. This setting will be ignored unless restricted_to_workflows is set to true.


.LINK
https://docs.github.com/en/rest/reference/actions
#>
Function Update-ASelf-HostedRunnerGroupForAnEnterprise
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$enterprise,
		[Parameter(Mandatory=$FALSE)][int]$runner_group_id,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$visibility,
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
		"allows_public_repositories",
		"restricted_to_workflows",
		"selected_workflows" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups/$runner_group_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/enterprises/$enterprise/actions/runner-groups/$runner_group_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
