class Node
	attr_accessor :value, :left, :right, :current_node
	def initialize(value = nil, left = nil, right = nil)
		@value = value
		@left = left
		@right = right
	end
end

class Tree
	attr_reader :size, :root, :init_array
	def initialize(arr=[])
		@init_array = arr.sort.uniq
		@size = @init_array.size 
		@end_point = @size - 1
		@start_point = 0
		@root = self.build_tree
	end

	def build_tree(arr = @init_array, start = @start_point, t_end = @end_point)
		return nil if start > t_end
		mid = (start +  t_end)/2
		new_node = Node.new(arr[mid])
		new_node.left = build_tree(arr,start,mid-1)
		new_node.right = build_tree(arr,mid+1,t_end)
		return new_node
	end

	def insert(given_value, current_node = @root)
		if given_value == current_node.value
			puts "node already exists in tree"
			return
		elsif (current_node.left == nil) && (current_node.right == nil)
			if given_value < current_node.value
				puts "creating new node left"
				current_node.left = Node.new(given_value)
			else
				puts "creating new node right"
				current_node.right = Node.new(given_value)
			end
		else
			if given_value < current_node.value
				insert(given_value, current_node.left)
			else
				insert(given_value, current_node.right)
			end
		end
	end

	def delete(given_value, current_node = @root)
		


	end

end


input_array = [1,6,5,7,8,14,33,453,231,665,4449,77,62,33,11,1,44,33]


a = Tree.new(input_array)

a.insert(13)

a.insert(111400)

# puts a.init_array[0..3]