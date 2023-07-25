Workshop: toDOS

Cuando halamos de CLI (command-line interface), hablamos de una aplicación de línea de comandos.

En el workshop de hoy vamos a construir un ToDo.

Básicamente es construir una application de linea de comandos que nos permita crear/manipular una lista de tareas.

Lo primero por hacer al clonar un repositorio, es instalar sus dependencias. En este caso como estamos sobre ruby, tenemos que ejecutar:

  bundle install
En el README del repositorio podemos ver todos los requerimientos de la aplicación.

Vemos en las imágenes que parte de los requerimientos es que la aplicación inicie con un mensaje de bienvenida y una lista de tareas iniciales, debajo de la lista de tareas se observa una lista de opciones y al final un mensaje de action que nos invita a elegir una acción para interactuar con la aplicación.

Aquí es donde podríamos decidir si dividir o no las tareas en tareas especificas, sin embargo, alguien tiene que encargarse del setup inicial o de las configuraciones iniciales, en este caso, no tenemos mucho de eso. Pero podríamos aprovechar para sentar las bases de lo que necesitaremos en el camino.

Inspirado en las buenas practicas voy a crear una nueva rama en la que trabajaremos sobre las bases del proyecto.

(main): git checkout -b feat/data-structure
Cuando ejecuto el programa, quiero imprimir una cabecera, un body, un menu de opciones y una variable que capture el prompt.

Entonces lo más crítico ("Core") sería crear la lista de tareas, y hasta este punto entendemos que tenemos que listar algo, cierto?

Preguntémonos, cuál sería la estructura que debería de tener esta lista, debería ser un arreglo? un hash? un arreglo de hashes quizás?

Empecemos por ahí, cuál sería la estructura más adecuada para tener un "conjunto de cosas"?

Como vamos a necesitar que un elemento de la lista tenga ciertos atributos/propiedades, si podría ser un Hash

# todos.rb

todo = { :id => 3, :content => "test todo", :status => "uncompleted" }
Tenemos una propiedad status que suena a que va a tener 2 posibles valor, esto podrían ser valores booleanos y la llave tendría un nombre como "completed".

# todos.rb

todo = { :id => 3, :content => "test todo", :completed => false }
Esta sería la estructura de un todo. Ahora, quisiéramos una lista de tareas sobre un arreglo.

# todos.rb

todos = [
  { :id => 1, :content => "copiar classroom", :completed => false },
  { :id => 2, :content => "copiar classroom", :completed => false },
  { :id => 3, :content => "copiar classroom", :completed => false }
]
Ya tenemos la estructura base.

Pero, ¿Por qué necesitamos construir un arreglo de todos primero? Si nos fijamos, todas las tareas involucran la manipulación de un todo, de la estructura base.

Agregamos los cambios y lo subimos a Github

(feat/data-structure): git commit -m "ADD: todos data structure"
(feat/data-structure): git push origin data-structure
Ahora en mi entorno local veo que la rama creada ya cumplió su propósito, entonces vamos a volver a la rama principal main.

(feat/data-structure): git checkout main
Ahora tenemos que actualizar y bajar los cambios de main

(main): git pull origin main
La recomendación siempre es mantener actualizada la rama main.

Vamos a empezar creando las tareas (issues) en github, una primera tarea podría ser crear el listado de acciones, y luego crear métodos para cada una de estas acciones.

# Github

issue 1: Create option list method (+ captura) => Andre
issue 2: Create a method that lists todos (+ captura) => Paulo
issue 3: For the scope of this task it should only show that the actions are working, if you choose an action that does not exist, ask again to choose an action
issue 1: Create option list method

# todos.rb

def print_menu
  puts "-" * 60
  puts "add | list | completed | toggle | delete | exit"
  puts "\n"
end
issue 2: Create a method that lists todos (+ captura)

Para resolver el issue que tengo asignado vamos a crear una rama llamada feat/list-todos

(main): git checkout -b feat/list-todos
Luego vamos a listar los todos, y vamos a ir de a pocos hasta construir la estructura que deseamos mostrar en consola haciéndolo aún sin ningún método.

¿Como podría hacer para recorrer estos todos y pintarlos en consola?

# todos.rb

todos = [...]
# /////
todos.each do |todo|
  puts todo
end
# /////
Después de recorrer el arreglo es momentos de agregarle el formato que espera el ejercicio usando la interpolación.

# todos.rb

todos.each do |todo|
  # /////
  puts "#{todo[:id]}. #{todo[:content]}"
  # /////
