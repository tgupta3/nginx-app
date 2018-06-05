<head>
  <title>My Website</title>
 </head>
 <body>
 <?php
	require '/home/ec2-user/sample_app/vendor/autoload.php';
	$url = 'http://169.254.169.254/latest/meta-data/instance-id/';
	$ch = curl_init();
	curl_setopt($ch, CURLOPT_URL, $url);
	curl_setopt($ch, CURLOPT_RETURNTRANSFER, 1);
	curl_setopt($ch, CURLOPT_FOLLOWLOCATION, true);
	curl_setopt($ch, CURLOPT_CONNECTTIMEOUT, 5);
	$content = curl_exec($ch);
	curl_close($ch);
	echo "$content";
?>
 </body>
</html>
