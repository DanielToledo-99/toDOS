# Methods
def ask_for_action_prompt
    puts "-" * 60
    puts "add | list | completed | toggle | delete | exit"
    puts "\n"
  
    print "action: "
    gets.chomp.strip #=> "add    " => "add"
  end
  
  def list_todos(todos, completed: false)
    puts "#{'-' * 24}Welcome to toDOS#{'-' * 24}\n\n"
  
    todos.each do |todo|
      format_todo = "#{todo[:id]}. #{todo[:content]}"
      puts format_todo if todo[:completed] == completed
    end
  end
  
  def toggle_todos(ids, todos)
    ids.each do |id|
      found_todo = todos.find { |todo| todo[:id] == id }
      found_todo[:completed] = !found_todo[:completed] if found_todo
    end
  end
  
  def add_todo(todos, id, new_content)
    new_todo = { id: id, content: new_content, completed: false }
    todos.push(new_todo)
  end
  
  def delete_todos(ids, todos)
    todos.delete_if do |todo|
      ids.include?(todo[:id])
    end
  end
  
  def grab_ids
    print "todo ID(s): "
    gets.chomp.split(",").map(&:to_i)
  end
  
  def new_content
    print "content: "
    content = gets.chomp
  
    while content.empty?
      puts "Content cannot be empty"
      print "content: "
      content = gets.chomp
    end
  
    content
  end