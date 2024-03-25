#!/bin/bash

# Get the current directory
SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

# Create the update script
cat <<EOF > "$SCRIPT_DIR/update.sh"
#!/bin/bash

# Change directory to your project directory
cd $SCRIPT_DIR

# Fetch updates from the Git repository
git fetch origin

# Pull the latest changes
git pull origin master
EOF

# Make the update script executable
chmod +x "$SCRIPT_DIR/update.sh"

# Add a cron job to run the update script every hour
(crontab -l ; echo "0 * * * * $SCRIPT_DIR/update.sh") | crontab -
