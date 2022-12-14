## Host preparation

Install docker, docker-compose and, if using a nvidia GPU, [nvidia toolkit](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html#docker).

Give yourself docker permissions:

```
sudo usermod -a YOUR_USER -G docker
```

Reboot so changes can take effect. 
Once logged back in, type:

```
sudo make installudevrules
```

## Building image

To build image run:

```
make
```

Or, if using nvidia host (recommended):

```
make nvidia
```

To view the application windows, you need to give docker permissions in your X server:

```
xhost +local:docker
```

## Running

To start running sarndbox, you first need to follow the [official documentation](https://web.cs.ucdavis.edu/~okreylos/ResDev/SARndbox/SoftwareInstallation.html) from "System Integration, Configuration, and Calibration".

Just some clarification on how to run commands inside the container: 

1. For every command needed to run, use `docker-compose run sarndbox <COMMAND>` if running the regular image or `docker-compose run sarndbox-nvidia <COMMAND>` if running nvidia;
1. You can use sudo, even if it's not recommended;
1. If facing a cd command, like those in the [official documentation](https://web.cs.ucdavis.edu/~okreylos/ResDev/SARndbox/SoftwareInstallation.html), you need to run it in one line, like this: `docker-compose run sarndbox-nvidia bash -c "cd <YOUR-DIRECTORY> && <COMMAND>"`.
