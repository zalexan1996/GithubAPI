<#
.SYNOPSIS
Provision organization membership for a user, and send an activation email to the email address.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER userName
Required. Configured by the admin. Could be an email, login, or username
         
.PARAMETER displayName
The name of the user, suitable for display to end-users
         
.PARAMETER name
Required.
         
.PARAMETER emails
Required. user emails
         
.PARAMETER schemas

         
.PARAMETER externalId

         
.PARAMETER groups

         
.PARAMETER active



.LINK
https://docs.github.com/en/rest/reference/scim

.OUTPUTS

#>
Function Provision-AndInviteASCIMUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$userName,
		[Parameter(Mandatory=$FALSE)][string]$displayName,
		[Parameter(Mandatory=$FALSE)][object]$name,
		[Parameter(Mandatory=$FALSE)][object[]]$emails,
		[Parameter(Mandatory=$FALSE)][string[]]$schemas,
		[Parameter(Mandatory=$FALSE)][string]$externalId,
		[Parameter(Mandatory=$FALSE)][string[]]$groups,
		[Parameter(Mandatory=$FALSE)][bool]$active
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "userName",
		"displayName",
		"name",
		"emails",
		"schemas",
		"externalId",
		"groups",
		"active" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/scim/v2/organizations/$org/Users?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/organizations/$org/Users"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
