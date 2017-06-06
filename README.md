# consul-cluster-compose

Sometimes you just want to play with a consul cluster in containers and poke it a little.

Sets up a 7 node consul cluster with 3 servers. The only container with exposed ports is the consul instance bootstrapping the cluster. The ports it exposes by default: 8400, 8500 (web-ui) and 8600

## Requirements

docker
docker-compose

Or

consul in your $PATH

## Instructions

To run, do the following from the folder containing the docker-compose.yml
`docker-compose up -d`

To start with shell script:
./run_single_host_cluster.sh

To kill all instances with shell script:
./kill_all_dev_instances.sh

## Issues

If you stop a cluster without removing all the containers, on startup, the cluster may have trouble re-electing leaders... to start from scratch you can remove all the containers with:
`docker-compose rm`

Also, don't run the shell scripts as superuser... port assignments > 10000 to avoid requiring super user.