end
Listar los todos es algo que haremos repetidas veces en este proyecto, esto clasifica para ser creado como un método al que podremos invocar cuando lo necesitemos.

El método nos va a ayudar a reutilizar el código. En ruby, la convención de nombres para los métodos, es usando snake_case, existen otras convenciones como camelCase (js), PascalCase (clases en ruby), etc.

# todos.rb

# /////
def list_todos
  todos.each do |todo|
    puts "#{todo[:id]}. #{todo[:content]}}"
  end
end
# /////
Esto deja de funcionar porque la variable todos está fuera del scope del método, necesitamos pasar la variable como argumento del método list_todos y definir el parámetro del método.

# todos.rb

# Data
todos = [...]

# Methods
# /////
def list_todos(todos)
# /////
  todos.each do |todo|
    puts "#{todo[:id]}. #{todo[:content]}}"
  end
end

# Main program
# /////
list_todos(todos)
# /////
Según los requerimientos, siempre que yo listo todos se debe de mostrar un mensaje de bienvenida.

# todos.rb

# Methods
def list_todos(todos)
# /////
  puts "------------------------Welcome to toDOS------------------------"
  puts ""
  # Opción 1👆 , Opción 2👇
  puts "------------------------Welcome to toDOS------------------------\n\n"
# /////

  todos.each ...
end
Otra opción podría ser multiplicar los guiones y luego interpolar.

# todos.rb

# Methods
def list_todos(todos)
# /////
  puts "#{"-" * 24} Welcome to toDOS #{"-" * 24} \n\n"
# /////
  todos.each ...
end
Ya estoy contento con mi aporte, voy a subir mis cambios.

(feat/list-todos): git add .
(feat/list-todos): git commit -m "ADD: list_todos method"
(feat/list-todos): git push origin feat/list-todos
Ahora voy a github para hacer un pull request.

Es momento de revisar el código de nuestro compañero.
Ya luego se decide en equipo quien tendrá los honores de pasar los cambios a main con un merge request de github y pasamos los cambios de compañero primero.

Ahora mi pull-request tiene conflictos que tendremos que resolver usando rebase o usando merge.

Después de resolver todos los conflictos deberíamos de tener algo como esto:

# todos.rb

# Data
todos = [
  { id: 1, content: "copiar classroom", completed: false },
  { id: 2, content: "copiar classroom", completed: false },
  { id: 3, content: "copiar classroom", completed: false }
]

# Methods
def list_todos(todos)
  puts "#{"-" * 24} Welcome to toDOS #{"-" * 24} \n\n"
  todos.each do |todo|
    puts "#{todo[:id]}. #{todo[:content]}"
  end
end

def print_menu
  puts "-" * 60
  puts "add | list | completed | toggle | delete | exit"
  puts "\n"
end

# Main program
list_todos(todos)
print_menu
Volvemos a subir los cambios después de tener resuelto los conflictos en local y esperamos revisiones del PR.

Yo podría ir trabajando en otra cosa, pero necesito avanzar sobre mi código ya avanzado, podría bifurcar una rama a partir de esta (feat/list-todos) y cuando esta rama sea actualizada en main tendré todos esos nuevos cambios para seguir trabajando sin bloquearme.

Teniendo eso en mente vamos por el issue 3: For the scope of this task it should only show that the

(feat/list-todos): git checkout -b feat/action-loop
Vamos a crear un loop para que nos muestre las acciones.

# todo.rb

# Main program
list_todos(todos)
print_menu

# /////
action = nil
while action != "exit"
  print "action: "
  action = gets.chomp
end
# /////
Solo si escribo exit el programa se detiene. Nosotros queremos ejecutar algo cada vez que seleccione una action, para lograrlo podemos capturar una acción y evaluarlo usando case

# todo.rb

# Main program
...
action = nil
while action != "exit"
  print "action: "
  action = gets.chomp

  # /////
  case action
    when "list" then puts "List uncompleted todos"
    when "completed" then puts "List completed todos"
    when "add" then puts "Add todo"
    when "toggle" then puts "Toggle todo"
    when "delete" then puts "Delete todo"
  end
end

puts "Thanks for using toDOS!"
# /////
El then se usa cuando quiero usar los when's en una sola linea, pero cuando quiero usarlo como bloque o mas lineas el case-when se usa de la siguiente manera:

# todo.rb

