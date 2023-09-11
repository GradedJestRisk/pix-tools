#!/usr/bin/env bash

# Bootstrap folders
mkdir Pix && cd Pix

# Clone main repositories
mkdir repositories && cd repositories
git clone git@github.com:1024pix/pix.git
git clone git@github.com:1024pix/pix-bot.git
git clone git@github.com:1024pix/pix-db-replication.git
git clone git@github.com:1024pix/pix-db-stats.git
git clone git@github.com:1024pix/pix-dev-tools.git
git clone git@github.com:1024pix/pix-dns.git
git clone git@github.com:1024pix/pix-editor.git
git clone git@github.com:1024pix/pix-engineering.git
git clone git@github.com:1024pix/pix-infrastructure.git
git clone git@github.com:1024pix/pix-lifestyle.git
git clone git@github.com:1024pix/pix-review-router.git
git clone git@github.com:1024pix/steampipe-checks.git
