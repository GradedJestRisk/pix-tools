# Installation

## Software
Install terminator / zsh / nvm. 

Note: if you're using another terminal (eg .`bash`) and are handling node versions by hand 
(no `nvm`), you'll need to make some changes in configuration files below.

## Scripts
Add the following code to `.zshrc`  

```shell
# Enable custom command interruption in terminator layout
# https://amir.rachum.com/blog/2015/11/28/terminator-multiple-custom-commands/
echo $INIT_CMD
if [ ! -z "$INIT_CMD" ]; then
    OLD_IFS=$IFS
    setopt shwordsplit
    IFS=';'
    for cmd in $INIT_CMD; do
        print -s "$cmd"  # add to history
        eval $cmd
    done
    unset INIT_CMD
    IFS=$OLD_IFS
fi
```

Copy `daily_restart.sh` on your filesystem, substituting <REPOSITORY_DIRECTORY>.

Copy `layout` section from `config` file in your terminator configuration in `~/.config/terminator/config`, 
substituting <REPOSITORY_DIRECTORY> and <SCRIPT_DIRECTORY>.

# Usage
Launch with `terminator -l mon-pix`

# Goal
Get a fresh and running environment each morning.

It will:
- stop application running on API port and all containers and volumes
- checkout and `pull dev` (but if unstaged chnages)
- start pix containers
- initialize database (sseds included)
- install and start API
- install and start mon-pix
