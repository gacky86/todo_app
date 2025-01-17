SAMPLE_TODOS = [
  { name: 'Going around the world' },
  { name: 'Graduating from college' },
  { name: 'Publishing a book' }
]

SAMPLE_TODOS.each { |todo| Todo.create(todo) }
