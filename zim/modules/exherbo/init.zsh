DIST='/var/cache/paludis/distfiles'
PBIN='/var/cache/paludis/pbin'
SCM='/var/cache/paludis/distfiles/scm'
EX='/var/db/paludis/repositories'
PCONF="$HOME/dev/exherbo/paludis-config"
PBUILD='/var/tmp/paludis/build'
PLOG='/var/log/paludis'

alias exmask="$EDITOR $PCONF/package_mask.conf"
alias exunmask="$EDITOR $PCONF/package_unmask.conf"
alias exsug="$EDITOR $PCONF/suggestions.conf"
alias extest="$EDITOR $PCONF/test.conf"
alias exjobs="$EDITOR $PCONF/jobs.conf"
alias exzzz="$EDITOR $PCONF/zzz.conf"
alias exopts="$EDITOR $PCONF/options.conf"

alias cs="cave search --index /var/cache/paludis/search-index"
alias co='cave owner'
alias ct='cave contents'
alias cw='cave show'
alias cwc='cave show -c'
alias cy='sudo cave sync'
alias crs="sudo cave resolve"
alias crb="crs --via-binary '*/*'"
alias cr="crb --promote-binaries if-same"
alias crmb="crs -mb"
alias cu='sudo cave uninstall'
alias cuu="sudo cave uninstall --purge '*/*'"
alias crz="cr --resume-file /var/tmp/paludis/resume"
alias cz="sudo cave resume --resume-file /var/tmp/paludis/resume -R -r -Ci"
alias czz="cz +r"
alias crw='crz world -ks -Ci -B'
alias crwc='crw -c'
alias crwe='crw -e'
alias crx='cr -x'
alias crx1='crx -1'
alias crwx='crw -x'
alias crwcx='crwc -x'
alias crwcx='crwe -x'
alias czw='cz -Ci'
alias czzw='czz -Ci'
alias crd="cr -1 -d '*/*'"
alias crdep='cr nothing --reinstall-dependents-of'
#alias cr2='crs -Ma -mc -2 /mnt/cubie -4 armv7-unknown-linux-musleabihf'

alias crm="sudo cave -E :cubie resolve"
alias crmp="crm --via-binary '*/*' --promote-binaries if-same"
alias cr2="crmp -Ma -mc -2 /mnt/cubie -4 armv7-unknown-linux-musleabihf"

alias cr6="sudo cave -E :i686 resolve"

alias ecfgi='sudo eclectic config interactive'
alias exconf='sudo eclectic config interactive'
alias exnews='sudo eclectic news read new'

alias examend='git add -A . && git commit --amend --no-edit && exlocal'
alias expush='git push sandbox'

exdist() {
  for file in $@; do
    sudo mv $file $DIST
    sudo chmod 644 $DIST/$file
    sudo chown paludisbuild:paludisbuild $DIST/$file
  done
}

git-exdist() {
  set -e
  for repo in "$@"; do
    local from=$repo
    # to=$2
    local dir=$(basename $from)
    local to=$SCM/$dir

    sudo git clone --bare $from $to
    local url=$(cd $from; git config remote.origin.url)
    $(cd $to; sudo git config remote.origin.url $url; \
      sudo touch .scm.exlib.timestamp; \
      ref=$(git symbolic-ref HEAD)
      sudo git fetch -u origin $ref:$ref; sudo chown -R paludisbuild:paludisbuild .)
    mv $from $HOME/dev/cellar/git
  done
}

psu() {
  [[ -n $1 ]] && cd $SCM/$1
  sudo su paludisbuild
}

exlocal() {
  local repo=$1
  if [[ ! -n $repo ]] ; then
    local dir=$(git rev-parse --show-toplevel 2>/dev/null)
    if [[ -n $dir ]] ; then
      repo=$(basename $dir)
    else
      # fallback to my personal repo
      repo=medvid
    fi
  fi
  cy $repo --source local --revision $(git rev-parse HEAD)
}

exlog() {
  pushd $PLOG
  less $(ls | grep "$1" | tail -1)
  popd
}

exrepo() {
  cave show "*/*::$1"
}
_exrepo () {
  ((CURRENT == 2)) && _files -/ -W $EX/e
}
#compdef _exrepo exrepo

exrepos() {
  cat $EX/exndbam/$1/data/*/*/REPOSITORY  | sort -u
}

exlocal-infect() {
  [[ -n $1 ]] && pushd $1

  local dir=$(git rev-parse --show-toplevel)

  if [[ -n $dir ]] ; then
    local repo=$(basename $dir)
    git config remote.local.url >/dev/null && git remote -v remove local
    git config remote.sandbox.url >/dev/null && git remote -v remove sandbox
    git config remote.origin.url >/dev/null && git remote -v remove origin

    local origin=$(cd $EX/e/$repo && git config remote.origin.url)
    [[ -n $origin ]] || { echo "Cannot determine origin URL"; return 1; }
    local baseurl=$(dirname $(dirname $origin))
    local sandbox=${baseurl/git.exherbo.org/gitlab.exherbo.org}/medvid/$repo

    git remote -v add origin $origin
    git remote -v add local $EX/e/$repo
    git remote -v add sandbox $sandbox

    git remote -v
    git fetch -v origin
    git fetch -v local
    git branch --set-upstream-to=origin/master master
    git merge --ff-only origin/master
  fi

  [[ -n $1 ]] && popd
  return 0
}

exclone() {
  local repo=$1
  git clone $EX/e/$repo ~/dev/exherbo/$repo
  cd ~/dev/exherbo/$repo
  exlocal-infect
}
#compdef _exrepo exclone

# TODO: function to run setup + compile
# crs chromium-stable -x1 --skip-phase killold --skip-phase initmisc --skip-phase fetch_extra --skip-phase tidyup --skip-phase unpack --skip-phase prepare --skip-phase configure --skip-phase init

exlist() {
  repo=$1
  for exheres in $(find $EX/exndbam/$repo/ -name "*.pbin-1+exheres-0");
  do
    source $exheres
    pnv=${exheres##*/}
    date=$(date +'%Y-%m-%d-%H:%M:%S' -d @${GENERATED_TIME})
    echo ${date} ${pnv%.*}:${SLOT}
  done | sort
}
_exlist () {
  ((CURRENT == 2)) && _files -/ -W $EX/exndbam
}
#compdef _exlist exlist

exgcc() {
  sudo eclectic cc set gcc
  sudo eclectic c++ set gcc
  sudo eclectic cpp set gcc
}
exclang() {
  sudo eclectic cc set clang
  sudo eclectic c++ set clang
  sudo eclectic cpp set clang
}
exgold() {
  sudo eclectic ld set gold
}
exlld() {
  sudo eclectic ld set lld
}
