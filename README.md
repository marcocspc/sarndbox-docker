## Official documentation

Link: https://web.cs.ucdavis.edu/~okreylos/ResDev/SARndbox/SoftwareInstallation.html

## Host preparation

Install docker and docker-compose.

Install libfreenect:
```
sudo apt install freenect -y
```

Give yourself docker permissions:
```
sudo usermod -a YOUR_USER -G docker
```

Reboot so changes can take effect. 
Once logged back in, type:

```
sudo make installudevrules
```

Then build image:
```
make
```

Install [nvidia toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker).

Then get your Kinect parameters:

```
docker-compose run sarndbox /usr/local/bin/KinectUtil getCalib 0
```


