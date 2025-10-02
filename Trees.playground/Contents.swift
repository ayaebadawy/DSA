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

//701. Insert into a Binary Search Tree
//https://leetcode.com/problems/insert-into-a-binary-search-tree/description/
func insertIntoBST(_ root: TreeNode?, _ val: Int) -> TreeNode? {
    guard let root = root else {
        return TreeNode(val)
    }
    if root.val > val {
        root.left = insertIntoBST(root.left, val)
    } else {
        root.right = insertIntoBST(root.right, val)
    }
    return root
}

//450. Delete Node in a BST
//https://leetcode.com/problems/delete-node-in-a-bst/description/
func deleteNode(_ root: TreeNode?, _ key: Int) -> TreeNode? {
    guard let root = root else { return nil }
    if key > root.val { //go right
        root.right = deleteNode(root.right, key)
    } else if key < root.val { // go left
        root.left = deleteNode(root.left, key)
    } else { // found
        if root.right == nil { return root.left }
        else if root.left == nil { return root.right }
        else {
            guard let min = findMin(root.right) else {return nil } // find min of the right subtree
            root.val = min.val //repplace that with min
            root.right = deleteNode(root.right, min.val) // delete said min from right subtree
        }
    }
    
    return root
    
    func findMin(_ root: TreeNode?) -> TreeNode? {
        guard var cur = root else { return nil }
        while cur != nil && cur.left != nil {
            cur = cur.left!
        }
        return cur
    }
}

//94. Binary Tree Inorder Traversal
//https://leetcode.com/problems/binary-tree-inorder-traversal/description/
func inorderTraversal(_ root: TreeNode?) -> [Int] {
    var res: [Int] = []
    inorder(root)
    return res
    func inorder(_ root: TreeNode?) {
        if root == nil { return }
        inorder(root?.left)
        res.append(root!.val)
        inorder(root?.right)
    }
}



