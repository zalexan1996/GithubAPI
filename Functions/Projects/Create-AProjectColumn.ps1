<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER project_id

         
.PARAMETER name
Required. Name of the project column


.LINK
https://docs.github.com/en/rest/reference/projects

.OUTPUTS
 {
  "url": "https://api.github.com/projects/columns/367",
  "project_url": "https://api.github.com/projects/120",
  "cards_url": "https://api.github.com/projects/columns/367/cards",
  "id": 367,
  "node_id": "MDEzOlByb2plY3RDb2x1bW4zNjc=",
  "name": "To Do",
  "created_at": "2016-09-05T14:18:44Z",
  "updated_at": "2016-09-05T14:22:28Z"
}
#>
Function Create-AProjectColumn
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$project_id,
		[Parameter(Mandatory=$FALSE)][string]$name
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "name" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/projects/$project_id/columns?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/projects/$project_id/columns"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
