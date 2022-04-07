<#
.SYNOPSIS
Provides hovercard information when authenticated through basic auth or OAuth with the repo scope. You can find out more about someone in relation to their pull requests, issues, repositories, and organizations.
The subject_type and subject_id parameters provide context for the person's hovercard, which returns more information than without the parameters. For example, if you wanted to find out more about octocat who owns the Spoon-Knife repository via cURL, it would look like this:
curl -u username:token
  https://api.github.com/users/octocat/hovercard?subject_type=repository&subject_id=1300192

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER username

         
.PARAMETER subject_type
Identifies which additional information you'd like to receive about the person's hovercard. Can be organization, repository, issue, pull_request. Required when using subject_id.
         
.PARAMETER subject_id
Uses the ID for the subject_type you specified. Required when using subject_type.


.LINK
https://docs.github.com/en/rest/reference/users

.OUTPUTS
 {
  "contexts": [
    {
      "message": "Owns this repository",
      "octicon": "repo"
    }
  ]
}
#>
Function Get-ContextualInformationForAUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$username,
		[Parameter(Mandatory=$FALSE)][string]$subject_type,
		[Parameter(Mandatory=$FALSE)][string]$subject_id
    )
    $Querys = @()
    $QueryStrings = @(
        "subject_type",
		"subject_id"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/users/$username/hovercard?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/users/$username/hovercard"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
