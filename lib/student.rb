
class Student
  attr_accessor :id, :name, :grade


  
  def save
    sql = <<-SQL
      INSERT INTO students (name, grade) 
      VALUES (?, ?)
    SQL

    DB[:conn].execute(sql, self.name, self.grade)
  end
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade TEXT
    )
    SQL

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students"
    DB[:conn].execute(sql)
  end

  def self.new_from_db(row)
    stud = self.new
    stud.id= row[0]
    stud.name = row[1]
    stud.grade = row[2]
    stud
  end
  
  def self.find_by_name(name)
    find = <<-SQL 
    SELECT * FROM students
    WHERE name =?
    LIMIT 1
    SQL
    DB[:conn].execute(find, name).map do |row|
      self.new_from_db(row)
    end.first
  end
def self.all
all= <<-SQL
SELECT * FROM students
SQL
DB[:conn].execute(all).map do |row|
    self.new_from_db(row)
end
end
def self.all_students_in_grade_9
  grade_9 = <<-SQL
  SELECT * FROM students
  WHERE grade = 9
  SQL
  DB[:conn].execute(grade_9).map do |row|
    self.new_from_db(row)
end
end
def self.students_below_12th_grade
  grade_12 = <<-SQL
  SELECT * FROM students
  WHERE grade < 12
  SQL
  DB[:conn].execute(grade_12).map do |row|
    self.new_from_db(row)
end
end
def self.first_X_students_in_grade_10(num)
  grade = <<-SQL
  SELECT * FROM students
  WHERE grade =10
  LIMIT ?
  SQL
  DB[:conn].execute(grade, num).map do |row|
    self.new_from_db(row)
end
end
def self.first_student_in_grade_10
  grade_10_first = <<-SQL
  SELECT * FROM students
  WHERE grade =10
  SQL
  DB[:conn].execute(grade_10_first).map do |row|
    self.new_from_db(row)
end.first
end
def self.all_students_in_grade_X (num)
  grade_X= <<-SQL 
  SELECT * FROM students
  WHERE grade = ?
  SQL
  DB[:conn].execute(grade_X, num).map do |row|
    self.new_from_db(row)
  end

end

end

