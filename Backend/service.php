<?php
echo "prima conness"
// Create connection
$con=mysqli_connect("cinematesdb.ckta6hgliogm.us-east-2.rds.amazonaws.com","admin","cinematesdbpsw","cinemates");
echo "dopo conness"
// Check connection
if (mysqli_connect_errno())
{
  echo "Failed to connect to MySQL: " . mysqli_connect_error();
}
echo "prima query"
// This SQL statement selects ALL from the table 'Locations'
$sql = "SELECT * FROM user";
echo "dopo query"

// Check if there are results
if ($result = mysqli_query($con, $sql))
{
	// If so, then create a results array and a temporary one
	// to hold the data
	$resultArray = array();
	$tempArray = array();

	// Loop through each row in the result set
	while($row = $result->fetch_object())
	{
		// Add each row into our results array
		$tempArray = $row;
	    array_push($resultArray, $tempArray);
	}
  echo "prima encode json"
	// Finally, encode the array to JSON and output the results
	echo json_encode($resultArray);
  echo "dopo encode json"
}

// Close connections
mysqli_close($con);


?>

<!doctype html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <title>PHP Application - AWS Elastic Beanstalk</title>

</head>
<body>
 <h2>What's Next?</h2>
</body>
</html>
