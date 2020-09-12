# Baroserver - Easy Barotrauma Dedicated Server

To use this:
* Modify `serversettings.xml` to match desired values. [[Docs](https://barotrauma.gamepedia.com/Serversettings.xml)]
* Modify `clientpermissions.xml` to set player permissions. [[Docs](https://barotrauma.gamepedia.com/Clientpermissions.xml)]
* Add any custom submarine files to the `Submarines` directory

Build the docker container:
```
docker build -t baroserver .
```

Run the container:
```
docker run -p 27015-27016:27015-27016/tcp -p 27015-27016:27015-27016/udp -it baroserver
```

This container uses steamcmd to download the most recent version of the Barotrauma dedicated server from Steam.

