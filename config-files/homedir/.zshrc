# Attention ! alias doit toujours être sourcé après misc parce que aliases a besoin de la définition de la complétion
# Misc doit être placé en premier parce d'autres fichiers on besoin de lui pour être chargés


username="saponace"

COMMONPATH="/home/$username/.zsh"


source $COMMONPATH/misc
source $COMMONPATH/misc-functions
source $COMMONPATH/aliases
source $COMMONPATH/prompt

eval $( dircolors -b "$COMMONPATH/ls-colors" )