#!/bin/bash

# Get the current branch
BRANCH=$(git branch --show-current)

# If not in a Git repository, exit
if [ -z "$BRANCH" ]; then
    echo "Error: Not inside a Git repository!"
    exit 1
fi

# Define the past 30 days
DAYS=365

# Loop through the last 30 days
for i in $(seq 0 $DAYS); do
    # Generate a past date (compatible with macOS)
    DATE=$(date -v-"$i"d "+%Y-%m-%dT12:00:00")

    # Create or modify a file (change the file name if needed)
    echo "Commit on $DATE" > contribution.txt

    # Add the file to Git
    git add contribution.txt

    # Commit with backdated timestamps
    GIT_COMMITTER_DATE="$DATE" git commit -m "Backdated commit for $DATE" --date "$DATE"

    echo "Committed for $DATE"
done

# Push changes
git push origin $BRANCH --force

echo "✅ All commits pushed for the last $DAYS days!"
