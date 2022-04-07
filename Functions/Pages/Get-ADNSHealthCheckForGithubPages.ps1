<#
.SYNOPSIS
Gets a health check of the DNS settings for the CNAME record configured for a repository's GitHub Pages.
The first request to this endpoint returns a 202 Accepted status and starts an asynchronous background task to get the results for the domain. After the background task completes, subsequent requests to this endpoint return a 200 OK status with the health check results in the response.
Users must have admin or owner permissions. GitHub Apps must have the pages:write and administration:write permission to use this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo



.LINK
https://docs.github.com/en/rest/reference/pages

.OUTPUTS
 {
  "domain": {
    "host": "example.com",
    "uri": "http://example.com/",
    "nameservers": "default",
    "dns_resolves": true,
    "is_proxied": false,
    "is_cloudflare_ip": false,
    "is_fastly_ip": false,
    "is_old_ip_address": false,
    "is_a_record": true,
    "has_cname_record": false,
    "has_mx_records_present": false,
    "is_valid_domain": true,
    "is_apex_domain": true,
    "should_be_a_record": true,
    "is_cname_to_github_user_domain": false,
    "is_cname_to_pages_dot_github_dot_com": false,
    "is_cname_to_fastly": false,
    "is_pointed_to_github_pages_ip": true,
    "is_non_github_pages_ip_present": false,
    "is_pages_domain": false,
    "is_served_by_pages": true,
    "is_valid": true,
    "reason": null,
    "responds_to_https": true,
    "enforces_https": true,
    "https_error": null,
    "is_https_eligible": true,
    "caa_error": null
  },
  "alt_domain": {
    "host": "www.example.com",
    "uri": "http://www.example.com/",
    "nameservers": "default",
    "dns_resolves": true,
    "is_proxied": false,
    "is_cloudflare_ip": false,
    "is_fastly_ip": false,
    "is_old_ip_address": false,
    "is_a_record": true,
    "has_cname_record": false,
    "has_mx_records_present": false,
    "is_valid_domain": true,
    "is_apex_domain": true,
    "should_be_a_record": true,
    "is_cname_to_github_user_domain": false,
    "is_cname_to_pages_dot_github_dot_com": false,
    "is_cname_to_fastly": false,
    "is_pointed_to_github_pages_ip": true,
    "is_non_github_pages_ip_present": false,
    "is_pages_domain": false,
    "is_served_by_pages": true,
    "is_valid": true,
    "reason": null,
    "responds_to_https": true,
    "enforces_https": true,
    "https_error": null,
    "is_https_eligible": true,
    "caa_error": null
  }
}
#>
Function Get-ADNSHealthCheckForGithubPages
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
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pages/health?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/pages/health"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