# Main program
...
  case action
    # /////
    when "list"
      puts "List uncompleted todos"
    when "completed"
      puts "List completed todos"
    when "add"
      puts "Add todo"
    when "toggle"
      puts "Toggle todo"
    when "delete"
      puts "Delete todo"
    # /////
  end
Finalmente agregaremos los cambios y los subiremos a Github.

(feat/action-loop): git add .
(feat/action-loop): git commit -m "ADD: program main loop asking for user action"
(feat/action-loop): git push origin feat/action-loop
Volvemos a main para actualizar la rama y resolver conflictos si existiere alguno.

(feat/action-loop): git checkout main
(main): git pull origin main
(main): git checkout feat/action-loop
(feat/action-loop): git rebase main
// resolvemos conflictos
(feat/action-loop): git push origin +feat/action-loop
Ahora es más visual las posibles tareas, como por ejemplo crear un método para cada acción.

# Github

issue 4: Create method to added a todo (Paulo)
issue 5: Create method to toggle todo state (Andre)
issue 6: Create method to list completed & incomplete todo (Paulo)
issue 7: Create method to delete todo (Paulo)
issue 5: Create method to toggle todo state

def list_todos(todos, completed: false) ... end

# /////
def toggle_todos(ids, todos)
  ids.each do |id|
    found_todo = todos.find { |todo| todo[:id] == id }
    found_todo[:completed] = !found_todo[:completed] if found_todo
  end
end
# /////
...

when "toggle"
  # /////
  print "todo ID(s): "
  ids = gets.chomp.split(",").map(&:to_i)
  toggle_todos(ids, todos)
  # /////
Nos vamos a encargar del issue 6: Create method to list completed & incomplete todo, volvemos a la rama main, la actualizamos y desde ahí creamos una nueva rama para resolver el issue 6

(feat/action-loop): git checkout main
(main): git pull origin main
(main): git checkout -b feat/action-list
Cuando el usuario ejecute la acción list, deberíamos imprimir la lista de tareas no completadas.

# todos.rb

  case action
    when "list"
    # /////
      list_todos(todos)
      print_menu
    # /////
    ...
  end
Pero, actualmente esta retornando todas las tareas, indistintas a si están o no completadas, agreguemos algunas tareas no completadas en la sección de data.

# todos.rb

# Data
todos = [
  # /////
  { id: 1, content: "Fill the weekly feedback", completed: false },
  { id: 2, content: "Complete Ruby Basics 1", completed: false },
  { id: 3, content: "Complete Ruby Basics 2", completed: false },
  { id: 4, content: "Complete Ruby Methods", completed: true },
  { id: 5, content: "Do meditation", completed: true }
  # /////
]
Solo queremos imprimir las tareas que aún no están completadas, para lograrlo usaremos una condicional dentro del método list_todos

# todos.rb

def list_todos(todos)
  puts "#{"-" * 24} Welcome to toDOS #{"-" * 24} \n\n"

  todos.each do |todo|
    # /////
    if todo[:completed] == false
      puts "#{todo[:id]}. #{todo[:content]}"
    end
    # /////
  end
end
El método list_todos está listando todas las tareas que no fueron completadas y ahora quiero tener otro método, para mostrar todas las tareas que si fueron completadas. Una manera de hacer esto seria creando otro método, y cambiándole la validación

(copiamos el método de list_todos y le cambiamos el nombre a list_completed_todos(todos))

# Methods
def list_todos(todos)
  ...
end

def list_completed_todos(todos)
  puts "#{"-" * 24} Welcome to toDOS #{"-" * 24} \n\n"
  todos.each do |todo|
    # /////
    if todo[:completed] == true
      puts "#{todo[:id]}. #{todo[:content]}"
    end
    # /////
  end
end
Funciona, pero estoy repitiendo código teniendo 2 métodos que hacen lo mismo, y la única diferencia es el valor de la condicional. Podemos hacer que sea un solo método, y que mediante alguna lógica pasándola argumentos, este método sepa que lista me tiene que retornar.

(Eliminamos el método list_completed_todos)

Dicho esto, list_todos, no solo necesita recibir las tareas por parámetros, sino que también necesita el estado de las tareas.

# todos.rb

# /////
def list_todos(todos, completed)
  puts "#{"-" * 24} Welcome to toDOS #{"-" * 24} \n\n"

  todos.each do |todo|
    if todo[:completed] === completed
      puts "#{todo[:id]}. #{todo[:content]}"
    end
# /////
  end
end
Probemos invocando al método:

