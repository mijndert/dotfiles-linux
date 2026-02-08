# dotfiles-linux

My dotfiles for Linux using [OrbStack](https://orbstack.dev) and [Arch Linux](https://archlinux.org).

Create and bootstrap the VM replacing the username with your own:

```sh
orb create -u mijndert arch arch && orb -m arch ./init-vm.sh
```

Optional: Copy ghostty terminfo:

```sh
infocmp -x xterm-ghostty | ssh orb -- tic -x -
```

Shell into the VM:

```sh
ssh orb
```
