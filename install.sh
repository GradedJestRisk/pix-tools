#!/usr/bin/env bash

mkdir Pix && cd Pix

# Clone main repositories
mkdir repositories && cd repositories
git clone git@github.com:1024pix/pix.git && cd ..
git clone git@github.com:1024pix/pix-bot.git && cd ..
git clone git@github.com:1024pix/pix-db-replication.git && cd ..
git clone git@github.com:1024pix/pix-db-stats.git && cd ..
git clone git@github.com:1024pix/pix-dev-tools.git && cd ..
git clone git@github.com:1024pix/pix-dns.git && cd ..
git clone git@github.com:1024pix/pix-editor.git && cd ..
git clone git@github.com:1024pix/pix-engineering.git && cd ..
git clone git@github.com:1024pix/pix-infrastructure.git && cd ..
git clone git@github.com:1024pix/pix-lifestyle.git && cd ..
git clone git@github.com:1024pix/pix-review-router.git && cd ..
git clone git@github.com:1024pix/steampipe-checks.git && cd ..
