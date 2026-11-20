#!/usr/bin/env bash
# Runs once when a learner's codespace is first created.
set -euo pipefail

echo "==> Installing the Microsoft SQL Server driver and command-line tools"
sudo apt-get update -y
sudo apt-get install -y curl gnupg
DEBIAN_VERSION=$(. /etc/os-release && echo "$VERSION_ID")
curl -sSL -o /tmp/packages-microsoft-prod.deb \
  "https://packages.microsoft.com/config/debian/${DEBIAN_VERSION}/packages-microsoft-prod.deb"
sudo dpkg -i /tmp/packages-microsoft-prod.deb
sudo apt-get update -y
sudo ACCEPT_EULA=Y apt-get install -y msodbcsql18 mssql-tools18 unixodbc-dev

# Make the "sqlcmd" command available in the terminal.
if ! grep -q "mssql-tools18" ~/.bashrc; then
  echo 'export PATH="$PATH:/opt/mssql-tools18/bin"' >> ~/.bashrc
fi

echo "==> Installing Python packages"
pip install --upgrade pip
pip install -r requirements.txt

echo "==> Loading the TrainingShop database"
python .devcontainer/load_database.py

echo "==> Setup complete. Open README.md to begin."
