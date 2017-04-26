function toggl_current
  toggl --cache -csv current | read -z current
  echo $current | grep 'Project' | cut -d ',' -f2 | read task_project
  echo $current | grep 'Description' | cut -d ',' -f2 | cut -c 1-20 | read task_desc
  echo $current | grep 'Duration' | cut -d ',' -f2 | read task_duration
  echo "[$task_duration]$task_project $task_desc"
end
