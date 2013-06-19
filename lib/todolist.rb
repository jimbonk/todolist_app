class TodoList
  attr_reader :list, :file
  attr_accessor :title

  def initialize(file="")
    @file = file
    @list = []

    if File.exist? @file
      File.open @file do |f| 
        @title = f.gets.chomp
        f.each { |line| @list << line.chomp }
      end
    end
  end

  def add(item, pos=nil)
    return if item.nil?
    
    if pos.nil?
      @list << item
    elsif pos == 0 || pos == 'title'
      @title = item
    else
      @list.insert(pos.to_i-1, item)
    end
  end

  def delete(pos=nil)
    return @list.pop if pos.nil?
    @list.delete_at(pos.to_i-1)
  end

  def save
    File.open(@file, 'w') do |f|
      f.puts @title
      @list.each { |item| f.puts item }
    end
  end

  def output
    output_list = ["Title: #{@title}"]
    @list.each_with_index { |item, i| output_list << "#{i+1}. #{item}"}
    output_list
  end
end