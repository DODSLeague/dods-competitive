# DODSLeague Day of Defeat Source competitive Dedicated Server

This repository is based on the work of [Laclede's LANs](https://lacledeslan.com) [gamesrv-dods-freeplay](https://github.com/LacledesLAN/gamesvr-dods-freeplay) .

## Linux Container

[![linux/amd64](https://github.com/DODSLeague/dods-competitive/actions/workflows/build-linux-image.yml/badge.svg?branch=master)](https://github.com/DODSLeague/dods-competitive/actions/workflows/build-linux-image.yml)

### Download

```shell
docker pull dodsleague/dods-competitive;
```

### Run Self Tests

The image includes a test script that can be used to verify its contents. No changes or pull-requests will be accepted to this repository if any tests fail.

```shell
docker run -it --rm dodsleague/dods-competitive ./ll-tests/dods-competitive.sh;
```

### Run Interactive Server

```shell
docker run -it --rm --net=host dodsleague/dods-competitive ./srcds_run -game dod +map dod_avalanche +sv_lan 1
```
