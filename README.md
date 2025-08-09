# dotfiles-linux

Create and bootstrap the VM

```sh
orb create arch arch && orb -m arch ./init-vm.sh
```

Copy ghostty terminfo

```sh
infocmp -x xterm-ghostty | ssh orb -- tic -x -
```