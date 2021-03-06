# Git Add Regex
# Stage only files that match a regex pattern
function gar() {
    git status --short | awk '{print $2}' | grep -i "$1" | xargs git add
    git status --short
}

# Git add except matching
function ganr() {
    git status --short | awk '{print $2}' | grep -iv "$1" | xargs git add
    git status --short
}

# Git Prune
# Delete merged branches
function gpr() {
    current_branch=$(git symbolic-ref --short HEAD)
    branch=${1:-$current_branch}
    git branch | grep -iq "$branch"
    
    if [[ $? -ne 0 ]]; then
        echo 'That branch does not exist.'
        return 1
    fi

    echo '=================================='
    git branch --merged "$branch" | grep -iv "$branch\|master" | xargs git branch -d 2>/dev/null
    echo '=================================='
    git branch --merged "$branch"
}
