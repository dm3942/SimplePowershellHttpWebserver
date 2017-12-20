# This is a bare bones http listener that can handle POST and GET requests.


$fqdn = $env:COMPUTERNAME, ".", $env:USERDNSDOMAIN -join ''
$port = 80
$url = "http://",$fqdn,":",$port,"/" -join ''
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add($url)
$listener.Start()
write-host "Listening at $url..."


while ($listener.IsListening)
{
    $context = $listener.GetContext()
    $response = $context.Response
    $requestUrl = $context.Request.Url
    $localPath = $requestUrl.LocalPath
    ''
    Get-Date
    "> $localPath"  

    # If POST request and has post data body
    if(($context.Request.HttpMethod -eq "POST") -and ($context.Request.HasEntityBody -eq $True))  {
        [System.IO.Stream] $body = $context.request.InputStream
        [System.Text.Encoding] $encoding = $context.request.ContentEncoding
        [System.IO.StreamReader] $reader = New-Object System.IO.StreamReader $body, $encoding

        $s = $reader.ReadToEnd();
        $s   # -----------------  show http POST data
        $body.Close()
        $reader.Close()
    }   

    $content = "<html><head><title>Response from powershell</title></head><body><pre>Response to client.</pre></html>"
    $buffer = [System.Text.Encoding]::UTF8.GetBytes($content)
    $response.ContentLength64 = $buffer.Length
    $response.OutputStream.Write($buffer, 0, $buffer.Length)
    
    $response.Close()
 
    $responseStatus = $response.StatusCode
    Write-Host "< $responseStatus"
}

