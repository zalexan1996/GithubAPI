<#
.SYNOPSIS
Each type of source control system represents authors in a different way. For example, a Git commit author has a display name and an email address, but a Subversion commit author just has a username. The GitHub Importer will make the author information valid, but the author might not be correct. For example, it will change the bare Subversion username hubot into something like hubot <hubot@12341234-abab-fefe-8787-fedcba987654>.
This endpoint and the Map a commit author endpoint allow you to provide correct Git author information.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER since
A user ID. Only return users with an ID greater than this ID.


.LINK
https://docs.github.com/en/rest/reference/migrations

.OUTPUTS
 [
  {
    "id": 2268557,
    "remote_id": "nobody@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
    "remote_name": "nobody",
    "email": "hubot@github.com",
    "name": "Hubot",
    "url": "https://api.github.com/repos/octocat/socm/import/authors/2268557",
    "import_url": "https://api.github.com/repos/octocat/socm/import"
  },
  {
    "id": 2268558,
    "remote_id": "svner@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
    "remote_name": "svner",
    "email": "svner@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
    "name": "svner",
    "url": "https://api.github.com/repos/octocat/socm/import/authors/2268558",
    "import_url": "https://api.github.com/repos/octocat/socm/import"
  },
  {
    "id": 2268559,
    "remote_id": "svner@example.com@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
    "remote_name": "svner@example.com",
    "email": "svner@example.com@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
    "name": "svner@example.com",
    "url": "https://api.github.com/repos/octocat/socm/import/authors/2268559",
    "import_url": "https://api.github.com/repos/octocat/socm/import"
  }
]
#>
Function Get-CommitAuthors
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$since
    )
    $Querys = @()
    $QueryStrings = @(
        "since"
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import/authors?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import/authors"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
