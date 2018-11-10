# RefranerServer (Bot)

## Dependencies

- Elixir
- Git
- GNU Make

## Quick run

    $ make run

## Install (systemd)

Move the code to /opt and set permissions:

    # cd ..
    # cp -R refraner_server /opt
    # chown -R www-data:www-data /opt/refraner_server

Install the systemd service and enable it to run at startup:

    # cp refraner_server/refraner_server.service.sample /etc/systemd/system/refraner_server.service
    # systemctl daemon-reload
    # systemctl enable refraner_server

NOTE: if you chose to deploy the code to another path or use another user/group,
update them in /etc/systemd/system/refraner_server.service after copying the template.

## Run (systemd)

After installing it, you can control the service via systemd:

    # systemctl start refraner_server
    # systemctl stop refraner_server
    # systemctl restart refraner_server

## Start on system startup (systemd)

    # systemctl enable refraner_server
