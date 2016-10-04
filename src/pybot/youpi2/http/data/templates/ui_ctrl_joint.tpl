%include("ui_prolog.tpl", title="Youpi 2")

<div class="page-header"><h1>Contrôle direct des articulations</h1></div>

<div class="well">
    <p>Le contrôle direct des articulation prend en compte le couplage mécanique entre les
        articulations, introduit par le principe de la transmission des mouvements pas courroie.</p>
    <p>
        Le logicel de contrôle tient compte du couplage mécanique qui existe éventuellement entre les
        articulations pour appliquer les rotations correspondantes aux autres moterus concernés
        afin que les angles des articulations correspondent à la consigne à la fin de la commande.
    </p>
</div>

%include("form_motion.tpl", action="/api/v1/pose?", legend="Position des articulations")
%include("form_gripper.tpl")
%include("epilog.tpl", version=version, ui_app=True)