# todos.rb
  case action
    when "list"
    # /////
      list_todos(todos, false)
      print_menu
    when "completed"
      list_todos(todos, true)
      print_menu
    # /////
  end
Esto me lanza un error porque en la sección main program, solo estoy pasando un argumento, necesitamos un argumento por default => completed = false

# todos.rb

# /////
def list_todos(todos, completed = false)
  ...
end
# /////
Primero vamos a hacer un commit, para no mesclar mis cambios con las ofensas que descubra rubocop.

(feat/action-list): git add .
(feat/action-list): git commit -m "ADD: methods to list todos"
Luego ejecutamos rubocop y revisamos algunas ofensas. Rubocop nos sugiere un argumento nombrado como keywords arguments, imaginemos que solo ve un booleano(true) en la invocación del método, rubocop se pregunta: "¿para qué sirve true?". Este es un escenario para agregar un keyword argument porque especificamos que significa el valor booleano.

# todos.rb

# /////
# Methods
def list_todos(todos, completed: false) ... end

# Main program
list_todos(todos, completed: false)
...

while action != "exit"
  ...

  when "list"
    list_todos(todos, completed: false)
  when "completed"
    list_todos(todos, completed: true)
# /////
Ya podríamos hacer un commit con los cambios que me recomendó rubocop

(feat/action-list): git add .
(feat/action-list): git commit - "CHORE: changes suggestions by rubocop"
(feat/action-list): git push origin action-list
Ahora vamos a construir el issue 4: Create method to added a todo

(feat/action-list): git checkout main
(main): git pull origin main
(main): git checkout -b feat/add_todo
#  todo.rb

def toggle_todos(ids, todos) ... end

# /////
def add_todo(todos, new_content)
  next_id = todos.size + 1
  todos.push({ id: next_id, content: new_content, completed: false })
end
...

when "add"
  print "content: "
  new_todo = gets.chomp
  add_todo(todos, new_todo)
  print_menu
# /////
....
Aquí tenemos un problema con los id's, ¿Que pasa si luego necesito eliminar algún id?, por ejemplo digamos elimino la última tarea id: 5, después de eliminarla agrego una nueva tarea size + 1 y se vuelve a crear un todo con el id: 5, esto no es correcto porque la tarea con el id: 5 ya fue eliminada.

Usar el size + 1 no es prudente ni correcto, lo que podríamos hacer es usar el método next de los enteros, de manera que siempre nos va a generar un siguiente número como id.

# todos.rb

# /////
# Data
id = 0

todos = [
  { id: (id = id.next), content: "Fill the weekly feedback", completed: false },
  { id: (id = id.next), content: "Complete Ruby Basics 1", completed: false },
  { id: (id = id.next), content: "Complete Ruby Basics 2", completed: false },
  { id: (id = id.next), content: "Complete Ruby Methods", completed: false },
  { id: (id = id.next), content: "Do meditation", completed: false },
  { id: (id = id.next), content: "Attend English classes", completed: true },
  { id: (id = id.next), content: "Prepare Lightning Talk", completed: true }
]
# /////

...
# Methods
# /////
def add_todo(todos, id, new_content)
  new_todo = { id: id, content: new_content, completed: false }
  todos.push(new_todo)
end
# /////

# Main program
when "add"
  # /////
  new_content = gets.chomp
  add_todo(todos, id = id.next, new_content)
  # /////
Con esta acción, lo resolvemos, ahora subimos los cambios fusionamos con main y resolvemos conflictos si los hubiera.

(feat/add_todo): git add .
(feat/add_todo): git commit -m "add: add_todo method"
(feat/add_todo): git push origin feat/add_todo
Ahora vamos por lo que creo podría ser la última tarea issue 7: Create method to delete todo

(feat/add_todo): git checkout main
(main): git pull origin main
(main): git checkout -b feat/action-delete
El delete según el campus, deberíamos poder agregar varios ID's, se parece mucho a como se resuelve el toggle así que, podemos usarlo como guía.

# todos.rb

# Main program
# /////
when "delete"
  print "todo ID(s): "
  ids = gets.chomp.split(",").map(&:to_i)
  delete_todos(ids, todos)
  # 👆 por ahora no existe el método pero espero que reciba mis 2 argumentos
  print_menu
end
# /////
Entonces ahora vamos a crear el método delete_todos.

# Methods

def add_todo(todos, id, new_content) ... end

# /////
def delete_todos(ids, todos)
  ids.each do |id|
    # Como borro un elemento de un arreglo?
    # Google: delete element from array ruby
  end
