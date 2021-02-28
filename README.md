Docker Image for SDN studies purpose
----

# About

This is image is a fork based on Ryu docker image with some features to study and develop networking skills.

# Requirements

Docker! (and docker compose)

# How to build

    git clone git@github.com:jvrmaia/docker-sdn-base.git
    cd docker-sdn-base
    docker build -t sdn-base:latest .

# How to run

    docker-compose up -d
    docker-compose exec mininet bash
    service openvswitch-switch start

# Troubleshoot

If you can't start Wireshark from container, try this in your host first:

    xhost +local:

To restore:

    xhost -

# References

* [Mininet](http://mininet.org)
* [Ryu](https://osrg.github.io/ryu/)
* [Docker](https://www.docker.com/)
