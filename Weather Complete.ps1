<#This script is to allow the user to get a weather report based on the city#>

<#This function gets the weather details for the user#>
Function Get-Weather {
<#Created a alias for my Get-Weather cmdlet#>
[Alias('gw')]

Param(
[string] $Location,
<#Set days equal to 1 because I want a five day forcast to be the deafault output the user does not specifiy the amount of days#>
[int] $Days = 1
)
<#Using the Maps variable to get the information from mapquest. Then using the lat and long varibles to point the lat and long information that
is needed.#>
$Map = Invoke-RestMethod -Uri "http://open.mapquestapi.com/geocoding/v1/address?key=o36UNN1EIinmzq15yvbvRGB4zvsuog5v&location=$Location"
$lat = $Map.results.locations[0].latLng.lat
$long = $Map.results.locations[0].latLng.lng

<#calling on the Darksky api to provide my weather information. Plugged in the lat and long varibles to give the api a location#>
$DS = Invoke-RestMethod -Uri "https://api.darksky.net/forecast/4317604ee4a46ffeba583ee2f649be95/$lat,$($long)"

<#created a for loop in order print on the amount of days needed to be displayed#>
for($i = 0; $i -lt $Days; $i++)
{
<#created a hash table to make all my information objects in order to print them out in list or table format. Used ordered to allow the information to be read left to right#>
    New-Object -typename PSObject -Prop ([ordered] @{

<#Each object is pointing a certain type of information that is needed#>
'Date and Time' = UDate($DS.daily.data[$i].time)
'Summary' = $DS.daily.data[$i].summary
'Tempature High F' = $DS.daily.data[$i].temperatureHigh
'Tempature Low F' = $DS.daily.data[$i].temperatureLow
'Tempature High C' = FairtoCel($DS.daily.data[$i].temperatureHigh)
'Tempature Low C' = FairtoCel($DS.daily.data[$i].temperatureLow)

})
}


}

<#This function is converting fahrenheit into celsius#>
function FairtoCel([double] $fahrenheit)
{
    $celcius = $fahrenheit - 32
    $celcius = $celcius / 1.8
    [math]::round($celcius,2)
}
<#This function is converting Unix time into a readable time for humans#>
Function UDate ($UnixDate) 
{

   [timezone]::CurrentTimeZone.ToLocalTime(([datetime]'1/1/1970').AddSeconds($UnixDate))
}
