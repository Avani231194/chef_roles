# jenkins


##Make Entries in your Runlist (runlist.json) for running this cookbook

{ "run_list" : [ "recipe[jenkins::default]" ] }

##The above command will start the jenkins service on port 8080. ##To access the nexus dashboard, visit http://:8080. ##You will be able to see the jenkins homepage
~                                                                                                                                                                   
Inside your var/lib/jenkins/config.xml make sure that use security and disable signup is set false to avoid login.
 <useSecurity>false</useSecurity>
  <disableSignup>false</disableSignup>



