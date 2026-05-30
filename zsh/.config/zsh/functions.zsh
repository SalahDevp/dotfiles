__ask_claude() {
  local model="$1"
  shift
  local prompt="$*"

  if [ ! -t 0 ]; then
    local piped
    piped=$(cat)
    if [ -n "$prompt" ]; then
      prompt="$piped

$prompt"
    else
      prompt="$piped"
    fi
  fi

  local system_prompt="You are a terminal assistant for a developer. Answer concisely and directly.

Rules:
- No preamble and no sign-off
- Plain text output — this is a terminal, markdown headers and bold won't render
- Use code blocks for code/commands; keep prose tight
- For factual/conceptual questions: 2-4 sentences unless depth is genuinely needed
- For code questions: lead with the solution, explain only what's non-obvious
- When given piped input (file content, command output, diffs, logs), treat it as context for the question that follows
- Assume a senior developer audience — skip basics, use precise technical terms"

  claude -p "$prompt" --model "$model" --allowedTools "Read,WebSearch,WebFetch" --system-prompt "$system_prompt"
}

alias '??'='noglob __ask_claude claude-haiku-4-5-20251001'
alias '???'='noglob __ask_claude claude-sonnet-4-6'
