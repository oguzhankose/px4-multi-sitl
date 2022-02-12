<!-- PROJECT LOGO -->
<br />
<p align="center">
  

  <h1 align="center">PX4 SITL Simulator for Multiple Vehicles</h1>

  <p align="center">
    <a href="https://github.com/oguzhankose/px4-multi-sitl/issues">Report Bug</a>
    ·
    <a href="https://github.com/oguzhankose/px4-multi-sitl/issues">Request Feature</a>
  </p>
</p>



<!-- TABLE OF CONTENTS -->
<details open="open">
  <summary><h2 style="display: inline-block">Table of Contents</h2></summary>
  <ol>
    <li>
      <a href="#purpose">Purpose of the Project</a>
    </li>
    <li>
      <a href="#installation">Installation</a>
    </li>
    <li><a href="#usage">Usage</a></li>
      <ul>
        <li><a href="#single-usage">Running Single Instance</a></li>
      </ul>
      <ul>
        <li><a href="#multi-usage">Running Multiple Instances</a></li>
      </ul>
    <li>
      <a href="#env-variables">Environment Variables</a>
    </li>
    <li><a href="#license">License</a></li>
    <li><a href="#contact">Contact</a></li>
  </ol>
</details>



<!-- ABOUT THE PROJECT -->
## Purpose of Project



In this project, we will be setting up a SITL simulation for PX4 within a Docker container. The container is also capable of creating multiple vehicles if you want swarm simulations etc. 

<br />


## Installation

List of the packages that is required for this package is

* Docker
* A GCS software to connect to vehicle(s) (It can be QGroundControl or MAVProxy etc.)

To get a local copy up simply run the following command.

Pull the docker image from server
```sh
docker pull oguzhankose/px4-multi-sitl:latest
```

<br />


<!-- USAGE EXAMPLES -->
## Usage

If you want only one vehicle you can run container without making any changes. For multi simulations you need to set afew parameters.

For connecting vehicles you can use MAVProxy as follows (or you can use QGroundControl etc.)

```sh
mavproxy.py --master=tcp:0.0.0.0:5760
```

> **Warning** : This command will work only with default settings. If you change MAVLINK_TCP_OUT variable you also need to set TCP port in here. 

<br />

## Running Single Instance

Just run container with default parameters
```sh
docker run --rm -it -p5760:5760/tcp oguzhankose/px4-multi-sitl:latest
```

> **Warning** : The simulation publishes MAVLink connection to **tcp:0.0.0.0:5760** by default. To cahnge tcp port see <a href="#env-variables">Environment Variables</a>.

<br />


## Running Multiple Instance

Run container for 3 vehicles with setting TCP port to 5770.
```sh
docker run --rm -it -p 5770:5770/tcp oguzhankose/px4-multi-sitl:latest -e NUMBER_OF_INSTANCES=3 -e MAVLINK_TCP_OUT="5770"
```

> **Warning** : MAVLINK_TCP_OUT variable and "-p" argument **MUST** be same.

<br />

## Environment Variables

Environment variables and their default values are as follows

* PX4_HOME_LAT&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;42.3898
* PX4_HOME_LON&emsp;&emsp;&emsp;&emsp;&emsp;-71.1476
* PX4_HOME_ALT&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;14.2
* HOST_IP&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;&emsp;192.168.1.211
* NUMBER_OF_INSTANCES&emsp;&emsp;1
* MAVLINK_TCP_OUT&emsp;&emsp;&emsp;&emsp;"5760"


<br />

<!-- CONTRIBUTING -->
## Contributing

Contributions are what make the open source community such an amazing place to learn, inspire, and create. Any contributions you make are **greatly appreciated**.

1. Fork the Project
2. Create your Feature Branch (`git checkout -b feature/AmazingFeature`)
3. Commit your Changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the Branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request


<br />

## License

Distributed under the MIT License. See `LICENSE` for more information.


<br />

<!-- CONTACT -->
## Contact

Oguzhan Kose - [@twitter](https://https://twitter.com/koseoguzhan1) - koseo16@itu.edu.tr

Project Link: [https://github.com/oguzhankose/px4-multi-sitl](https://github.com/oguzhankose/px4-multi-sitl)



