#!/bin/sh
set -x

script_path=$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)

ENV_PATH=$HOME/.vsts-env
date -u +"%FT%TZ"

if [ ! -f $ENV_PATH/bin/python ]; then
  $HELIX_PYTHONPATH -m virtualenv --no-site-packages $ENV_PATH
fi

if $ENV_PATH/bin/python -c "import azure.devops"; then
  echo "azure-devops module already available"
else
  sudo $ENV_PATH/bin/python -m pip install azure-devops==5.0.0b9
fi

if $ENV_PATH/bin/python -c "import future"; then
  echo "future module already available"
else
  sudo $ENV_PATH/bin/python -m pip install future==0.17.1
fi

date -u +"%FT%TZ"
$ENV_PATH/bin/python $script_path/run.py "$@"
date -u +"%FT%TZ"
