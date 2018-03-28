class Node
  attr_accessor :value, :next_node 

  def initialize(value, next_node = nil)
    @value = value
    @next_node = next_node
  end 

end

class LinkedList
  # if a stack ... no need for keeping track of tail, but might want to if the list is used for other reasons
  attr_accessor :head, :size

  def initialize
    @head = nil
    @size = 0
  end

  def append(value)
  # adds a new node to the end of the list
    if head == nil
     self.head = Node.new(value)
    else
      node = head
      while node.next_node != nil
      # search until current node's next_node value is not a pointer
        node = node.next_node
      end
      node.next_node = Node.new(value)
    end
    self.size += 1
  end 

  def prepend(value)
  # adds a new node to the start of the list
    self.head = Node.new(value, head)
    self.size += 1
  end

  def tail
  # returns the last node in the list
    node = head
    for i in 1...size
      node = node.next_node
    end
    node
  end

  def at(index)
  # returns the node at the given index
    node = head
    if index > 0
      if index >= size
        return "That index is greater than the current linked list size"
      else
        for i in 1..index
          node = node.next_node
        end
      end
    end
    node
  end 

  def pop
  # removes the last element from the list
    if size == 0
      return "Linked list is already empty, nothing to pop"
    elsif size == 1
      self.head = nil
    else
      node = head
      for i in 2...size
        node = node.next_node
      end
      node.next_node = nil
    end
    # but how to actually delete the node so no space wastage???
    self.size -= 1
  end 

  def contains?(match_val)
  # returns true if the passed in value is in the list, otherwise returns false.
    match = false
    node = head
    for i in 0...size
      if node.value == match_val
        return true
      end
      node = node.next_node
    end
    match
  end 

  def find(data)
  # returns the index of the first node containing data, or nil if not found.
  # index starts at 0
    node = head
    for i in 0...size
      if node.value == data
        return i
      end
      node = node.next_node
    end
    return nil
  end 

  def to_s
  # represent the LinkedList objects as strings, so they can be printed out to console
  # format: ( data ) -> ( data ) -> ( data ) -> nil
    data = []
    node = head
    for i in 0...size
      data[i] = "(#{node.value.to_s})"
      node = node.next_node
    end
    puts data.join(" -> ")
  end 

  def insert_at(index, value) 
  # inserts the node at the given index
    if index == 0
      prepend(value)
    elsif index >= size
      append(value)
    else
      prenode = head
      for i in 2..index
        prenode = prenode.next_node
      end
      postnode = prenode.next_node
      newnode = Node.new(value, postnode)
      prenode.next_node = newnode
      self.size += 1
    end
  end

  def remove_at(index) 
  # removes the node at the given index.
    if index == 0
      # first element
      self.head = head.next_node
    elsif index >= size
      return "There is not such index"
    else
      prenode = head
      for i in 2..index
        prenode = prenode.next_node
      end
      if index == size - 1
        # last element
        prenode.next_node = nil
      else
        # any element that is not first or last
        postnode = prenode.next_node.next_node
        prenode.next_node = postnode
      end
    end
    self.size -= 1
  end 

end


my_list = LinkedList.new
my_list.append(1)
my_list.append(2)
my_list.append(3)
my_list.append(4)
my_list.size
my_list.head




