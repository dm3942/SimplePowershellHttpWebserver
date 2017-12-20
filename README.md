# SimplePowershellHttpWebserver
This is a bare bones http listener that can handle POST and GET requests.

Save SimplePowershellHttpListener.ps1 to a file and run as administrator. Then use the following to test, the rest is up to you and google.

# Powershell snippet to test http listener
$postParams = @{data='blobofdata1';moredata='Star Wars, luke skywalker gets a lightsaber to the face!'}
Invoke-WebRequest -Uri http://localhost:80/foobar/anything/moreifyoulike -Method POST -Body $postParams

# Powershell snippet to test http listener
Invoke-WebRequest -UseBasicParsing http://localhost:80/foobar/yourson/etc/father/luke -ContentType "application/json" -Method POST -Body "{ 'data':'blobofdata1', 'moredata':'Star Wars, luke skywalker gets a lightsaber to the face!', 'anum': 1023}"


# PHP snippet to test http listener
....
$postdata = http_build_query(
    array(
        'data' => 'blobofdata1',
        'moredata' => 'Star Wars, luke skywalker gets a lightsaber to the face!'
    )
);
$opts = array('http' =>
    array(
        'method'  => 'POST',
        'header'  => 'Content-type: application/x-www-form-urlencoded',
        'content' => $postdata
    )
);
$context  = stream_context_create($opts);
$result = file_get_contents('http://hostname.com:80/foobar/fromphp/etc/etc', false, $context);
....
