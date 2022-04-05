
<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER column_id
column_id parameter
         
.PARAMETER note
Required. The project card's note
         
.PARAMETER content_id
Required. The unique identifier of the content associated with the card
         
.PARAMETER content_type
Required. The piece of content associated with the card


.LINK
https://docs.github.com/en/rest/reference/projects
#>
Function Create-AProjectCard
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$column_id,
		[Parameter(Mandatory=$FALSE)][string]$note,
		[Parameter(Mandatory=$FALSE)][string]$content_id,
		[Parameter(Mandatory=$FALSE)][string]$content_type
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/projects/columns/$column_id/cards?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/projects/columns/$column_id/cards"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"note" = "$note"
	"content_id" = "$content_id"
	"content_type" = "$content_type"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

