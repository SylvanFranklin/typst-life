#import "utils.typ": *;

#let n = 36
#let cell-size = 0.4cm
#let board = setups.glider-gun

#let neighbors = ((i, j)) => (
  range(-1, 2)
    .map(x => { range(-1, 2).map(y => { if not (x == 0 and y == 0) { (i + x, j + y) } }) })
    .join()
    .filter(e => e != none and e.at(0) >= 0 and e.at(0) <= n and e.at(1) >= 0 and e.at(1) <= n)
)

#let life = b => (
  freqs(b.map(point => neighbors(point)).join())
    .filter(fr => (fr.at(1) == 2 and b.contains(fr.at(0))) or fr.at(1) == 3)
    .map(a => a.at(0))
)

#let to-cell = c => box(
  fill: if c == 1 { white } else { black },
  width: cell-size,
  height: cell-size,
)

#let draw-board = b => {
  grid(rows: n, columns: n, ..(
      range(n).map(x => range(n).map(y => (x, y))).join().map(((x, y)) => if b.contains((x, y)) { 1 } else { 0 })
    ).map(to-cell))
}

#for _ in range(10) {
  page[#place(center + horizon)[#draw-board(board)]]
  board = life(board)
}
