<#
.SYNOPSIS
Sets the default workflow permissions granted to the GITHUB_TOKEN when running workflows in an organization, and sets if GitHub Actions can submit approving pull request reviews.
You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the administration organization permission to use this API.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER default_workflow_permissions
The default workflow permissions granted to the GITHUB_TOKEN when running workflows in an organization.
         
.PARAMETER can_approve_pull_request_reviews
Whether GitHub Actions can submit approving pull request reviews.


.LINK
https://docs.github.com/en/rest/reference/actions

.OUTPUTS

#>
Function Set-DefaultWorkflowPermissions
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$default_workflow_permissions,
		[Parameter(Mandatory=$FALSE)][bool]$can_approve_pull_request_reviews
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "default_workflow_permissions",
		"can_approve_pull_request_reviews" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions/workflow?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions/workflow"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
