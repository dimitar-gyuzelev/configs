# pyenv config
export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"
export PIPENV_PYTHON="$PYENV_ROOT/shims/python"

plugin=(
  pyenv
)

# setting up pyenv
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

# load github ssh key; silent
ssh-add --apple-use-keychain ~/.ssh/id_ed25519 &> /dev/null

# customisations
export PROMPT=" > "

# nvim config
export NVM_DIR="$HOME/.nvm"
  [ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"
  [ -s "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm" ] && \. "/opt/homebrew/opt/nvm/etc/bash_completion.d/nvm"

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

test -e "${HOME}/.iterm2_shell_integration.zsh" && source "${HOME}/.iterm2_shell_integration.zsh"

if [ "$TERM_PROGRAM" != "Apple_Terminal" ]; then
  eval "$(oh-my-posh init zsh --config ~/.config/oh-my-posh/simple.json)"
fi

# -------------------------
# | Convenience Functions |
# -------------------------

function cd() {
  # -------------------------------------------------------------------------
  # DOCS:
  # - automatically activates a python venv if one exists in the destination
  # - automatically deactivates a python venv if the parent directory is left
  # - handles sub-folders
  # -------------------------------------------------------------------------

  # Store the current directory and active venv before changing
  local prev_dir="$PWD"
  local prev_venv="$VIRTUAL_ENV"

  # Actually change directory
  builtin cd "$@"

  # Get the new directory
  local new_dir="$PWD"

  # First handle potential deactivation
  if [[ -n "$prev_venv" ]]; then
    # Extract the project directory that contains the venv
    local venv_name=$(basename "$prev_venv")
    local venv_project_dir=$(dirname "$prev_venv")

    # If we've moved out of the venv project directory, deactivate
    if [[ "$new_dir" != "$venv_project_dir"* ]] || [[ "$new_dir" == "$venv_project_dir" && "$venv_name" == ".venv" ]]; then
      deactivate
    fi
  fi

  # Now handle potential activation in the new directory
  if [[ -d ./.venv && -f ./.venv/bin/activate ]]; then
    # Only activate if we're not already in this venv
    if [[ "$VIRTUAL_ENV" != "$PWD/.venv" ]]; then
      # Deactivate any existing venv first if we still have one active
      if [[ -n "$VIRTUAL_ENV" ]]; then
        deactivate
      fi
      source ./.venv/bin/activate
    fi
  fi
}