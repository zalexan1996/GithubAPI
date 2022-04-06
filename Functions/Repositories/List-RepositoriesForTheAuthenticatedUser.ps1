<#
.SYNOPSIS
Lists repositories that the authenticated user has explicit permission (:read, :write, or :admin) to access.
The authenticated user has explicit permission to access repositories they own, repositories where they are a collaborator, and repositories that they can access through an organization membership.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER visibility
Can be one of all, public, or private. Note: For GitHub AE, can be one of all, internal, or private.
Default: all
         
.PARAMETER affiliation
Comma-separated list of values. Can include:
* owner: Repositories that are owned by the authenticated user.
* collaborator: Repositories that the user has been added to as a collaborator.
* organization_member: Repositories that the user has access to through being a member of an organization. This includes every repository on every team that the user is on.
Default: owner,collaborator,organization_member
         
.PARAMETER type
Can be one of all, owner, public, private, member. Note: For GitHub AE, can be one of all, owner, internal, private, member. Default: all
Will cause a 422 error if used in the same request as visibility or affiliation. Will cause a 422 error if used in the same request as visibility or affiliation.
Default: all
         
.PARAMETER sort
Can be one of created, updated, pushed, full_name.
Default: full_name
         
.PARAMETER direction
Can be one of asc or desc. Default: asc when using full_name, otherwise desc
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1
         
.PARAMETER since
Only show notifications updated after the given time. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.
         
.PARAMETER before
Only show notifications updated before the given time. This is a timestamp in ISO 8601 format: YYYY-MM-DDTHH:MM:SSZ.


.LINK
https://docs.github.com/en/rest/reference/repos
#>
Function List-RepositoriesForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$visibility,
		[Parameter(Mandatory=$FALSE)][string]$affiliation,
		[Parameter(Mandatory=$FALSE)][string]$type,
		[Parameter(Mandatory=$FALSE)][string]$sort,
		[Parameter(Mandatory=$FALSE)][string]$direction,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page,
		[Parameter(Mandatory=$FALSE)][string]$since,
		[Parameter(Mandatory=$FALSE)][string]$before
    )
    $QueryStrings = @(
        "visibility=$visibility",
		"affiliation=$affiliation",
		"type=$type",
		"sort=$sort",
		"direction=$direction",
		"per_page=$per_page",
		"page=$page",
		"since=$since",
		"before=$before"
    ) | ? { $PSBoundParameters.ContainsKey($_) }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/user/repos?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/user/repos"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
