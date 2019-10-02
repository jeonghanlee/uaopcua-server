Unified Automation ANSI C Server SDK V1.8.3 Configuration on Linux
==

## Requirements

* Debian 8/9/10
* Wine
* Unified Automation ANSI C Server [1]

## Preparation 

### UaExpert on Linux

Extract `tar.gz` file into a specific folder. 
```
ln -s ~/programs/uaexpert-1.5.1/UaExpert-1.5.1-331-x86_64.AppImage  ~/bin/uaexpert
```

### UA Demo Server on Linux


* Install wine with root

```
dpkg --add-architecture i386 && apt-get update && apt-get install wine wine32 winbind
```


* Install the downloaded OPC UA C Demo Server / C++ Demo Server on Linux

There are two Demo Servers, one can install both through wine

```
$ wine uaservercpp-win32-x86-vs2010sp1-v1.7.0-449.exe
```
Set the installation path such as `C:\UnifiedAutomation\UaCPPServer`


```
$ wine uaserverc-win32-x86-vs2010sp1-v1.8.3-398.exe
```
Set the installation path such as `C:\UnifiedAutomation\UaAnsiCServer`



## Configure a simulated server

* Open `UaAnsiCServer/bin/settings.ini` and replace `[gethostname]` with `127.0.0.1`. 

```
uaopcua-server (master)$ ./start_server.bash edit
```

## Run and Stop a simulated server
However, we only cover UA C demo server. 


* Start the server : C demo
```
jhlee@proton: uaopcua-server (master)$ ./start_server.bash start
jhlee@proton: uaopcua-server (master)$ UA Server: Initializing Stack...
12:12:24.974|E|0009* UA Server: Building Provider List...
12:12:24.974|E|0009* UA Server: Loading Provider Modules...
12:12:24.974|W|0009* Initialize Server Provider ...
12:12:24.979|W|0009* Server Provider initialized!
12:12:24.979|W|0009*    2043 Nodes created
12:12:24.979|W|0009*    NS1:
12:12:24.979|W|0009*    19 static nodes created
12:12:24.979|W|0009*    35 static references created
12:12:24.979|W|0009*    3 static methods created
12:12:24.979|E|0009* Initialize Demo Provider ...
12:12:24.985|E|0009* Demo Provider initialized!
12:12:24.985|E|0009*    2566 Nodes created
12:12:24.985|E|0009*    NS4:
12:12:24.985|E|0009*    569 static nodes created
12:12:24.985|E|0009*    1199 static references created
12:12:24.985|E|0009*    23 static methods created
12:12:24.985|W|0009* Configuration warning: SecurityPolicy 'http://opcfoundation.org/UA/SecurityPolicy#None' is enabled, this allows clients to connect without security and certificate validation
12:12:24.986|E|0009* 
12:12:24.986|E|0009* ######################################################################
12:12:24.986|E|0009* # Server started! Press x to stop; r to restart the server!
12:12:24.986|E|0009* ######################################################################
12:12:24.986|E|0009*   Endpoint URL 0: opc.tcp://127.0.0.1:48020
12:12:24.986|E|0009*   Server started at 2019-10-02T10:12:24.986Z
```

* Stop the server
```
uaopcua-server (master)$ ./start_server.bash stop
>> Server is running with 7009
   Killing the running server ....
```

* Restart the server
```
uaopcua-server (master)$ ./start_server.bash restart
>> Server is not running
jhlee@proton: uaopcua-server (master)$ UA Server: Initializing Stack...
12:13:00.117|E|0009* UA Server: Building Provider List...
12:13:00.117|E|0009* UA Server: Loading Provider Modules...
12:13:00.117|W|0009* Initialize Server Provider ...
12:13:00.121|W|0009* Server Provider initialized!
12:13:00.122|W|0009*    2043 Nodes created
12:13:00.122|W|0009*    NS1:
12:13:00.122|W|0009*    19 static nodes created
12:13:00.122|W|0009*    35 static references created
12:13:00.122|W|0009*    3 static methods created
12:13:00.122|E|0009* Initialize Demo Provider ...
12:13:00.128|E|0009* Demo Provider initialized!
12:13:00.128|E|0009*    2566 Nodes created
12:13:00.128|E|0009*    NS4:
12:13:00.128|E|0009*    569 static nodes created
12:13:00.128|E|0009*    1199 static references created
12:13:00.128|E|0009*    23 static methods created
12:13:00.128|W|0009* Configuration warning: SecurityPolicy 'http://opcfoundation.org/UA/SecurityPolicy#None' is enabled, this allows clients to connect without security and certificate validation
12:13:00.129|E|0009* 
12:13:00.129|E|0009* ######################################################################
12:13:00.129|E|0009* # Server started! Press x to stop; r to restart the server!
12:13:00.129|E|0009* ######################################################################
12:13:00.129|E|0009*   Endpoint URL 0: opc.tcp://127.0.0.1:48020
12:13:00.129|E|0009*   Server started at 2019-10-02T10:13:00.129Z
```


* Check the settings.ini into the bin path

One example, the target path is defined as 

```
${HOME}/.wine/drive_c/UnifiedAutomation/UaAnsiCServer/bin/settings.ini
```
In order to make the connection smoothly, it would be better to replace [gethostname] with 127.0.0.1 such as
```
opc.tcp://127.0.0.1:48020
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
