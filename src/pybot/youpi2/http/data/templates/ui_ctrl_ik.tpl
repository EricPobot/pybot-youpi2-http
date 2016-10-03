%include("ui_prolog.tpl", title="Youpi 2")

<div class="page-header"><h1>Contrôle par cinématique inverse</h1></div>

<p>La cinématique inverse consiste à déterminer les angles que les articulations doivent
    prendre afin que l'effecteur (ici la pince) soit positionnée aux coordonnées demandées.</p>

<p> Outre la position dans l'espace de la pince via ses 3 coordonnées cartésiennes X, Y et Z, son
    orientation par rapport à l'horizontale fait également partie des contraintes.</p>

<p> Selon les valeurs de ces 4 paramètres, il se peut qu'aucune solution n'existe, soit parce que
    la position demandée est hors d'atteinte, soit parce qu'elle nécessite que certaines des articulations
    prennent des positions hors de leurs limites mécaniques.</p>

<form id="form_ik" class="form-horizontal" action="/api/v1/ik?" method="PUT">
    <div class="row">
        <div class="col-sm-8 col-sm-offset-2">
            <fieldset>
                <legend>Position et orientation</legend>
                <div class="col-sm-8">
                    <div class="form-group">
                        <label for="x" class="col-sm-6 control-label">Coordonnée X</label>
                        <div class="col-sm-4">
                            <input type="number" min="-100" max="100"
                                   value="0"
                                   class="form-control" id="x"
                                   placeholder="Entrez une coordonnée">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="y" class="col-sm-6 control-label">Coordonnée Y</label>
                        <div class="col-sm-4">
                            <input type="number" min="0" max="100"
                                   value="0"
                                   class="form-control" id="y"
                                   placeholder="Entrez une coordonnée">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="z" class="col-sm-6 control-label">Coordonnée Z</label>
                        <div class="col-sm-4">
                            <input type="number" min="10" max="200"
                                   value="0"
                                   class="form-control" id="z"
                                   placeholder="Entrez une coordonnée">
                        </div>
                    </div>
                    <div class="form-group">
                        <label for="pitch" class="col-sm-6 control-label">Orientation</label>
                        <div class="col-sm-4">
                            <input type="number" min="-90" max="90"
                                   value="0"
                                   class="form-control" id="pitch"
                                   placeholder="Entrez un angle">
                        </div>
                    </div>
                </div>
                <div class="col-sm-4">
                    <button type="submit" class="btn btn-success btn-block">Envoyer</button>
                    <button type="reset" class="btn btn-default btn-block">Remise à zéro</button>
                </div>
            </fieldset>
        </div>
    </div>
</form>


%include("form_gripper.tpl")
%include("epilog.tpl", version=version)
