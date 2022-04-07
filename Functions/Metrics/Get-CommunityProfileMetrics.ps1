<#
.SYNOPSIS
This endpoint will return all community profile metrics, including an overall health score, repository description, the presence of documentation, detected code of conduct, detected license, and the presence of ISSUE_TEMPLATE, PULL_REQUEST_TEMPLATE, README, and CONTRIBUTING files.
The health_percentage score is defined as a percentage of how many of these four documents are present: README, CONTRIBUTING, LICENSE, and CODE_OF_CONDUCT. For example, if all four documents are present, then the health_percentage is 100. If only one is present, then the health_percentage is 25.
content_reports_enabled is only returned for organization-owned repositories.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo



.LINK
https://docs.github.com/en/rest/reference/metrics

.OUTPUTS
 {
  "health_percentage": 100,
  "description": "My first repository on GitHub!",
  "documentation": null,
  "files": {
    "code_of_conduct": {
      "name": "Contributor Covenant",
      "key": "contributor_covenant",
      "url": "https://api.github.com/codes_of_conduct/contributor_covenant",
      "html_url": "https://github.com/octocat/Hello-World/blob/master/CODE_OF_CONDUCT.md"
    },
    "code_of_conduct_file": {
      "url": "https://api.github.com/repos/octocat/Hello-World/contents/CODE_OF_CONDUCT.md",
      "html_url": "https://github.com/octocat/Hello-World/blob/master/CODE_OF_CONDUCT.md"
    },
    "contributing": {
      "url": "https://api.github.com/repos/octocat/Hello-World/contents/CONTRIBUTING",
      "html_url": "https://github.com/octocat/Hello-World/blob/master/CONTRIBUTING"
    },
    "issue_template": {
      "url": "https://api.github.com/repos/octocat/Hello-World/contents/ISSUE_TEMPLATE",
      "html_url": "https://github.com/octocat/Hello-World/blob/master/ISSUE_TEMPLATE"
    },
    "pull_request_template": {
      "url": "https://api.github.com/repos/octocat/Hello-World/contents/PULL_REQUEST_TEMPLATE",
      "html_url": "https://github.com/octocat/Hello-World/blob/master/PULL_REQUEST_TEMPLATE"
    },
    "license": {
      "name": "MIT License",
      "key": "mit",
      "spdx_id": "MIT",
      "url": "https://api.github.com/licenses/mit",
      "html_url": "https://github.com/octocat/Hello-World/blob/master/LICENSE",
      "node_id": "MDc6TGljZW5zZW1pdA=="
    },
    "readme": {
      "url": "https://api.github.com/repos/octocat/Hello-World/contents/README.md",
      "html_url": "https://github.com/octocat/Hello-World/blob/master/README.md"
    }
  },
  "updated_at": "2017-02-28T19:09:29Z",
  "content_reports_enabled": true
}
#>
Function Get-CommunityProfileMetrics
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/community/profile?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/community/profile"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
