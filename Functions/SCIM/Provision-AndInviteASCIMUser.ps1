
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
         
.PARAMETER Properties of thenameobject

         
.PARAMETER emails
Required. user emails
         
.PARAMETER Properties of theemailsitems

         
.PARAMETER schemas

         
.PARAMETER externalId

         
.PARAMETER groups

         
.PARAMETER active



.LINK
https://docs.github.com/en/rest/reference/scim
#>
Function Provision-AndInviteASCIMUser
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$userName,
		[Parameter(Mandatory=$FALSE)][string]$displayName,
		[Parameter(Mandatory=$FALSE)][string]$name,
		[Parameter(Mandatory=$FALSE)][string]$Properties of thenameobject,
		[Parameter(Mandatory=$FALSE)][string]$emails,
		[Parameter(Mandatory=$FALSE)][string]$Properties of theemailsitems,
		[Parameter(Mandatory=$FALSE)][string]$schemas,
		[Parameter(Mandatory=$FALSE)][string]$externalId,
		[Parameter(Mandatory=$FALSE)][string]$groups,
		[Parameter(Mandatory=$FALSE)][string]$active
    )
    $QueryStrings = @() | ? { $PSBoundParameters.ContainsKey($_) }

    
    if (![String]::IsNullOrEmpty($QueryStrings))
    {
        $FinalURL = "https://api.github.com/scim/v2/organizations/$org/Users?$($QueryStrings -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/scim/v2/organizations/$org/Users"
    }


    $Headers = @{
        "Authorization" = "token $Script:GithubToken"
		"accept" = "$accept"
    }

    $Body = @{
        	"userName" = "$userName"
	"displayName" = "$displayName"
	"name" = "$name"
	"emails" = "$emails"
	"schemas" = "$schemas"
	"externalId" = "$externalId"
	"groups" = "$groups"
	"active" = "$active"
    }

    $Output = Invoke-RestMethod -Method POST -Uri "$FinalURL" -Headers $Headers -Body $Body -ResponseHeadersVariable $ResponseHeaders

    $Output | Write-Output
}

