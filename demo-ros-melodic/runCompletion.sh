#/usr/bin/env bash
_run_completions()
{
  if [ "${#COMP_WORDS[@]}" != "2" ]; then
    return
  fi

  for i in $(docker ps -a --format "{{.Names}}") 
  do
      # COMPREPLY+=("$i")
      COMPREPLY+=($(compgen -W ${i} "${COMP_WORDS[1]}"))
  done

}

complete -F _run_completions dockrun
