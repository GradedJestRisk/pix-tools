#!/usr/bin/zsh

#exit 0

# Colorize output
RED='\033[0;31m'
NO_COLOR='\033[0m'

# Add nvm support
source ~/.nvm/nvm.sh

# print command (debug)
# set -o xtrace

echo "check if port 3000 is already used"
if [[ $(lsof -t -i:3000 | wc -l) != 0 ]];
  then echo "stopping process running on port 3000";
       kill -9 "$(lsof -t -i:3000)";
  else echo "no process running on port 3000";
fi;

# Uncomment this if you want containers to be recreated
#echo "stopping containers"
#
#if [[ $(docker ps -q | wc -l) != 0 ]];
#  then echo "stopping running containers";
#       docker kill "$(docker ps --quiet)";
#  else echo "no running containers";
#fi;
#
#echo "removing stopped containers (if any)"
#docker container prune --force

echo "set working directory"
cd <REPOSITORY_DIRECTORY> || (echo "Repository directory cannot be found" && exit 1);

echo "checking for unstaged changes"
if [[ $(git diff-index HEAD --  | wc -l) != 0 ]];
  then echo -e "${RED}there are unstaged changes, aborting${NC}";
       exit 1;
  else echo "no unstaged changes";
fi;

echo "get latest development version"
git checkout dev || (echo "checkout dev would lose some work, aborting" && exit 1);
git pull

nvm use

echo "start pix containers"
docker-compose up --detach

echo "start router"
npm run domains:start

echo "install API"
cd api
npm install

until pg_isready -h localhost -p 5432 -U postgres -d pix
do
  echo "Database is not ready, next try in 5 s"
  sleep 5;
done

echo "initialize database schema"
npm run db:reset

echo "start API (watch mode)"
npm run start:watch

# do not print command
#set +o xtrace
