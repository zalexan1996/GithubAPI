
<#
.SYNOPSIS
You can use this endpoint to trigger a webhook event called repository_dispatch when you want activity that happens outside of GitHub to trigger a GitHub Actions workflow or GitHub App webhook. You must configure your GitHub Actions workflow or GitHub App to run when the repository_dispatch event occurs. For an example repository_dispatch webhook payload, see "RepositoryDispatchEvent."
The client_payload parameter is available for any extra information that your workflow might need. This parameter is a JSON payload that will be passed on when the webhook event is dispatched. For example, the client_payload can include a message that a user would like to send using a GitHub Actions workflow. Or the client_payload can be used as a test to debug your workflow.
This endpoint requires write access to the repository by providing either:
Personal access tokens with repo scope. For more information, see "Creating a personal access token for the command line" in the GitHub Help documentation.
GitHub Apps with both metadata:read and contents:read&write permissions.
This input example shows how you can use the client_payload as a test to debug your workflow.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER event_type
Required. A custom webhook event name.
         
.PARAMETER client_payload
JSON payload with extra information about the webhook event that your action or worklow may use.


.LINK
https://docs.github.com/en/rest/reference/repos
#>
Function Create-ARepositoryDispatchEvent
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$event_type,
		[Parameter(Mandatory=$FALSE)][string]$client_payload
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/dispatches?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/dispatches"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"event_type" = "$event_type"
	"client_payload" = "$client_payload"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

