#
#file: skeleton.sh
#date: mardi 24 septembre 2013, 11:32:03 (UTC+0200)
#author: cfoyer <cfoyer@enseirb-matmeca.fr>
#description: Create the skeleton of TeX or bash file.
#

#!/bin/bash

usage(){
    echo "Usage : $0 type name"
    echo "type=bash|tex|c|h"
}

#deux paramètres : 
#    $1 : nom du fichier
#    $2 : mise en commentaire
print_header(){
    echo -e "$2file: $1\n$2date: `date`\n$2author: $USER <$MAIL>\n$2description:" >> $1
}

#un parametre :
#     $1 : nom du fichier a creer
create_bash(){
    file_name="$1.sh"
    echo -e '#' > $file_name
    print_header $file_name '#'
    echo -e '#\n' >> $file_name
    echo -e '#!/bin/bash\n'>> $file_name
    echo -e 'usage(){\n\techo "Usage: $0 ..."\n}\n' >> $file_name
    echo -e 'if [ $# -ne ... ]\nthen\n\tusage\n\texit 1\nfi\n\n' >> $file_name
}

#un parametre :
#     $1 : nom du fichier a creer
create_tex(){
    file_name="$1.tex"
    echo -e '%' > $file_name
    print_header $file_name '%'
    echo -e '%\n' >> $file_name
    echo -e "\\documentclass{article}\n%\\usepackage{}\n\n\\\begin{document}\n\n\\\\end{document}" >> $file_name
}

#un parametre :
#     $1 : nom du fichier a creer
create_c(){
    file_name="$1.c"
    echo -e '/*' > $file_name
    print_header $file_name ' * '
    echo -e ' */\n' >> $file_name
    echo -e "/*********************************************************************/\n/*         PREPROCESSOR                                              */\n/*********************************************************************/\n\n/*********************************************************************/\n\n#include <stdlib.h>\n#include <stdio.h>\n\n/*********************************************************************/\n\n/*********************************************************************/\n/*         DEFINITIONS DES TYPES                                     */\n/*********************************************************************/\n\n/*********************************************************************/\n\n\n\n/*********************************************************************/\n\n/*********************************************************************/\n/*         FUNCTIONS                                                 */\n/*********************************************************************/\n\n/*********************************************************************/\n\n\n\n/*********************************************************************/\n" >> $file_name
}

#un parametre :
#     $1 : nom du fichier a creer
create_h(){
    file_name="$1.h"
    verrou="_`echo $file_name | tr [a-z] [A-Z] | tr . _ | tr - _`_"
    echo -e '/*' > $file_name
    print_header $file_name ' * '
    echo -e ' */\n' >> $file_name
    echo -e "#ifndef $verrou \n#define $verrou\n" >> $file_name
    echo -e '#ifdef __cplusplus\nextern "C" {\n#endif\n' >> $file_name
    echo -e "\n/*********************************************************************/\n/*         INCLUDES                                                  */\n/*********************************************************************/\n\n/*********************************************************************/\n\n#include <stdlib.h>\n\n/*********************************************************************/\n\n/*********************************************************************/\n/*         TYPES                                                     */\n/*********************************************************************/\n\n/*********************************************************************/\n\n\n\n/*********************************************************************/\n\n/*********************************************************************/\n/*         PROTOTYPES                                                */\n/*********************************************************************/\n\n/*********************************************************************/\n\n\n\n/*********************************************************************/\n">> $file_name
    echo -e "#ifdef __cplusplus\n}\n#endif\n\n#endif /* $verrou */\n" >> $file_name
}

##################################################################
#    Coeur du script

if [ $# -ne 2 ]
then
    usage
    exit 1
fi

case $1 in
    "tex")
	create_tex $2
	;;
    "bash")
	create_bash $2
	;;
    "c")
	create_c $2
	;;
    "h")
	create_h $2
	;;
    *)
	usage
	exit 1 
	;;
esac