# Temporarily change options.
'builtin' 'local' '-a' 'p10k_config_opts'
[[ ! -o 'aliases'         ]] || p10k_config_opts+=('aliases')
[[ ! -o 'sh_glob'         ]] || p10k_config_opts+=('sh_glob')
[[ ! -o 'no_brace_expand' ]] || p10k_config_opts+=('no_brace_expand')
'builtin' 'setopt' 'no_aliases' 'no_sh_glob' 'brace_expand'

() {
  emulate -L zsh
  setopt no_unset

  autoload -Uz is-at-least && is-at-least 5.1 || return

  # Unset all configuration options.
  unset -m 'POWERLEVEL9K_*'

  # Left prompt segments.
  typeset -g POWERLEVEL9K_LEFT_PROMPT_ELEMENTS=(
      lambda                    # lambda symbol
      dir                       # current directory
      vcs                       # git status
      newline                   # \n
      prompt_char               # prompt symbol
  )

  # Right prompt segments.
  typeset -g POWERLEVEL9K_RIGHT_PROMPT_ELEMENTS=(
      status                    # exit code of the last command
      command_execution_time    # previous command duration
      newline                   # \n
      context                   # user@host
	)

  # Basic style options that define the overall prompt look.
  typeset -g POWERLEVEL9K_BACKGROUND=                            # transparent background
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_{LEFT,RIGHT}_WHITESPACE=  # no surrounding whitespace
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SUBSEGMENT_SEPARATOR=' '  # separate segments with a space
  typeset -g POWERLEVEL9K_{LEFT,RIGHT}_SEGMENT_SEPARATOR=        # no end-of-line symbol
  typeset -g POWERLEVEL9K_VISUAL_IDENTIFIER_EXPANSION=           # no segment icons

  # Add an empty line before each prompt except the first. This doesn't emulate the bug
  # in Pure that makes prompt drift down whenever you use the ALT-C binding from fzf or similar.
  typeset -g POWERLEVEL9K_PROMPT_ADD_NEWLINE=true

  # Magenta prompt symbol if the last command succeeded.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OK_{VIINS,VICMD,VIVIS}_FOREGROUND=green
  # Red prompt symbol if the last command failed.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_ERROR_{VIINS,VICMD,VIVIS}_FOREGROUND=red
  # Default prompt symbol.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIINS_CONTENT_EXPANSION='❯'
  # Prompt symbol in command vi mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VICMD_CONTENT_EXPANSION='❮'
  # Prompt symbol in visual vi mode is the same as in command mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_{OK,ERROR}_VIVIS_CONTENT_EXPANSION='V'
  # Prompt symbol in overwrite vi mode is the same as in command mode.
  typeset -g POWERLEVEL9K_PROMPT_CHAR_OVERWRITE_STATE=false

  # Blue current directory.
  typeset -g POWERLEVEL9K_DIR_FOREGROUND=blue

  # Context format when root: user@host. The first part white, the rest grey.
  typeset -g POWERLEVEL9K_CONTEXT_ROOT_TEMPLATE='%7F%n%f%242F@%m%f'
  # Context format when not root: user@host. The whole thing grey.
  typeset -g POWERLEVEL9K_CONTEXT_TEMPLATE='%242F%n@%m%f'
  # Don't show context unless root or in SSH.
  typeset -g POWERLEVEL9K_CONTEXT_{DEFAULT,SUDO}_CONTENT_EXPANSION=

  # Show previous command duration only if it's >= 5s.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_THRESHOLD=5
  # Don't show fractional seconds. Thus, 7s rather than 7.3s.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_PRECISION=0
  # Duration format: 1d 2h 3m 4s.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FORMAT='d h m s'
  # Yellow previous command duration.
  typeset -g POWERLEVEL9K_COMMAND_EXECUTION_TIME_FOREGROUND=yellow

  # Grey Git prompt. This makes stale prompts indistinguishable from up-to-date ones.
  typeset -g POWERLEVEL9K_VCS_FOREGROUND=242

  # Disable async loading indicator to make directories that aren't Git repositories
  # indistinguishable from large Git repositories without known state.
  typeset -g POWERLEVEL9K_VCS_LOADING_TEXT=

  # Don't wait for Git status even for a millisecond, so that prompt always updates
  # asynchronously when Git state changes.
  typeset -g POWERLEVEL9K_VCS_MAX_SYNC_LATENCY_SECONDS=0

  # Cyan ahead/behind arrows.
  typeset -g POWERLEVEL9K_VCS_{INCOMING,OUTGOING}_CHANGESFORMAT_FOREGROUND=cyan
  # Don't show remote branch, current tag or stashes.
  typeset -g POWERLEVEL9K_VCS_GIT_HOOKS=(vcs-detect-changes git-untracked git-aheadbehind)
  # Don't show the branch icon.
  typeset -g POWERLEVEL9K_VCS_BRANCH_ICON=
  # When in detached HEAD state, show @commit where branch normally goes.
  typeset -g POWERLEVEL9K_VCS_COMMIT_ICON='@'
  # Don't show staged, unstaged, untracked indicators.
  typeset -g POWERLEVEL9K_VCS_{STAGED,UNSTAGED,UNTRACKED}_ICON=$'\b'
  # Show '*' when there are staged, unstaged or untracked files.
  typeset -g POWERLEVEL9K_VCS_DIRTY_ICON='*'
  # Show '⇣' if local branch is behind remote.
  typeset -g POWERLEVEL9K_VCS_INCOMING_CHANGES_ICON='⇣'
  # Show '⇡' if local branch is ahead of remote.
  typeset -g POWERLEVEL9K_VCS_OUTGOING_CHANGES_ICON='⇡'
  # Don't show the number of commits next to the ahead/behind arrows.
  #typeset -g POWERLEVEL9K_VCS_{COMMITS_AHEAD,COMMITS_BEHIND}_MAX_NUM=1
  # Remove space between '⇣' and '⇡'.
  typeset -g POWERLEVEL9K_VCS_CONTENT_EXPANSION='${P9K_CONTENT/⇣* ⇡/⇣⇡}'

  ##########################[ status: exit code of the last command ]###########################
  # Enable OK_PIPE, ERROR_PIPE and ERROR_SIGNAL status states to allow us to enable, disable and
  # style them independently from the regular OK and ERROR state.
  typeset -g POWERLEVEL9K_STATUS_EXTENDED_STATES=true

  # Status when some part of a pipe command fails but the overall exit status is zero. It may look
  # like this: 1|0.
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE=true
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_VISUAL_IDENTIFIER_EXPANSION='✔'
  typeset -g POWERLEVEL9K_STATUS_OK_PIPE_FOREGROUND=green

  # Status when it's just an error code (e.g., '1'). No need to show it if prompt_char is enabled as
  # it will signify error by turning red.
	# PIPE
  # Status when some part of a pipe command fails and the overall exit status is also non-zero.
  # It may look like this: 1|0.
  typeset -g POWERLEVEL9K_STATUS_ERROR{,_PIPE}=true
  typeset -g POWERLEVEL9K_STATUS_ERROR{,_PIPE}_VISUAL_IDENTIFIER_EXPANSION='✘'
  typeset -g POWERLEVEL9K_STATUS_ERROR{,_PIPE}_FOREGROUND=red

  # Status when the last command was terminated by a signal.
  typeset -g POWERLEVEL9K_STATUS_ERROR_SIGNAL=false
  typeset -g POWERLEVEL9K_STATUS_VERBOSE_SIGNAME=false

  #######################[ lambda: Show lambdasymbol ]#######################
  typeset -g POWERLEVEL9K_LAMBDA_ICON=λ
  typeset -g _POWERLEVEL9K_LAMBDA_ICON=$POWERLEVEL9K_LAMBDA_ICON # Instant prompt

  function prompt_lambda() {
    local color=yellow
    if [ $(jobs | grep . -c) -eq 0 ]; then
      color=blue
    fi
    p10k segment -f $color -t $POWERLEVEL9K_LAMBDA_ICON
  }
  function instant_prompt_lambda() {
    # No background jobs with instant prompt
    p10k segment -f blue -t $_POWERLEVEL9K_LAMBDA_ICON
  }

  # Transient prompt works similarly to the builtin transient_rprompt option. It trims down prompt
  # when accepting a command line. Supported values:
  #
  #   - off:      Don't change prompt when accepting a command line.
  #   - always:   Trim down prompt when accepting a command line.
  #   - same-dir: Trim down prompt when accepting a command line unless this is the first command
  #               typed after changing current working directory.
  typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir

  # Instant prompt mode.
  #
  #   - off:     Disable instant prompt. Choose this if you've tried instant prompt and found
  #              it incompatible with your zsh configuration files.
  #   - quiet:   Enable instant prompt and don't print warnings when detecting console output
  #              during zsh initialization. Choose this if you've read and understood
  #              https://github.com/romkatv/powerlevel10k/blob/master/README.md#instant-prompt.
  #   - verbose: Enable instant prompt and print a warning when detecting console output during
  #              zsh initialization. Choose this if you've never tried instant prompt, haven't
  #              seen the warning, or if you are unsure what this all means.
  typeset -g POWERLEVEL9K_INSTANT_PROMPT=quiet

  # Hot reload allows you to change POWERLEVEL9K options after Powerlevel10k has been initialized.
  # For example, you can type POWERLEVEL9K_BACKGROUND=red and see your prompt turn red. Hot reload
  # can slow down prompt by 1-2 milliseconds, so it's better to keep it turned off unless you
  # really need it.
  typeset -g POWERLEVEL9K_DISABLE_HOT_RELOAD=true

  # If p10k is already loaded, reload configuration.
  # This works even with POWERLEVEL9K_DISABLE_HOT_RELOAD=true.
  (( ! $+functions[p10k] )) || p10k reload
}

(( ${#p10k_config_opts} )) && setopt ${p10k_config_opts[@]}
'builtin' 'unset' 'p10k_config_opts'
