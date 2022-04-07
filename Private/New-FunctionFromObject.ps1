<#
.SYNOPSIS
Generates a PowerShell function from a PSCustomObject (the output from Get-FunctionFromDiv).



.PARAMETER FunctionObject
The output from Get-FunctionfromDiv:
[PSCustomObject]@{
    Synopsis = The Synopsis text of the endpoint
    FunctionName = The name of the function. 
    Method = The HTTP method of the function
    Parameters = @(
            @{
                Name = The name of the parameter
                Type = The datatype of the parameter
                In = Where the parameter is supplied to (Header, Body, Query, Path)
                Description = A short description of the paramater. Not all parameters have a scrapable Description field
                Default = "N/A"
            }
        }
    )
    Uri = The URI of the endpoint
    ExpectedOutput = The text from the Response box of the documentation page.
}

.PARAMETER DocumentationURL
The url of where we've scraped this info from. Will be used in the helpdocs of our generated function.

.OUTPUTS
Returns a powershell function as a [string]

#>
Function New-FunctionFromObject {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$TRUE, ValueFromPipeline)][PSCustomObject]$FunctionObject,
        [Parameter(Mandatory=$TRUE)][String]$DocumentationURL
    )
    $ParameterDefinitions = @()
    $ParameterDocumentations = @()
    $Body = @()
    $Headers = @(
        "`"Authorization`" = `"token `$Global:GithubToken`""
    )
    
    
    
    foreach ($Param in $FunctionObject.Parameters) {        
        $ReplacedParameter = $Param.Type `
            -replace "array of integers", "int[]" `
            -replace "array of objects", "object[]" `
            -replace "array of strings", "string[]" `
            -replace "integer", "int" `
            -replace "boolean", "bool"
        
        if ($ReplacedParameter -like "* or *") {
            if ($ReplacedParameter -like "array*") {
                $ReplacedParameter = "string[]"
            }
            else {
                $ReplacedParameter = "string"
            }
        }

        # No support for defaults. I don't have a good way of determining if something has a default or not.
        $ParameterDefinitions += "`t`t[Parameter(Mandatory=`$FALSE)][$ReplacedParameter]`$$($Param.Name)"
        
        if ($Param.in -like "header") {
            $Headers = $Headers + "`t`t`"$($Param.Name)`" = `"`$$($Param.Name)`""
        }
        if ($Param.in -like "body") {
            $Body = $Body + "`t`"$($Param.Name)`" = `"`$$($Param.Name)`""
        }

        $ParameterDocumentations = $ParameterDocumentations + @"
        
.PARAMETER $($Param.Name)
$($Param.Description)

"@
    }
    
    
    $Queries = $FunctionObject.Parameters | Where-Object In -like Query | Select-Object -Expand Name | Foreach-Object {
        "`"$_`""
    }

    $Bodies = $FunctionObject.Parameters | Where-Object In -like body | Select-Object -Expand Name | Foreach-Object { "`"$_`"" }

@"
<#
.SYNOPSIS
$($FunctionObject.Synopsis)

$ParameterDocumentations

.LINK
$DocumentationURL

.OUTPUTS
$($FunctionObject.ExpectedOutput)
#>
Function $($FunctionObject.FunctionName)
{
    [CmdletBinding()]
    Param(
$($ParameterDefinitions -join ",`n")
    )
    `$Querys = @()
    `$QueryStrings = @(
        $($Queries -join ",`n`t`t")
    ) | ? { `$PSBoundParameters.ContainsKey(`$_) } | % { `$Querys = `$Querys + "`$(`$_)=`$(`$PSBoundParameters[`$_])" }


    `$Body = @{}
    @( 
        $($Bodies -join ",`n`t`t") 
    ) | ? { `$PSBoundParameters.ContainsKey(`$_) } | % { `$Body[`$_] = `$PSBoundParameters[`$_] }



    
    if (![String]::IsNullOrEmpty(`$Querys))
    {
        `$FinalURL = "$($FunctionObject.Uri)?`$(`$Querys -join '&')"
    }
    else
    {
        `$FinalURL = "$($FunctionObject.Uri)"
    }


    `$Headers = @{
        $($Headers -join "`n")
    }

    Write-Verbose (`$Body | ConvertTo-JSON)
    `$Output = Invoke-RestMethod -Method $($FunctionObject.Method) -Uri "`$FinalURL" -Headers `$Headers -Body (`$Body | ConvertTo-JSON) -ResponseHeadersVariable ResponseHeaders
    

    `$Output | Write-Output
}
"@ | Write-Output

}