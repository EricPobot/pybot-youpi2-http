from pybot.fabtasks import *
from fabric.state import output

output.output = False


@task(alias="restart-srvr")
def restart_http_doc():
    sudo('systemctl restart youpi2-http-doc.service')
