import Foundation

//994. Rotting Oranges
//https://leetcode.com/problems/rotting-oranges/description/
func orangesRotting(_ grid: [[Int]]) -> Int {
    var fresh = 0, time = 0, grid = grid
    var q = [(Int,Int)]() //r,c of rotten orenges
    let rows = grid.count, cols = grid[0].count
    var dir = [(0,1),(0,-1),(1,0),(-1,0)]
    for r in 0..<rows {
        for c in 0..<cols {
            if grid[r][c] == 1 { fresh += 1 }
            if grid[r][c] == 2 { q.append((r,c))}
        }
    }
    while !q.isEmpty && fresh > 0 {
        for _ in 0..<q.count {
            let (r,c) = q.removeFirst()
            for (dr,dc) in dir {
                if r+dr < rows && r+dr >= 0 && dc+c < cols && dc+c >= 0
                    && grid[r+dr][c+dc] == 1 { //if in counds and fresh, rot
                    grid[r+dr][c+dc] = 2
                    fresh -= 1
                    q.append((r+dr,c+dc))
                }
            }
        }
        time += 1
    }
    return fresh == 0 ? time : -1
}
