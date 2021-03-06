<#
.SYNOPSIS
Update an author's identity for the import. Your application can continue updating authors any time before you push new commits to the repository.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER author_id

         
.PARAMETER email
The new Git author email.
         
.PARAMETER name
The new Git author name.


.LINK
https://docs.github.com/en/rest/reference/migrations

.OUTPUTS
 {
  "id": 2268557,
  "remote_id": "nobody@fc7da526-431c-80fe-3c8c-c148ff18d7ef",
  "remote_name": "nobody",
  "email": "hubot@github.com",
  "name": "Hubot",
  "url": "https://api.github.com/repos/octocat/socm/import/authors/2268557",
  "import_url": "https://api.github.com/repos/octocat/socm/import"
}
#>
Function Map-ACommitAuthor
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][int]$author_id,
		[Parameter(Mandatory=$FALSE)][string]$email,
		[Parameter(Mandatory=$FALSE)][string]$name
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "email",
		"name" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import/authors/$author_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/import/authors/$author_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
