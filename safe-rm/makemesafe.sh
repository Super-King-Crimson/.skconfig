#!/bin/bash
# 1. Permission Check (Must be root to write to /usr/local/sbin and other users' home dirs)
if [[ $EUID -ne 0 ]]; then
   echo "safeme: Permission denied"
   exit 1
fi

# 2. Define the payload
SAFE_RM_SOURCE="./safe-rm"
ALIAS_BLOCK="# --- SAFEME ALIASES ---
alias rm='/usr/local/sbin/safe-rm'
alias sudo='sudo '
# ----------------------"

# 3. Install the binaries
echo "Installing binaries to /usr/local/sbin..."
if [[ -f "$SAFE_RM_SOURCE" ]]; then
    cp "$SAFE_RM_SOURCE" /usr/local/sbin/safe-rm
    chmod 755 /usr/local/sbin/safe-rm
else
    echo "Error: $SAFE_RM_SOURCE not found in current directory."
    exit 1
fi

# Create amisafe on the fly
cat <<EOF > /usr/local/sbin/amisafe
#!/bin/bash
echo "you are safe"
EOF
chmod 755 /usr/local/sbin/amisafe

# 4. Function to safely append aliases
append_if_missing() {
    local target_file="$1"
    if [[ -f "$target_file" ]]; then
        # Check if the rm alias is already there to avoid duplicates
        if ! grep -q "alias rm='/usr/local/sbin/safe-rm'" "$target_file"; then
            echo -e "\n$ALIAS_BLOCK" >> "$target_file"
            echo "Updated: $target_file"
        else
            echo "Skipped: $target_file (Aliases already present)"
        fi
    fi
}

# 5. Target the Skeleton (For future users)
append_if_missing "/etc/skel/.bashrc"

# 6. Target Root
append_if_missing "/root/.bashrc"

# 7. Target Global config (For sudo and existing users)
# On most distros /etc/bash.bashrc or /etc/bashrc is loaded globally
if [[ -f "/etc/bash.bashrc" ]]; then
    append_if_missing "/etc/bash.bashrc"
elif [[ -f "/etc/bashrc" ]]; then
    append_if_missing "/etc/bashrc"
fi

# 8. Target all existing human users
# Loops through all home directories in /home
for user_dir in /home/*; do
    if [[ -d "$user_dir" ]]; then
        append_if_missing "$user_dir/.bashrc"
        # Ensure the user still owns their .bashrc after root appends to it
        chown --reference="$user_dir" "$user_dir/.bashrc" 2>/dev/null
    fi
done

echo "Installation complete. Run 'amisafe' to verify."
