<#
.SYNOPSIS
Creates or updates an organization secret with an encrypted value. Encrypt your secret using LibSodium. You must authenticate using an access token with the admin:org scope to use this endpoint. GitHub Apps must have the dependabot_secrets organization permission to use this endpoint.
Example encrypting a secret using Node.js
Encrypt your secret using the tweetsodium library.
const sodium = require('tweetsodium');

const key = "base64-encoded-public-key";
const value = "plain-text-secret";

// Convert the message and key to Uint8Array's (Buffer implements that interface)
const messageBytes = Buffer.from(value);
const keyBytes = Buffer.from(key, 'base64');

// Encrypt using LibSodium.
const encryptedBytes = sodium.seal(messageBytes, keyBytes);

// Base64 the encrypted secret
const encrypted = Buffer.from(encryptedBytes).toString('base64');

console.log(encrypted);
Example encrypting a secret using Python
Encrypt your secret using pynacl with Python 3.
from base64 import b64encode
from nacl import encoding, public

def encrypt(public_key: str, secret_value: str) -> str:
  """Encrypt a Unicode string using the public key."""
  public_key = public.PublicKey(public_key.encode("utf-8"), encoding.Base64Encoder())
  sealed_box = public.SealedBox(public_key)
  encrypted = sealed_box.encrypt(secret_value.encode("utf-8"))
  return b64encode(encrypted).decode("utf-8")
Example encrypting a secret using C#
Encrypt your secret using the Sodium.Core package.
var secretValue = System.Text.Encoding.UTF8.GetBytes("mySecret");
var publicKey = Convert.FromBase64String("2Sg8iYjAxxmI2LvUXpJjkYrMxURPc8r+dB7TJyvvcCU=");

var sealedPublicKeyBox = Sodium.SealedPublicKeyBox.Create(secretValue, publicKey);

Console.WriteLine(Convert.ToBase64String(sealedPublicKeyBox));
Example encrypting a secret using Ruby
Encrypt your secret using the rbnacl gem.
require "rbnacl"
require "base64"

key = Base64.decode64("+ZYvJDZMHUfBkJdyq5Zm9SKqeuBQ4sj+6sfjlH4CgG0=")
public_key = RbNaCl::PublicKey.new(key)

box = RbNaCl::Boxes::Sealed.from_public_key(public_key)
encrypted_secret = box.encrypt("my_secret")

# Print the base64 encoded secret
puts Base64.strict_encode64(encrypted_secret)

        
.PARAMETER accept
Setting toapplication/vnd.github.v3+json is recommended.
         
.PARAMETER org

         
.PARAMETER secret_name
secret_name parameter
         
.PARAMETER encrypted_value
Value for your secret, encrypted with LibSodium using the public key retrieved from the Get an organization public key endpoint.
         
.PARAMETER key_id
ID of the key you used to encrypt the secret.
         
.PARAMETER visibility
Required. Configures the access that repositories have to the organization secret. Can be one of:
- all - All repositories in an organization can access the secret.
- private - Private repositories in an organization can access the secret.
- selected - Only specific repositories can access the secret.
         
.PARAMETER selected_repository_ids
An array of repository ids that can access the organization secret. You can only provide a list of repository ids when the visibility is set to selected. You can manage the list of selected repositories using the List selected repositories for an organization secret, Set selected repositories for an organization secret, and Remove selected repository from an organization secret endpoints.


.LINK
https://docs.github.com/en/rest/reference/dependabot

.OUTPUTS

#>
Function Create-OrUpdateAnOrganizationSecret
{
    [CmdletBinding()]
    Param(
		[Parameter(Mandatory=$FALSE)][string]$accept,
		[Parameter(Mandatory=$FALSE)][string]$org,
		[Parameter(Mandatory=$FALSE)][string]$secret_name,
		[Parameter(Mandatory=$FALSE)][string]$encrypted_value,
		[Parameter(Mandatory=$FALSE)][string]$key_id,
		[Parameter(Mandatory=$FALSE)][string]$visibility,
		[Parameter(Mandatory=$FALSE)][string[]]$selected_repository_ids
    )
    $Querys = @()
    $QueryStrings = @(
        
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Querys = $Querys + "$($_)=$($PSBoundParameters[$_])" }


    $Body = @{}
    @( 
        "encrypted_value",
		"key_id",
		"visibility",
		"selected_repository_ids" 
    ) | ? { $PSBoundParameters.ContainsKey($_) } | % { $Body[$_] = $PSBoundParameters[$_] }



    
    if (![String]::IsNullOrEmpty($Querys))
    {
        $FinalURL = "https://api.github.com/orgs/$org/dependabot/secrets/$secret_name?$($Querys -join '&')"
    }
    else
    {
        $FinalURL = "https://api.github.com/orgs/$org/dependabot/secrets/$secret_name"
    }


    $Headers = @{
        "Authorization" = "token $Global:GithubToken"
		"accept" = "$accept"
    }

    Write-Verbose ($Body | ConvertTo-JSON)
    $Output = Invoke-RestMethod -Method PUT -Uri "$FinalURL" -Headers $Headers -Body ($Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    $Output | Write-Output
}
