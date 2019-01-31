Unified Automation ANSI C Server SDK V1.8.3 Configuration on Linux
==

## Requirements

* Debian 8/9
* Wine
* Unified Automation ANSI C Server [1]

## Preparation 
* Install wine with root

```
apt install wine
dpkg --add-architecture i386 && apt-get update && apt-get install wine32
```
* Install the downloaded Server and uaexpert on Linux

```
$ wine uaserverc-win32-x86-vs2010sp1-v1.8.3-398.exe
$ wine uaexpert-bin-win32-x86-vs2008sp1-v1.5.0-319.exe

```

## Run and Stop a simulated server

* Start the server
```
 ./start_server.bash start
jhlee@hadron: opcua-server (master)$ UA Server: Initializing Stack...
10:58:39.559|E|0009* UA Server: Building Provider List...
10:58:39.560|E|0009* UA Server: Loading Provider Modules...
10:58:39.560|W|0009* Initialize Server Provider ...
10:58:39.564|W|0009* Server Provider initialized!
10:58:39.564|W|0009*    2043 Nodes created
10:58:39.564|W|0009*    NS1:
10:58:39.564|W|0009*    19 static nodes created
10:58:39.564|W|0009*    35 static references created
10:58:39.564|W|0009*    3 static methods created
10:58:39.564|E|0009* Initialize Demo Provider ...
10:58:39.569|E|0009* Demo Provider initialized!
10:58:39.569|E|0009*    2566 Nodes created
10:58:39.569|E|0009*    NS4:
10:58:39.569|E|0009*    569 static nodes created
10:58:39.569|E|0009*    1199 static references created
10:58:39.569|E|0009*    23 static methods created
10:58:39.569|W|0009* Configuration warning: SecurityPolicy 'http://opcfoundation.org/UA/SecurityPolicy#None' is enabled, this allows clients to connect without security and certificate validation
10:58:39.570|E|0009* 
10:58:39.570|E|0009* ######################################################################
10:58:39.570|E|0009* # Server started! Press x to stop; r to restart the server!
10:58:39.570|E|0009* ######################################################################
10:58:39.571|E|0009*   Endpoint URL 0: opc.tcp://127.0.0.1:48020
10:58:39.571|E|0009*   Server started at 2018-11-27T09:58:39.571Z

```

* Stop the server
```
opcua-server (master)$ ./start_server.bash stop
>> Server is running with 22685
   Killing the running server ....
```

* Restart the server
```
opcua-server (master)$ ./start_server.bash restart
>> Server is running with 22744
   Killing the running server ....
jhlee@hadron: opcua-server (master)$ UA Server: Initializing Stack...
10:59:41.684|E|0020* UA Server: Building Provider List...
10:59:41.685|E|0020* UA Server: Loading Provider Modules...
10:59:41.685|W|0020* Initialize Server Provider ...
10:59:41.689|W|0020* Server Provider initialized!
10:59:41.689|W|0020*    2043 Nodes created
10:59:41.689|W|0020*    NS1:
10:59:41.689|W|0020*    19 static nodes created
10:59:41.689|W|0020*    35 static references created
10:59:41.690|W|0020*    3 static methods created
10:59:41.690|E|0020* Initialize Demo Provider ...
10:59:41.695|E|0020* Demo Provider initialized!
10:59:41.695|E|0020*    2566 Nodes created
10:59:41.695|E|0020*    NS4:
10:59:41.695|E|0020*    569 static nodes created
10:59:41.695|E|0020*    1199 static references created
10:59:41.695|E|0020*    23 static methods created
10:59:41.695|W|0020* Configuration warning: SecurityPolicy 'http://opcfoundation.org/UA/SecurityPolicy#None' is enabled, this allows clients to connect without security and certificate validation
10:59:41.697|E|0020* 
10:59:41.697|E|0020* ######################################################################
10:59:41.697|E|0020* # Server started! Press x to stop; r to restart the server!
10:59:41.697|E|0020* ######################################################################
10:59:41.697|E|0020*   Endpoint URL 0: opc.tcp://hadron:48020
10:59:41.697|E|0020*   Server started at 2018-11-27T09:59:41.697Z

```

* Check the settings.ini into the bin path

One example, the target path is defined as 

```
${HOME}/.wine/drive_c/Program Files/UnifiedAutomation/UaAnsiCServer/bin/settings.ini
```
In order to make the connection smoothly, it would be better to replace [gethostname] with 127.0.0.1 such as
```
opc.tcp://127.0.0.1:48020
```


* Start the UaExpert
```
opcua-server (master)$ ./start_server.bash uaexpert
```

* Get the machine ip address
```
uaopcua-server (master)$ ./start_server.bash ip
```


## Connect the Server with EPICS IOC 

Please check e3-opcua [2] in order to do this.

## OPC UA GUI Client
One can download the Unified-automation UaExpert tool [3].


## Reference
[1] https://www.unified-automation.com/downloads/opc-ua-servers

[2] https://github.com/icshwi/e3-opcua

[3] https://www.unified-automation.com/downloads/opc-ua-clients/file/download/details/uaexpert-v150.html
