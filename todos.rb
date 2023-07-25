
todos = [
  { id: (id = id.next), content: "Fill the weekly feedback", completed: false },
  { id: (id = id.next), content: "Complete Ruby Basics 1", completed: false },
  { id: (id = id.next), content: "Complete Ruby Basics 2", completed: true },
  { id: (id = id.next), content: "Complete Ruby Methods", completed: false },
  { id: (id = id.next), content: "Do meditation", completed: false }
]

# Main Progam
list_todos(todos)

action = nil
while action != "exit"
  action = ask_for_action_prompt

  case action
  when "add"
    content = new_content
    add_todo(todos, id = id.next, content)
  when "list"
    list_todos(todos)
  when "completed"
    list_todos(todos, completed: true)
  when "toggle"
    ids = grab_ids
    toggle_todos(ids, todos)
  when "delete"
    ids = grab_ids
    delete_todos(ids, todos)
  when "exit"
    puts "Thanks for using toDOS!"
  else
    puts "Invalid action"
  end
ends