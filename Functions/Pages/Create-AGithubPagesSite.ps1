<#
.SYNOPSIS
Configures a GitHub Pages site. For more information, see "About GitHub Pages."

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER source
Required. The source branch and directory used to publish your Pages site.


.LINK
https://docs.github.com/en/rest/reference/pages

.OUTPUTS
 {
  "url": "https://api.github.com/repos/github/developer.github.com/pages",
  "status": "built",
  "cname": "developer.github.com",
  "custom_404": false,
  "html_url": "https://developer.github.com",
  "source": {
    "branch": "master",
    "path": "/"
  },
  "public": true,
  "https_certificate": {
    "state": "approved",
    "description": "Certificate is approved",
    "domains": [
      "developer.github.com"
    ],
    "expires_at": "2021-05-22"
  },
  "https_enforced": true
}
#>
Function Create-AGithubPagesSite
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][object]$source
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "source" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pages?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pages"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
