# frozen_string_literal: true

# Node of a singly-linked list
class Node
  attr_accessor :value, :next

  def initialize
    self.value = nil
    self.next = nil
  end
end

# Singly-linked list
class ListedList
  attr_accessor :head, :tail, :size

  def initialize
    self.head = nil
    self.tail = nil
    self.size = 0
  end

  def append(value)
    node = create_node(value)

    if size.zero?
      self.head = self.tail = node
    else
      tail.next = node
      self.tail = node
    end
    self.size += 1
  end

  def prepend(value)
    node = create_node(value)

    if size.zero?
      self.head = self.tail = node
    else
      node.next = head
      self.head = node
    end

    self.size += 1
  end

  def at(index)
    return nil if index > size

    current = head
    index.times { current = current.next }
    current.value
  end

  # rubocop:disable all
  def pop
    return nil if size.zero?

    current = head

    if size == 1
      self.head = self.tail = nil
    else
      current = current.next until current.next == tail
      self.tail = current
      current = current.next
      self.tail.next = nil
    end
    self.size -= 1
    current
  end
  # rubocop:enable all

  def contains?(value)
    found = false

    current = head

    until found == true || current.nil?
      found = true if current.value == value
      current = current.next
    end
    found
  end

  def find(value)
    current = head

    current = current.next until current.nil? || current.value == value

    current
  end

  def to_s
    output = ''
    current = head

    until current.nil?
      output = "#{output}#{current.value} --> "
      current = current.next
    end

    "#{output}nil"
  end

  private

  def create_node(value)
    node = Node.new
    node.value = value
    node
  end
end

ll = ListedList.new
ll.append(4)
ll.append(41)
ll.append(12)
ll.prepend(55)
ll.prepend(44)

p ll.to_s

p ll.head
p ll.tail

p ll.at(0)
p ll.at(3)
p ll.at(30)

ll.pop

p ll.to_s

p ll.contains?(4) # true
p ll.contains?(40) # false
p ll.find(4) # node
p ll.find(40) # nil

p ll.to_s
