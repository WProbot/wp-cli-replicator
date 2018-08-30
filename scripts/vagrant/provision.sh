#!/usr/bin/env bash

set -e

# Map binary name to source URL.
REPOS=(
	"docker-compose,https://github.com/docker/compose/releases/download/1.22.0/docker-compose-`uname -s`-`uname -m`"
)

# Add Docker repo.
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update
sudo apt-get install -y \
	docker-ce avahi-daemon

# Install various binary scripts.
for repo_set in "${REPOS[@]}"; do
	while IFS=',' read -ra repo; do
		dest_path="/usr/local/bin/${repo[0]}"

		if [ ! -f "$dest_path" ]; then
			echo "Installing ${repo[1]} to $dest_path"

			sudo curl -sL "${repo[1]}" -o "$dest_path"
			sudo chmod +x "$dest_path"
		fi
	done <<< "$repo_set"
done