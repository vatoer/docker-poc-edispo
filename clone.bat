REM prepare the environment

echo Preparing the environment ...

if not exist volumes (
    mkdir volumes
)

cd volumes

if not exist poc-mini-fileserver (
   
    echo Clone poc-mini-fileserver from github...

    git clone https://github.com/vatoer/poc-mini-fileserver.git .
)


if not exist legacy-edispo (
    
    echo Clone legacy-edispo from github...

    git clone https://github.com/vatoer/legacy-edispo.git .
)

if not exist eoffice-perwakilan (
    

    echo Clone eoffice-perwakilan from github...

    git clone https://github.com/vatoer/eoffice-perwakilan.git .
) else (
    cd eoffice-perwakilan

    echo Pulling latest changes for eoffice-perwakilan from github...

    git pull
)









