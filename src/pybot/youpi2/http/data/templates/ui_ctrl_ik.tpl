%include("ui_prolog.tpl", title="Youpi 2")

<div class="page-header"><h1>Contrôle par cinématique inverse</h1></div>

<p>La cinématique inverse consiste à déterminer les angles que les articulations doivent
    prendre afin que l'effecteur (ici la pince) soit positionnée aux coordonnées demandées.</p>

<p> Outre la position dans l'espace de la pince via ses 3 coordonnées cartésiennes X, Y et Z, son
    orientation par rapport à l'horizontale fait également partie des contraintes.</p>

<p> Selon les valeurs de ces 4 paramètres, il se peut qu'aucune solution n'existe, soit parce que
    la position demandée est hors d'atteinte, soit parce qu'elle nécessite que certaines des articulations
    prennent des positions hors de leurs limites mécaniques.</p>

%include("epilog.tpl", version=version)
