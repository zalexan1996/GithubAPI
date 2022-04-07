<#
.SYNOPSIS
Returns meta information about GitHub, including a list of GitHub's IP addresses. For more information, see "About GitHub's IP addresses."
Note: The IP addresses shown in the documentation's response are only example values. You must always query the API directly to get the latest list of IP addresses.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/meta

.OUTPUTS
 {
  "verifiable_password_authentication": true,
  "ssh_key_fingerprints": {
    "SHA256_RSA": "nThbg6kXUpJWGl7E1IGOCspRomTxdCARLviKw6E5SY8",
    "SHA256_DSA": "br9IjFspm1vxR3iA35FWE+4VTyz1hYVLIE2t1/CeyWQ",
    "SHA256_ECDSA": "p2QAMXNIC1TJYWeIOttrVc98/R1BUFWu3/LiyKgUfQM",
    "SHA256_ED25519": "+DiY3wvvV6TuJJhbpZisF/zLDA0zPMSvHdkr4UvCOqU"
  },
  "ssh_keys": [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOMqqnkVzrm0SdG6UOoqKLsabgH5C9okWi0dh2l9GKJl",
    "ecdsa-sha2-nistp256 AAAAE2VjZHNhLXNoYTItbmlzdHAyNTYAAAAIbmlzdHAyNTYAAABBBEmKSENjQEezOmxkZMy7opKgwFB9nkt5YRrYMjNuG5N87uRgg6CLrbo5wAdT/y6v0mKV0U2w0WZ2YB/++Tpockg=",
    "ssh-rsa AAAAB3NzaC1yc2EAAAABIwAAAQEAq2A7hRGmdnm9tUDbO9IDSwBK6TbQa+PXYPCPy6rbTrTtw7PHkccKrpp0yVhp5HdEIcKr6pLlVDBfOLX9QUsyCOV0wzfjIJNlGEYsdlLJizHhbn2mUjvSAHQqZETYP81eFzLQNnPHt4EVVUh7VfDESU84KezmD5QlWpXLmvU31/yMf+Se8xhHTvKSCZIFImWwoG6mbUoWf9nzpIoaSjB+weqqUUmpaaasXVal72J+UX2B+2RPW3RcT0eOzQgqlJL3RKrTJvdsjE3JEAvGq3lGHSZXy28G3skua2SmVi/w4yCE6gbODqnTWlg7+wC604ydGXA8VJiS5ap43JXiUFFAaQ=="
  ],
  "hooks": [
    "192.30.252.0/22"
  ],
  "web": [
    "192.30.252.0/22",
    "185.199.108.0/22"
  ],
  "api": [
    "192.30.252.0/22",
    "185.199.108.0/22"
  ],
  "git": [
    "192.30.252.0/22"
  ],
  "packages": [
    "192.30.252.0/22"
  ],
  "pages": [
    "192.30.252.153/32",
    "192.30.252.154/32"
  ],
  "importer": [
    "54.158.161.132",
    "54.226.70.38"
  ],
  "actions": [
    "13.64.0.0/16",
    "13.65.0.0/16"
  ],
  "dependabot": [
    "54.158.161.132"
  ]
}
#>
Function Get-GithubMetaInformation
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
        $FinalURL = "https://api.github.com/meta?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/meta"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
