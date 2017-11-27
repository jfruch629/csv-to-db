require 'pg'
require 'csv'
require 'pry'

def db_connection
  begin
    connection = PG.connect(dbname: "ingredients")
    yield(connection)
  ensure
    connection.close
  end
end

CSV.foreach('ingredients.csv', headers: true) do |row|
  db_connection do |conn|
    insert_ingredient = "INSERT INTO ingredients (step, ingredient) VALUES ($1,$2)"
    values = [row['step'], row['ingredient']]
    conn.exec_params(insert_ingredient, values)
  end
end

select_ingredients = "SELECT * FROM ingredients"
ingredients = db_connection do |conn|
  conn.exec(select_ingredients)
end

ingredient_string = ""
ingredients.each do |w|
  ingredient_string += "#{w['step']}. #{w['ingredient']}\n"
end

puts ingredient_string
