REM prepare the environment

echo Preparing the environment ...

if not exist volumes (
    mkdir volumes
)

cd volumes

if not exist poc-mini-fileserver (
    mkdir poc-mini-fileserver
    cd poc-mini-fileserver

    echo Clone poc-mini-fileserver from github...

    git clone https://github.com/vatoer/poc-mini-fileserver.git .
)


if not exist legacy-edispo (
    mkdir legacy-edispo
    cd legacy-edispo

    echo Clone legacy-edispo from github...

    git clone https://github.com/vatoer/legacy-edispo.git .
)

if not exist eoffice-perwakilan (
    mkdir eoffice-perwakilan
    cd eoffice-perwakilan

    echo Clone eoffice-perwakilan from github...

    git clone https://github.com/vatoer/eoffice-perwakilan.git .
)









