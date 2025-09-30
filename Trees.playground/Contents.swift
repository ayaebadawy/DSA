import Foundation

public class TreeNode {
    public var val: Int
    public var left: TreeNode?
    public var right: TreeNode?
    public init() { self.val = 0; self.left = nil; self.right = nil; }
    public init(_ val: Int) { self.val = val; self.left = nil; self.right = nil; }
    public init(_ val: Int, _ left: TreeNode?, _ right: TreeNode?) {
        self.val = val
        self.left = left
        self.right = right
    }
}
//700. Search in a Binary Search Tree      Time O(logn) since we elemenate half of the tree eachtime
//for a roughly balanced tree              Time O(h) where h is the height of the tree
//https://leetcode.com/problems/search-in-a-binary-search-tree/description/
func searchBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    var root = root
    while root != nil {
        if root!.val < val { root = root?.right }
        else if root!.val > val { root = root?.left }
        else { return root }
    }
    return nil
}

//Using recursion
func searchBSTRec(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let root = root else { return nil }
    if val > root.val {
        return searchBST(root.right, val)
    } else if val < root.val {
        return searchBST(root.left, val)
    } else {
        return root
    }
}
