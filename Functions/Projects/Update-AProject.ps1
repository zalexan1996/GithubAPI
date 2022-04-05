
<#
.SYNOPSIS
Updates a project board's information. Returns a 404 Not Found status if projects are disabled. If you do not have sufficient privileges to perform this action, a 401 Unauthorized or 410 Gone status is returned.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER project_id

         
.PARAMETER name
Name of the project
         
.PARAMETER body
Body of the project
         
.PARAMETER state
State of the project; either 'open' or 'closed'
         
.PARAMETER organization_permission
The baseline permission that all organization members have on this project
         
.PARAMETER private
Whether or not this project can be seen by everyone.


.LINK
https://docs.github.com/en/rest/reference/projects
#>
Function Update-AProject
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$project_id,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$body,
		[Parameter(Mandatory=$FALSE)][string]$state,
		[Parameter(Mandatory=$FALSE)][string]$organization_permission,
		[Parameter(Mandatory=$FALSE)][string]$private
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/projects/$project_id?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/projects/$project_id"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"name" = "$name"
	"body" = "$body"
	"state" = "$state"
	"organization_permission" = "$organization_permission"
	"private" = "$private"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

