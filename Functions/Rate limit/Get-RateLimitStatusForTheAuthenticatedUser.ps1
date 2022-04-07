<#
.SYNOPSIS
Note: Accessing this endpoint does not count against your REST API rate limit.
Note: The rate object is deprecated. If you're writing new API client code or updating existing code, you should use the core object instead of the rate object. The core object contains the same information that is present in the rate object.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/rate-limit

.OUTPUTS
 {
  "resources": {
    "core": {
      "limit": 5000,
      "remaining": 4999,
      "reset": 1372700873,
      "used": 1
    },
    "search": {
      "limit": 30,
      "remaining": 18,
      "reset": 1372697452,
      "used": 12
    },
    "graphql": {
      "limit": 5000,
      "remaining": 4993,
      "reset": 1372700389,
      "used": 7
    },
    "integration_manifest": {
      "limit": 5000,
      "remaining": 4999,
      "reset": 1551806725,
      "used": 1
    },
    "code_scanning_upload": {
      "limit": 500,
      "remaining": 499,
      "reset": 1551806725,
      "used": 1
    }
  },
  "rate": {
    "limit": 5000,
    "remaining": 4999,
    "reset": 1372700873,
    "used": 1
  }
}
#>
Function Get-RateLimitStatusForTheAuthenticatedUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/rate_limit?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/rate_limit"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
