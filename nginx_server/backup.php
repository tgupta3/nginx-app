 <head>
  <title>PHP Test</title>
 </head>
 <body>
 <?php
	require '/home/ec2-user/sample_app/vendor/autoload.php';
	use Aws\DynamoDb\DynamoDbClient;
        date_default_timezone_set('America/New_York');
	$client = DynamoDbClient::factory(array('profile' => 'default', 'region'  => 'us-east-1', 'version' => 'latest'));
	$output = shell_exec('curl 169.254.169.254/latest/meta-data/instance-id/');
        echo "<pre>Hello! Request answered from instance $output</pre>"; 
        
	if (!empty($_SERVER['HTTP_X_FORWARDED_FOR']))
        {
  		$IP = $_SERVER['HTTP_X_FORWARDED_FOR'];  
		echo "<pre>IP visited from- $IP</pre>";
       		$storer = $client->updateItem(array(
			'TableName' => 'dev',
			'Key' => array(
				'IP' => array('S' => $IP )),
			'ExpressionAttributeValues'  => array (':val1' => array('N' => '1')),
                        'UpdateExpression' => 'ADD Visitor :val1'				
               ));
                


		$result = $client->getItem(array(
                	'TableName' => 'dev',
                	'Key'=> array('IP' =>array('S' => $IP)),
                	'AttributesToGet' => array("Visitor")
         	));
                $count=$result['Item']['Visitor']['N'];
		echo "<pre>You have visited $count times</pre>";	
	 }

?> 
 </body>
</html>
