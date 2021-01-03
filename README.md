## dotfiles

![Screenshot of dotfiles terminal](https://raw.githubusercontent.com/magus/dotfiles/master/dotfiles.png)

### Installation

```sh
curl https://raw.githubusercontent.com/magus/dotfiles/master/dotfiles | bash
```


### tricks

Find a where a configuration happens, e.g. `diff`

```sh
> zsh -ixc : 2>&1 | grep diff
...
+/usr/local/etc/grc.bashrc:7> alias 'diff=colourify diff'
```
