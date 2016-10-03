%include("ui_prolog.tpl", title="Youpi 2")

<div class="page-header"><h1>Contrôle direct des moteurs</h1></div>

<div class="well">
    <p>Le contrôle direct des moteurs ne prend pas en compte le couplage mécanique entre les
        articulations, introduit par le principe de la transmission des mouvements par courroie.
        Par conséquent, actionner un moteur entraînera la plupart du temps une modification de l'angle
        des articulations situées en aval du bras.</p>

    <p>Font exception à la règle le moteur de rotation de la base, qui est mécaniquement indépendant
        des autres, ainsi que celui de la pince, qui est porté par l'extrémité du bras
        et donc non influencé par la position des moteurs en amont.</p>
</div>

%include("form_motion.tpl", action="/api/v1/motors?", legend="Position des moteurs")
%include("form_gripper.tpl")
%include("epilog.tpl", version=version)
