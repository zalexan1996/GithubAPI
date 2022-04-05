
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
#>
Function Set-DefaultWorkflowPermissions
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$default_workflow_permissions,
		[Parameter(Mandatory=$FALSE)][string]$can_approve_pull_request_reviews
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions/workflow?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/actions/permissions/workflow"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"default_workflow_permissions" = "$default_workflow_permissions"
	"can_approve_pull_request_reviews" = "$can_approve_pull_request_reviews"
    }

    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

