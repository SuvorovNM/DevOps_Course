<html>
<head>
<title>Backend Python Script</title>
<?PHP
	$headersRaw = getallheaders();
	$hString = '';
	#$testString = ''
    foreach($headersRaw as $key => $value)
    {
		$hString .= ',' . $value;
		#echo shell_exec("python /var/www/html/test.py $value");
    }
	$hString = preg_replace('/\s+/', '', $hString);
	$hString = str_replace(array("\n","\r",";"), '', $hString);
	#echo $hString;
	#echo shell_exec("python /var/www/html/test.py TEST"); $testString
	#echo sprintf('python test.py "%s"', $hString);
	echo shell_exec(sprintf('python test.py "%s"', $hString));
	#exec(sprintf('python test.py "%s"', $hString), $output, $retval);
?>
</head>