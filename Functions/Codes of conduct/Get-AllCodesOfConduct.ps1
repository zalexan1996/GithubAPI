<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.


.LINK
https://docs.github.com/en/rest/reference/codes-of-conduct

.OUTPUTS
 [
  {
    "key": "citizen_code_of_conduct",
    "name": "Citizen Code of Conduct",
    "url": "https://api.github.com/codes_of_conduct/citizen_code_of_conduct",
    "html_url": "http://citizencodeofconduct.org/"
  },
  {
    "key": "contributor_covenant",
    "name": "Contributor Covenant",
    "url": "https://api.github.com/codes_of_conduct/contributor_covenant",
    "html_url": "https://www.contributor-covenant.org/version/2/0/code_of_conduct/"
  }
]
#>
Function Get-AllCodesOfConduct
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
        $FinalURL = "https://api.github.com/codes_of_conduct?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/codes_of_conduct"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
