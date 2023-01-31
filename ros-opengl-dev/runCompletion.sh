#/usr/bin/env bash
_run_completions()
{
  for i in $(docker ps -a --format "{{.Names}}") 
  do
      COMPREPLY+=("$i")
  done

}

complete -F _run_completions dockrun
