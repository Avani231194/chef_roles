# sonar

 
#Make Entries in your Runlist (runlist.json) for running this cookbook

{
"run_list" : [ "recipe[sonar::default]" ]
}



##The above command will start the sonar service on port 9000. ##To access the sonar dashboard, visit http://:9000/sonar. ##You will be able to see the sonar homepage as shown below.
--------------------------------------------------------------------------------------------------------------------------------------------

By default, sonar will run on 9000. If you want on port 80 or any other port,change the following parameters for accessing the web console on that specific port in  -  file : /opt/sonarqube/conf/sonar.properties


sonar.web.host=0.0.0.0
sonar.web.port=80


