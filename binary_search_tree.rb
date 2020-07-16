class Node

    include Comparable
    attr_accessor :value
    attr_accessor :left
    attr_accessor :right

    def initialize(value, left=nil, right=nil)
        @value = value
        @left = left
        @right = right
    end

   # def <=>(other)
   #     value <=> other.value
    #end

end

class Tree

    def initialize(array)
        new_array = unique_array(array)
        new_array.sort!
        @root = build_tree(new_array)
    end

    def unique_array(array)
        new_array = []
        array.each do |x|
            if (!new_array.include?(x))
                new_array.push(x)
            end
        end
        return new_array
    end

    def build_tree(array)
        if( !array.is_a?(Array) || array.length == 0)
            return nil
        end
        if(array.length == 1)
            new_node = Node.new(array[0])
            return new_node
        end
        if(array.length % 2 == 0)
            left = build_tree(array.slice(0,array.length/2-1))
            right = build_tree(array.slice(array.length/2,array.length-array.length/2))
            root = Node.new(array[array.length/2-1], left, right)
            return root
        end
        left = build_tree(array.slice(0,array.length/2))
        right = build_tree(array.slice(array.length/2+1,array.length-array.length/2-1))
        root = Node.new(array[array.length/2], left, right)
        return root
    end

    def insert(value)
        if(find(value) == nil)
            node = insert_at(value)
            if(value < node.value)
                node.left = Node.new(value)
            else
                node.right = Node.new(value)
            end
        end
    end

    def insert_at(value)
        node = @root
        while true do
            if(value < node.value)
                if(node.left == nil)
                    break
                else
                    node = node.left
                end
            end
            if(value > node.value)
                if(node.right == nil)
                    break
                else
                    node = node.right
                end
            end
        end
        return node
    end

    def delete(value)
        if(find(value) != nil)
            tree = level_order()
            tree.delete(value)
            @root = build_tree(tree)
        end
    end

    def find(value)
        return find_node(@root, value)
    end

    def find_node(node, value)
        if( node == nil )
            return nil
        elsif( node.value == value )
            return node
        elsif( value < node.value )
            return find_node(node.left, value)
        else
            return find_node(node.right, value)
        end
    end

    def level_order
        if(@root == nil)
            return nil
        end
        result = []
        queue = [@root]
        index = 0
        while index < queue.length do
            result.push(queue[index].value)
            
            if(queue[index].left != nil)
                queue.push(queue[index].left)
            end
            if(queue[index].right != nil)
                queue.push(queue[index].right)
            end
            index += 1
        end
        return result
    end

    def inorder
        return inorder_node(@root)
    end
    
    def inorder_node(node)
        if(node == nil)
            return []
        end
        new_array = inorder_node(node.left) +[node.value] +inorder_node(node.right)
    end

    def preorder
        return preorder_node(@root)
    end

    def preorder_node(node)
        if(node == nil)
            return []
        end
        new_array = [node.value]+ preorder_node(node.left)+ preorder_node(node.right)
    end

    def postorder
        return postorder_node(@root)
    end

    def postorder_node(node)
        if(node == nil)
            return []
        end
        new_array = postorder_node(node.left) +postorder_node(node.right) +[node.value]
    end

    def depth(root)
        if( root == nil )
            return 0
        end
        return 1+[depth(root.left), depth(root.right)].max
    end

    def balanced?
        if(@root == nil)
            return true
        end
        queue = [@root]
        index = 0
        while index < queue.length do
            if (depth(queue[index].left) - depth(queue[index].right)).abs > 1
                return false
            end
            if(queue[index].left != nil)
                queue.push(queue[index].left)
            end
            if(queue[index].right != nil)
                queue.push(queue[index].right)
            end
            index += 1
        end
        return true
    end

    def rebalance
        tree = level_order()
        tree.sort!
        @root = build_tree(tree)
    end

    def root
        @root
    end
end
