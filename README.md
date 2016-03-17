# GetMeOffParse
This is a simple to use VM that sets up docker containers of Mongo and parse server.



## How to use
> This assumes that you have Vagrant installed  

* Clone this repo.
* Set the $path_to_cloud_code variable in the Vagrant file to the local path of your cloud code.
* Set the PARSE_APPLICATION_ID PARSE_MASTER_KEY in the provisions.sh file.
* Run `vagrant up` from the root of this project.
* Follow these [instructions](https://github.com/ParsePlatform/parse-dashboard) to install parse dashboard on your local machine using the ip address defined in the Vagrantfile
* Use the following code to add point your iOS app to this instance of parse:
```objective-c
  ParseClientConfiguration *config = [ParseClientConfiguration configurationWithBlock:^(id<ParseMutableClientConfiguration>  _Nonnull configuration) {
        configuration.applicationId = @"your app id";
        configuration.clientKey = @"your client key";
        configuration.server = @"http://192.168.2.2:1337/parse";
  }];
  [Parse initializeWithConfiguration:config];
```


## Notes

#### useMasterKey
```Parse.Cloud.useMasterKey();``` is not supported on parse server, instead add ```{useMasterKey:true}``` directly to your query.  
```query.get(objectId, {useMasterKey:true})```

#### Logging
Parse dashboard does not support ```console.log()``` like it did when using parse service.
Instead of using ```console.log```, you can use [winston](https://www.npmjs.com/package/winston) which comes downloaded with parse server. Using winston you can add logs to a log file on the server.  
```
var winston = require('winston');
winston.add(winston.transports.File, { filename:  'logs/main_logs.log'});
winston.log('info', 'Hello distributed log files!');
```
This will add a log message to a file located at /parse/logs/main_logs.log on the server container.
To access these logs, run ```vagrant ssh``` from the directory that contains the Vagrantfile.
Once you're in the VM run ```sudo docker exec -it parse-server bash``` to run a bash from inside the server container.
From there you can view your logs file at /parse/logs/main_logs.log

#### Cloud Code Server Url
In order for cloud code to run any queries, it needs to know the location of the server. This can be done by adding teh server URL to the start of your cloud code file. If you chose 192.168.2.2 as your local server ip address, you would add ```Parse.serverURL = "http://192.168.2.2:1337/parse"``` to the top of your cloud code file.
