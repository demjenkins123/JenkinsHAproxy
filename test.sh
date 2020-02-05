
source /opt/initialise.sh
STATUS=$(curl -s -o /dev/null -w '%{http_code}' $primaryserver)
if [ $STATUS == "200" ] ; then
	echo "OK"
else
  var=$(echo $secondaryserver | awk '{gsub("http://|/|:.*","")}1' )
  echo $var
  ssh demjenkins123@$var "sudo systemctl start jenkins" 
  temp=$primaryserver
  echo "export primaryserver=$secondaryserver" > /opt/initialise.sh
  echo "export secondaryserver=$temp" >> /opt/initialise.sh
 
fi
echo $primaryserver
echo $secondaryserver
