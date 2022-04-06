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
    
    
    $Queries = $FunctionObject.Parameters | Where-Object In -like Query | Foreach-Object {
        "`"$($_.Name)=`$$($_.Name)`""
    }

    $Bodies = $FunctionObject.Parameters | Where-Object In -like body | Select-Object -Expand Name | Foreach-Object { "`"$_`"" }

@"
<#
.SYNOPSIS
$($FunctionObject.Synopsis)

$ParameterDocumentations

.LINK
$DocumentationURL
#>
Function $($FunctionObject.FunctionName)
{
    [CmdletBinding()]
    Param(
$($ParameterDefinitions -join ",`n")
    )
    `$QueryStrings = @(
        $($Queries -join ",`n`t`t")
    ) | ? { `$PSBoundParameters.ContainsKey(`$_) }


    `$Body = @{}
    @( 
        $($Bodies -join ",`n`t`t") 
    ) | ? { `$PSBoundParameters.ContainsKey(`$_) } | % { `$Body[`$_] = `$PSBoundParameters[`$_] }



    
    if (![String]::IsNullOrEmpty(`$QueryStrings))
    {
        `$FinalURL = "$($FunctionObject.Uri)?`$(`$QueryStrings -join '&')"
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