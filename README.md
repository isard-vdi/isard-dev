# isard-dev
Development environment for Isard

## VM Image

In order to generate a VM image, you need to run:

```sh
guix system vm-image isard-x.scm -t qcow2 --image-size=100G
```

The default credentials are `dev`, `dev` 

## Usage

In order to use isard-dev you'll need to have `docker` installed and the `isard-vdi/isard` and `isard-vdi/isard-dev` directories forked. Then you need to run:
```sh
git clone https://github.com/isard-vdi/isard-dev
cd isard-dev
cp env.example .env
```

Now you have to modify the `.env` file to match your GitHub user and settings. Afterwards, you only need to run
```sh
./dev.sh
```

## Contributing

Isard Dev is a [Guix](https://guix.gnu.org/) system. The system definition is at `isard.scm`. If you want to modify / improve the development environment, you need to make the changes and run `guix system docker-image isard.scm` afterwards. This will generate a docker image. You need to `docker load < /path/to/image.tar.gz`, which will create a image with the name of `guix:latest`.

You can also run `guix system vm-image isard.scm` to generate a QEMU-KVM compatible `qcow2` disk
