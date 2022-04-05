
<#
.SYNOPSIS
Creates a new repository using a repository template. Use the template_owner and template_repo route parameters to specify the repository to use as the template. The authenticated user must own or be a member of an organization that owns the repository. To check if a repository is available to use as a template, get the repository's information using the Get a repository endpoint and check that the is_template key is true.
OAuth scope requirements
When using OAuth, authorizations must include:
public_repo scope or repo scope to create a public repository. Note: For GitHub AE, use repo scope to create an internal repository.
repo scope to create a private repository

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER template_owner

         
.PARAMETER template_repo

         
.PARAMETER owner
The organization or person who will own the new repository. To create a new repository in an organization, the authenticated user must be a member of the specified organization.
         
.PARAMETER name
Required. The name of the new repository.
         
.PARAMETER description
A short description of the new repository.
         
.PARAMETER include_all_branches
Set to true to include the directory structure and files from all branches in the template repository, and not just the default branch. Default: false.
         
.PARAMETER private
Either true to create a new private repository or false to create a new public one.


.LINK
https://docs.github.com/en/rest/reference/repos
#>
Function Create-ARepositoryUsingATemplate
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$template_owner,
		[Parameter(Mandatory=$FALSE)][string]$template_repo,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$description,
		[Parameter(Mandatory=$FALSE)][string]$include_all_branches,
		[Parameter(Mandatory=$FALSE)][string]$private
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$template_owner/$template_repo/generate?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$template_owner/$template_repo/generate"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"owner" = "$owner"
	"name" = "$name"
	"description" = "$description"
	"include_all_branches" = "$include_all_branches"
	"private" = "$private"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

