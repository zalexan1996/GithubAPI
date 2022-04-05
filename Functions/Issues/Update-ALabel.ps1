
<#
.SYNOPSIS


        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER owner

         
.PARAMETER repo

         
.PARAMETER name

         
.PARAMETER new_name
The new name of the label. Emoji can be added to label names, using either native emoji or colon-style markup. For example, typing :strawberry: will render the emoji . For a full list of available emoji and codes, see "Emoji cheat sheet."
         
.PARAMETER color
The hexadecimal color code for the label, without the leading #.
         
.PARAMETER description
A short description of the label. Must be 100 characters or fewer.


.LINK
https://docs.github.com/en/rest/reference/issues
#>
Function Update-ALabel
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$owner,
		[Parameter(Mandatory=$FALSE)][string]$repo,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$new_name,
		[Parameter(Mandatory=$FALSE)][string]$color,
		[Parameter(Mandatory=$FALSE)][string]$description
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/labels/$name?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/repos/$owner/$repo/labels/$name"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"new_name" = "$new_name"
	"color" = "$color"
	"description" = "$description"
    }

    $Output = Invoke-RestMethod -Method PATCH -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}
