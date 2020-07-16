class Node

    include Comparable
    attr :value

    def initialize(value, left=nil, right=nil)
        @value = value
        @left = left
        @right = right
    end

    def <=>(other)
        value <=> other.value
    end

end

class Tree

    def initialize(array)
        
    end

    def build_tree(array)

    end

    def insert(value)

    end

    def delete(value)

    end

    def find(value)

    end

    def level_order

    end

    def inorder

    end

    def preorder

    end

    def postorder

    end

    def depth

    end

    def balanced?

    end

    def rebalance

    end

end

temp = []
p temp[0]