end
# /////
Vamos a la documentación de ruby, en la sección de Arrays buscamos delete, y encontramos un delete_if, que es un delete con un bloque condicional, con este método también podemos evitar usar el each, veamos:

# Methods

# /////
def delete_todos(ids, todos)
  todos.delete_if do |todo|
    ids.include?(todo[:id])
  end

  # You can also do 👆 the same thing with this. 👇
  # todos.filter! { |todo| !ids.include?(todo[:id])}
  # todos.reject! { |todo| ids.include?(todo[:id])} # hermano malvado del filter
end
# /////
Ya tenemos resuelto el alcance de la tarea, hacemos un commit de los cambios.

(feat/action-delete): git add .
(feat/action-delete): git commit -m "ADD: delete action to remove todos"
Ahora ejecutamos rubocop y si hubiera ofensas, tocara resolverlas hacer un commit con los nuevos cambios, luego subimos los cambios a Github para luego hacer un merge request.

(feat/action-delete): git push origin feat/action-delete
Resolvemos conflictos si hubiese. Ya tenemos el proyecto terminado y así es como esperamos que trabajen en equipo.

Podemos dar el extra al proyecto ordenando mejor nuestro código, a esta acción se le llama hacer un refactor y podríamos agregar esta tarea en Github.

# Github

issue 8: Refactor project
Y en local creamos una rama para hacer el refactor.

(feat/action-delete): git checkout main
(main): git pull origin main
(main): git checkout -b refactor-project
Para eso vamos creando un nuevo archivo rb al que moveremos todos nuestros métodos

(refactor-project): touch todos_methods.rb
# todos_methods.rb
# (copiamos todo lo que este en el apartado "# Methods")

# todos.rb
# (invoco al archivo todos_methods dentro del todos.rb)
require_relative "todos_methods"

# data
Solo movimos los métodos a otro archivo para que se vean un poco más ordenado y limpio

(refactor-project): git commit -m "chore: Move all methods to todos_methods file"
Por acá veo que el código del toggle y del delete tenemos que el action menu se repite, podemos refactorizarlo creando un método que lo resuelva.

# todos_methods.rb

# /////
def grab_ids
  print "todo ID(s):"
  gets.chomp.split(",").map(&:to_i)
end
# /////

# todos.rb
when "toggle"
# /////
  ids = grab_ids
# /////
  toggle_todos(ids, todos)
  print_menu
when "delete"
# /////
  ids = grab_ids
# /////
  delete_todos(ids, todos)
  print_menu
end
(refactor-project): git commit -m "add: grab_ids methods"
La invocación del print_menu se repite muchas veces, quizás podría hacer que cada vez que se ejecute un action, se invoque el print menu. Podría mover todos los print_menu y lo pondríamos antes de cada llamada al prompt

# todos.rb

# Main program
...
action = nil
while action != "exit"
# /////
# Elimino el print_menu de todos lados menos de este bloque
  print_menu
  print "action: "
  action = gets.chomp
# /////
...
end
Ahora, esta llamada a la acción quizás podría envolverse dentro del mismo método print_menu, solo que ahora al pedir también una acción el nombre del método pierde el sentido... pero podríamos renombrarlo:

# todo_methods.rb

# /////
# reemplazamos el método print_menu por este.
def ask_for_action_prompt
  puts "-" * 60
  puts "add | list | completed | toggle | delete | exit"
  puts "\n"

  print "action: "
  gets.chomp.strip
  # buscar en documentación // solo explicar que onda.
end
# /////

# todos.rb

# /////
while action != "exit"
  action = ask_for_action_prompt
# /////
(refactor-project): git commit -m "add: ask for action propmpt method"
Ahora, si agrega una acción que no tengo registrado deberíamos de poder enviar una mensaje en consola con un invalid option

# todos.rb

...
  when "delete"
    ids = grab_ids
    delete_todos(ids, todos)
  # /////
  else
    "Invalid action"
  end
  # /////
(refactor-project): git commit -m "add: message to invalid action"
Aún falta validar que funcione, podríamos validar que el new_content nunca sea un dato vació.

# todo_methods.rb
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

# todo.rb
when "add"
    content = new_content
(refactor-project): git commit -m "add: new content method"
Y finalmente pasamos todo a main a través de Github

(refactor-project): git push origin refactor-project

(refactor-project): git checkout main
(main): git pull origin main
Terminamos el refactor. Fin 🎉