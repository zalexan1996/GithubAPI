Function Start-Chrome {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory=$True)][String]$StartUrl,
        [Parameter(Mandatory=$False)][Bool]$Visible
    )

    # Get the current chrome version
    $ChromeVersion = Get-ChildItem "${ENV:ProgramFiles(x86)}\Google\Chrome\Application" | Where-Object { 
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