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

//230. Kth Smallest Element in a BST
//https://leetcode.com/problems/kth-smallest-element-in-a-bst/description/
func kthSmallest(_ root: TreeNode?, _ k: Int) -> Int {
    var res: [Int] = []
    inorder(root)
    return res[k-1]
    func inorder(_ root: TreeNode?) {
        guard let root = root else { return }
        inorder(root.left)
        res.append(root.val)
        inorder(root.right)
    }
}

//226. Invert Binary Tree
//https://leetcode.com/problems/invert-binary-tree/description/
func invertTree(_ root: TreeNode?) -> TreeNode? {
    guard let root = root else { return nil }
    let temp = root.right
    root.right = root.left
    root.left = temp
    invertTree(root.right)
    invertTree(root.left)
    return root
}

//104. Maximum Depth of Binary Tree
//https://leetcode.com/problems/maximum-depth-of-binary-tree/description/
func maxDepth(_ root: TreeNode?) -> Int {
    guard let root = root else { return 0 }
    return 1 + max(maxDepth(root.right), maxDepth(root.left))
}

//105. Construct Binary Tree from Preorder and Inorder Traversal
//https://leetcode.com/problems/construct-binary-tree-from-preorder-and-inorder-traversal/description/
func buildTree(_ preorder: [Int], _ inorder: [Int]) -> TreeNode? {
    //first val in preorder is always the root
    //next val is the root of the left subtree
    if preorder.isEmpty || inorder.isEmpty { return nil } //base case
    let root = TreeNode(preorder[0]) //first val is always the root
    guard let mid = inorder.firstIndex(of: preorder[0]) else { return nil }
    // partition the arr to get left and write subtrees
    
    root.left = buildTree(Array(preorder[1..<mid+1]), //Array(preorder[1...0]) invalid! as [1...mid] but 1..<mid+1 is valid 1..<1
                          Array(inorder[0..<mid]))
    root.right = buildTree(Array(preorder[mid+1..<preorder.count]),
                           Array(inorder[mid+1..<inorder.count]))
    return root
}
