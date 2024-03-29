#!/bin/bash

PRE_COMMIT_FILE="$(dirname -- "${BASH_SOURCE[0]}")/../.git/hooks/pre-commit"

cat <<'EOF' >$PRE_COMMIT_FILE
#!/bin/bash

increment_version ()
{
  declare -a part=( ${1//\./ } )
  declare    new
  declare -i carry=1

  for (( CNTR=${#part[@]}-1; CNTR>=0; CNTR-=1 )); do
    len=${#part[CNTR]}
    new=$((part[CNTR]+carry))
    [ ${#new} -gt $len ] && carry=1 || carry=0
    [ $CNTR -gt 0 ] && part[CNTR]=${new: -len} || part[CNTR]=${new}
  done
  new="${part[*]}"
  echo -e "${new// /.}"
}

# directories containing potential secrets
DIRS="."

bold=$(tput bold)
normal=$(tput sgr0)

# allow to read user input, assigns stdin to keyboard
exec </dev/tty

# Grist checks
cd charts/grist
SHA_ORIGIN=$(md5sum README.md)
./update_readme.sh
SHA=$(md5sum README.md)
if [[ "$SHA_ORIGIN" != "$SHA" ]];
then
  git add README.md
fi
if git diff --cached --name-status | awk '$1 != "D" { print $2 }'|grep charts/grist;
then
  if git diff --cached --name-status | awk '$1 != "D" { print $2 }'|grep charts/grist/Chart.yaml;
  then
    echo "looks like version was update"
    exit 0
  else
    current_version=$(cat Chart.yaml |awk '/version:/ {print $2}')
    new_version=$(increment_version $current_version)
    sed -i "s/${current_version}/${new_version}/g" Chart.yaml
    git add Chart.yaml
  fi
  cd ../../
fi

EOF

chmod +x $PRE_COMMIT_FILE
