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
