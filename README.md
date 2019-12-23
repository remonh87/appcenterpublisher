![Build status](https://travis-ci.com/remonh87/appcenterpublisher.svg?branch=master)


# App Center Publisher

Dart tooling to upload and distribute app to MS Appcenter by using the rest [Appcenter Rest API]("https://docs.microsoft.com/en-us/appcenter/distribution/uploading#uploading-the-package", "MS Api docs") .

## Installation

Run `pub global activate appcenterpublisher `

In order to update the tool use the same `pub global activate` command

## Usage 

Preconditions:
1. Create an Api token on App Center Read more about how to create such a token [here](https://docs.microsoft.com/en-us/appcenter/api-docs/ "Appcenter api docs").

2. Create a yaml file containing the config. For more info see the [example config](https://github.com/remonh87/appcenterdistributor/tree/master/example/src, "Example config").

3. Have a binary of the app (e.g. `.ipa` or `.apk`) located on the machine from where you want to run this tool. 


Run ``` appcenterpublisher publish --apiToken <appcenter apitoken> --binary <path to binary> --config <path to config yaml file> ```


## Limitations

The tool is not yet complete in the future I will add the following to the tool:
  
* Distribute the app to multiple distribution groups at once
* Add more configuration options: 
    * Notify testers (now on by default)
    * Mandatory update (now on by default)
