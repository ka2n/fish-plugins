function todoist_to_toggl
  todoist --project-namespace --namespace list | peco | cut -d ' ' -f 1 | read item_id
  if [ ! -n "$item_id" ]
    return 0
  end
  todoist --csv show $item_id | read item
  todoist --csv show $item_id | grep 'Project' | cut -d',' -f2 | cut -d':' -f1 | sed 's/^#//' | read project_name
  todoist --csv show $item_id | grep 'Content' | cut -d',' -f2- |  sed s/\"//g | read task_content
  toggl --cache projects | grep $project_name | cut -d ' ' -f 1 | read toggl_project_id
  if [ -n "$toggl_project_id" ]
    toggl start -P $toggl_project_id "$task_content"
  else
    toggl start "#$project_name: $task_content"
  end
  commandline -f repaint
end
