#let n = 18
#let board = range(n).map(_ => range(n).map(_ => 0))
#let cell-size = 4cm
#set page(width: (n + 3) * cell-size, height: cell-size * (n + 3), margin: 0em)

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
  let neighbors = (i, j) => {
    range(-1, 2)
      .map(x => {
        range(-1, 2).map(y => {
          if not (x == 0 and y == 0) and i + x >= 0 and i + x < b.len() and j + y >= 0 and j + y < b.at(0).len() {
            (i + x, j + y)
          }
        })
      })
      .join()
      .filter(e => e != none)
      .map(((x, y)) => b.at(x).at(y))
  }

  range(b.len()).map(i => {
    range(b.at(i).len()).map(j => {
      let live = neighbors(i, j).filter(calc.odd).len()
      if live == 2 { b.at(i).at(j) } else if live == 3 { 1 } else { 0 }
    })
  })
}

#let to-cell = c => box(
  fill: if c == 1 { white } else { black },
  width: cell-size,
  height: cell-size,
)

#for _ in range(20) {
  page[#align(center + horizon)[#grid(rows: n, columns: n, ..board.flatten().map(to-cell)) ] ]
  board = life(board)
}
