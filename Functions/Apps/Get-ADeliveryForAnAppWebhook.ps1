<#
.SYNOPSIS
Returns a delivery for the webhook configured for a GitHub App.
You must use a JWT to access this endpoint.

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER delivery_id



.LINK
https://docs.github.com/en/rest/reference/apps

.OUTPUTS
 {
  "id": 12345678,
  "guid": "0b989ba4-242f-11e5-81e1-c7b6966d2516",
  "delivered_at": "2019-06-03T00:57:16Z",
  "redelivery": false,
  "duration": 0.27,
  "status": "OK",
  "status_code": 200,
  "event": "issues",
  "action": "opened",
  "installation_id": 123,
  "repository_id": 456,
  "url": "https://www.example.com",
  "request": {
    "headers": {
      "X-GitHub-Delivery": "0b989ba4-242f-11e5-81e1-c7b6966d2516",
      "X-Hub-Signature-256": "sha256=6dcb09b5b57875f334f61aebed695e2e4193db5e",
      "Accept": "*/*",
      "X-GitHub-Hook-ID": "42",
      "User-Agent": "GitHub-Hookshot/b8c71d8",
      "X-GitHub-Event": "issues",
      "X-GitHub-Hook-Installation-Target-ID": "123",
      "X-GitHub-Hook-Installation-Target-Type": "repository",
      "content-type": "application/json",
      "X-Hub-Signature": "sha1=a84d88e7554fc1fa21bcbc4efae3c782a70d2b9d"
    },
    "payload": {
      "action": "opened",
      "issue": {
        "body": "foo"
      },
      "repository": {
        "id": 123
      }
    }
  },
  "response": {
    "headers": {
      "Content-Type": "text/html;charset=utf-8"
    },
    "payload": "ok"
  }
}
#>
Function Get-ADeliveryForAnAppWebhook
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][int]$delivery_id
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
         
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/app/hook/deliveries/$delivery_id?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/app/hook/deliveries/$delivery_id"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method GET -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
