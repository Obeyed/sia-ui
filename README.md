[Sia-UI](https://github.com/NebulousLabs/Sia-UI) in a docker container.

# Run the container

```
docker run --rm -it \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  -e DISPLAY=unix$DISPLAY \
  -v ~/.siacoin/:/root/ \
  -p 9981:9981 -p 9982:9982 \
  obeyed/sia-ui
```

If you get a message saying **No protocol specified**,
then allow docker to access the X server (see [this issue](https://github.com/jessfraz/dockerfiles/issues/6)) with:

```
xhost local:root
```

Furthermore, when you've run the container once, you should `chown` of the created folders, so your user owns them.

```
sudo chown -R $(whoami) ~/.siacoin
```
