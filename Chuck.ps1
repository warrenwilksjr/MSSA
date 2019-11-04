function Get-Joke {
    <#Created a alias to save time#>
    [Alias('cn')]
    <#Created joke parameter to set the amount of jokes to be told#>
    param([int]$joke=10
    )
    <#Added this library to allow my computer to speak the jokes#>
    Add-Type -AssemblyName System.speech
    $speak = New-Object System.speech.Synthesis.SpeechSynthesizer
    
    <#Looped the api in order print and say new jokes every time is called#>
    for($i = 0; $i -lt $joke; $i++)
    {
    $chuck = Invoke-RestMethod -Uri "https://api.chucknorris.io/jokes/random"
    <#Prints jokes to the screen#>
    Write-Host $chuck.value
    <#Speaks the jokes#>
    $speak.speak($chuck.value)
    }
    }