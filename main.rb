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

	def delete(given_value, current_node = @root, parent_node = nil, last_direction = "")
		return if @init_array.include?(given_value.to_i) == false
		if (current_node.value == given_value) && (current_node.left == nil) && (current_node.right == nil)
			if last_direction == "left"
				@init_array.delete(given_value)
				parent_node.left = nil
			elsif last_direction == "right"
				@init_array.delete(given_value)
				parent_node.right = nil
			end
		elsif (current_node.value == given_value) && (current_node.left != nil) && (current_node.right != nil)
			@init_array.delete(given_value)
			self.build_tree(@init_array)
		elsif (current_node.value == given_value) && (current_node.left != nil) 
			if last_direction == "left"
				@init_array.delete(given_value)
				parent_node.left = current_node.left
			elsif last_direction == "right"
				@init_array.delete(given_value)
				parent_node.right = current_node.left
			end
		elsif (current_node.value == given_value) && (current_node.right != nil)
			if last_direction == "left"
				@init_array.delete(given_value)
				parent_node.left = current_node.right
			elsif last_direction == "right"
				@init_array.delete(given_value)
				parent_node.right = current_node.right
			end
		else
			if given_value < current_node.value
				delete(given_value, current_node.left, current_node, "left")
			else
				delete(given_value, current_node.right, current_node, "right")
			end
		end
	end

	def find(given_value, current_node = @root)
		if current_node.value == given_value
			current_node
		elsif (current_node.left == nil) && (current_node.right == nil)
			"value does not exist in tree"
		else
			if given_value < current_node.value
				find(given_value, current_node.left)
			else
				find(given_value, current_node.right)
			end
		end
	end

	def pre_order(arr = [], current_node = @root)
		arr << current_node.value
		return arr if (current_node.left == nil) && (current_node.right == nil)
		if current_node.left != nil
			pre_order(arr,current_node.left)
		end
		if current_node.right != nil
			pre_order(arr,current_node.right)
		end
	end

	def in_order(arr = [], current_node = @root)
		if current_node.left != nil
			in_order(arr,current_node.left)
		end
		arr << current_node.value
		return arr if (current_node.left == nil) && (current_node.right == nil)
		if current_node.right != nil
			in_order(arr,current_node.right)
		end
	end

	def post_order(arr = [], current_node = @root)
		if current_node.left != nil
			post_order(arr,current_node.left)
		end
		if current_node.right != nil
			post_order(arr,current_node.right)
		end
		arr << current_node.value
	end

	def level_order(arr = [], queue = [], current_node = @root)
		queue << current_node if current_node == @root
		if queue.size > 0
			queue << queue[0].left if queue[0].left != nil
			queue << queue[0].right if queue[0].right != nil
			arr << queue.shift.value
			level_order(arr,queue,queue[0])
		else
			arr
		end
	end
end


# input_array = [1,6,5,7,8,14,33,453,231,665,4449,77,62,33,11,1,44,33]

input_array = [20,50,30,70,40,60,80]


a = Tree.new(input_array)

p a.level_order