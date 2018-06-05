 <head>
  <title>My Website</title>
 </head>
 <body>
 <?php
	require '/home/ec2-user/sample_app/vendor/autoload.php';
	
	use Aws\DynamoDb\DynamoDbClient;
        date_default_timezone_set('America/New_York');
        $cache = new Gilbitron\Util\SimpleCache();
	$cache->cache_path = '/home/ec2-user/sample_app/vendor/gilbitron/cache/';
	$cache->cache_time = 3600;

	if($data = $cache->get_cache('label')){
		$data=$data;
	} else {
		$data = $cache->do_curl('http://169.254.169.254/latest/meta-data/instance-id/');
		$cache->set_cache('label', $data);
		
	}
	$client = DynamoDbClient::factory(array('profile' => 'default', 'region'  => 'us-east-1', 'version' => 'latest'));
	
        echo "<pre>Hello! Request answered from instance $data</pre>"; 
        
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

        
  if (!function_exists('getallheaders')) 
{ 
    function getallheaders() 
    { 
       $headers = array (); 
       foreach ($_SERVER as $name => $value) 
       { 
           if (substr($name, 0, 5) == 'HTTP_') 
           { 
               $headers[str_replace(' ', '-', ucwords(strtolower(str_replace('_', ' ', substr($name, 5)))))] = $value; 
           } 
       } 
       return $headers; 
    } 
}  
	
$headers =  getallheaders();
foreach($headers as $key=>$val){
  echo "<pre>$key . ': '$val</pre>";
}
?> 
 </body>
</html>
