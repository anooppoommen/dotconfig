# DOTCONFIG

dotconfig for all the things that matter

## Scripts 

### code.sh 
  Helper script that helps to run neovim from a specified folder.
  makes it easier to start up projects for work rather than having 
  to manually do the `cd` command inside of vim when launching projects.


## VIM 
**Ditching vim for nvim**

Keeping things as minimal as possible using a prebuilt config 
of neovim combined with a bunch of customizations to make it 
work. 

1. Install [nvchad](https://github.com/NvChad/NvChad)

** MAC only config **

2. Make sure iterm2 is installed everything else is garbabe  
  - 2.1 Map left option to `esc+`
  - 2.2 Install the `Fira code Nerd Font Regular` and set terminla font to it 
3. copy over the nvim folder to the `$HOME/.nvm/`
4. run `PackerInstall` command in nvim

## Alias 
A bunch of regular mapping that I use regularly on all systems

```{bash}

  alias c="$HOME/Projects/dotconfig/code.sh"
  alias cc="code"
  alias prjt="cd $HOME/Projects"
  alias jp='python3 -m json.tool'
  alias cwa='$HOME/Projects/connect-adb-wireless.sh'

  decode_proto(){ echo $1 | xxd -r -p | protoc --decode_raw; };
  decode_proto_gzip(){ echo $1 | xxd -r -p | gzip -d | protoc --decode_raw; };

  alias pd="decode_proto"
  alias pdz="decode_proto_gzip"

```
