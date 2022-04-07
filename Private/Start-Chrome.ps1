<#
.SYNOPSIS
Downloads the chromium web driver that matches your installed Chrome version.
It throws an exception if it can't find your Chrome installation.
It can also throw an exception if there isn't a web driver available for your chrome version yet.

.PARAMETER StartUrl
The URL to open the driver to

.PARAMETER Visible
Whether to display the web driver or not.

.OUTPUTS
Assuming everything succeeded, it should return a Chrome webdriver opened to your specified StartUrl.
#>
Function Start-Chrome {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)][String]$StartUrl,
        [Parameter(Mandatory=$False)][Bool]$Visible
    )

    if (Test-Path "${ENV:ProgramFiles(x86)}\Google\Chrome\Application\chrome.exe")
    { 
        $ChromePath = "${ENV:ProgramFiles(x86)}\Google\Chrome\Application" 
    }
    elseif (Test-Path "${ENV:ProgramFiles}\Google\Chrome\Application\chrome.exe")
    {
        $ChromePath = "${ENV:ProgramFiles}\Google\Chrome\Application"
    }
    else
    {
        throw "Failed to find Chrome. Make sure it's installed to one of your Program Files directories (X86 or x64)."
    }

    # Get the current chrome version
    $ChromeVersion = Get-ChildItem "$ChromePath" | Where-Object { 
        $_.Attributes -like "Directory" -and $_.Name -match "^\d+" 
    } | Select-Object -First 1 -ExpandProperty Name

    # Remove the old web driver if there is one
    if (Test-Path $ENV:TEMP\chromedriver.zip) {
        Remove-Item $ENV:TEMP\chromedriver.zip -Force
    }
    if (Test-Path $ENV:TEMP\chromedriver) {
        Remove-Item $ENV:TEMP\chromedriver -Force -Recurse
    }


    # Get the web driver for my Chrome version
    Invoke-WebRequest -URI "https://chromedriver.storage.googleapis.com/$ChromeVersion/chromedriver_win32.zip" -OutFile $ENV:TEMP\chromedriver.zip

    # Extract the zip
    Expand-Archive $ENV:TEMP\chromedriver.zip -DestinationPath "$ENV:TEMP\chromedriver" -Force

    # Start chrome with the correct web driver.
    Start-SeChrome -WebDriverDirectory "$ENV:TEMP\chromedriver" -StartURL $StartUrl -Incognito -Quiet -Headless:(!$Visible) -Arguments "--ignore-certificate-errors"
}