#let cells = 18
#let cell-size = 4cm
// #let cellsize = 20
#set page(width: (cells + 3) * cell-size, height: cell-size * (cells + 3), margin: 0em)
#let board = range(cells).map(i => range(cells).map(j => 0))
#{
  board.at(3).at(3) = 1
  board.at(3).at(4) = 1
  board.at(3).at(5) = 1
  board.at(2).at(5) = 1
  board.at(1).at(4) = 1
  board.at(10).at(7) = 1
  board.at(11).at(7) = 1
  board.at(12).at(7) = 1
}


#let life = b => {
  let newboard = ()
  for row in range(b.len()) {
    let newrow = ()
    for cell in range(b.at(row).len()) {
      let neighbors = ()
      for x in range(-1, 2) {
        for y in range(-1, 2) {
          if not (x == 0 and y == 0) {
            let ni = row + x
            let nj = cell + y
            if ni >= 0 and ni < b.len() and nj >= 0 and nj < b.at(0).len() {
              neighbors.push(b.at(ni).at(nj))
            }
          }
        }
      }
      let livecount = 0
      for n in neighbors {
        if n == 1 {
          livecount += 1
        }
      }
      let oldcell = b.at(row).at(cell)
      let newcell = 0
      if livecount < 2 { newcell = 0 } else if livecount == 3 { newcell = 1 } else if livecount == 2 {
        newcell = oldcell
      } else if livecount > 3 { newcell = 0 }

      newrow.push(newcell)
    }
    newboard.push(newrow)
  }
  return newboard
}

#let to-cell(e) = {
  if e == 1 {
    box(fill: white, width: cell-size, height: cell-size)
  } else {
    box(fill: black, width: cell-size, height: cell-size)
  }
}


#let newboard = board
#for i in range(10) {
  page()[
    #align(center + horizon)[#grid(gutter: 0.02cm, rows: cells, columns: cells, ..newboard.flatten().map(to-cell))]
  ]
  newboard = life(newboard)
}
