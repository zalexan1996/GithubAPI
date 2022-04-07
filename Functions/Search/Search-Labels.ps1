<#
.SYNOPSIS
Find labels in a repository with names or descriptions that match search keywords. Returns up to 100 results per page.
When searching for labels, you can get text match metadata for the label name and description fields when you pass the text-match media type. For more details about how to receive highlighted search results, see Text match metadata.
For example, if you want to find labels in the linguist repository that match bug, defect, or enhancement. Your query might look like this:
q=bug+defect+enhancement&repository_id=64778136
The labels that best match the query appear first in the search results.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER repository_id
The id of the repository.
         
.PARAMETER q
The search keywords. This endpoint does not accept qualifiers in the query. To learn more about the format of the query, see Constructing a search query.
         
.PARAMETER sort
Sorts the results of your query by when the label was created or updated. Default: best match
         
.PARAMETER order
Determines whether the first search result returned is the highest number of matches (desc) or lowest number of matches (asc). This parameter is ignored unless you provide sort.
Default: desc
         
.PARAMETER per_page
Results per page (max 100)
Default: 30
         
.PARAMETER page
Page number of the results to fetch.
Default: 1


.LINK
https://docs.github.com/en/rest/reference/search

.OUTPUTS
 {
  "total_count": 2,
  "incomplete_results": false,
  "items": [
    {
      "id": 418327088,
      "node_id": "MDU6TGFiZWw0MTgzMjcwODg=",
      "url": "https://api.github.com/repos/octocat/linguist/labels/enhancement",
      "name": "enhancement",
      "color": "84b6eb",
      "default": true,
      "description": "New feature or request.",
      "score": 1
    },
    {
      "id": 418327086,
      "node_id": "MDU6TGFiZWw0MTgzMjcwODY=",
      "url": "https://api.github.com/repos/octocat/linguist/labels/bug",
      "name": "bug",
      "color": "ee0701",
      "default": true,
      "description": "Something isn't working.",
      "score": 1
    }
  ]
}
#>
Function Search-Labels
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$repository_id,
		[Parameter(Mandatory=$FALSE)][string]$q,
		[Parameter(Mandatory=$FALSE)][string]$sort,
		[Parameter(Mandatory=$FALSE)][string]$order,
		[Parameter(Mandatory=$FALSE)][int]$per_page,
		[Parameter(Mandatory=$FALSE)][int]$page
    )
    $Querys = @()
    $QueryStrings = @(
        "repository_id",
		"q",
		"sort",
		"order",
		"per_page",
		"page"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/search/labels?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/search/labels"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
