# test-opengl

Use this repo to test whether a dockerized, minimal OpenGL is working right.

You may also use this in your own recipes that need a functioning OpenGL pipeline.

---

### Usage: 

Change directory to either `integrated` or `nvidia_discrete` according to whether you are using an integrated (e.g. Intel UHD Graphics, AMD RX Vega) or discrete nVidia video card. The only prerequisite is Docker. In the second case, make sure you have the `nvidia-container-runtime` package installed alongside Docker.

In both cases, the `.sh` run file will start the container and run a simple render benchmark.

#### Integrated video card

```shell
cd integrated
./build.sh
./run.sh
```

#### Dedicated video card

```shell
cd nvidia_discrete
./build.sh
./run.sh
```

In this case, the run file will also print the output of `nvidia-smi` as a further debug tool.