// # set page(width: 210mm, height: 297mm)
#import "@preview/cetz:0.3.4": canvas, draw, tree
#import "@preview/algo:0.3.6": algo, i, d, comment, code

= Design and Analysis of Computer Algorithms

11059005 蕭耕宏

== Assignment #1

Due Mar 24, 2025 (before class)

Please use A4-sized papers to write your answers for the homework sets.

1. Show that the solution to

  $ T(n) = 2 T(floor(n/2) + 17) + n $

  is $Omicron(n log n)$.

  *Solution:*

  1. Base Case, Assume T(n) is constant for $n < n_0$

  2. Inductive hypothesis, Assume T(n) is $Omicron(n log n)$ for $n < n_0$. That is $T(k) <= c k log k$ for some constant c > 0 and k < n.

  3. Inductive step, for T(n),

    $ T(n) <= c n log n $ for some constant c > 0.

    $T(n) = 2 T(floor(n/2) + 17) + n$

    By assumption,
    
    $T(n) <= 2 c (floor(n/2) + 17) log (floor(n/2) + 17) + n$

    For large n, $floor(n/2) approx n/2$ and $log (n/2 + 17) approx log n/2 = log n - log 2$.
    
    $T(n) <= 2 c (n / 2 + 17) log (n / 2 + 17) + n$

    $approx c n (log n - log 2) + 34 c (log n - log 2) + n$

    we need this to be $<= c n log n$ for some constant c > 0.

    $c n (log n - log 2) + 34 c (log n - log 2) + n <= c n log n$

    $c n log n - c n log 2 + 34 c log n - 34 c log 2 + n <= c n log n$

    $34 c log n - c n log 2 - 34 c log 2 + n <= 0$

    $34 c (log n - log 2) - n (1 - c log 2) <= 0$

    $34 c ((log n) / n - log 2 / n) - (1 - c log 2) <= 0$

    As $n -> infinity$, $((log n) / n) -> 0$ and $log 2 / n -> 0$. 
    
    $1 - c log 2 <= 0$

    $c log 2 >= 1$

    $c >= 1 / (log 2) approx 1.44$ suppose the base of the logarithm is e.

    Therefore, $T(n) = Omicron(n log n)$ for $n >= 1.44 > 0$.


2. Draw the recursion tree for

  $ T(n) = 4 T(n / 2) + c n $, where c is a constant,

  and provide a tight asymptotic bound on its solution. Verify your bound by the substitution method.

  *Solution:*
  #let data_first_layer = (
    ([cn], [$T(n/2)$], [$T(n/2)$], [$T(n/2)$], [$T(n/2)$]) 
  )

  #let data_second_layer = (
    ([cn]),
    ([$c(n/2)$], [$T(n/4)$], [$T(n/4)$], [$T(n/4)$], [$T(n/4)$]),
    ([$c(n/2)$], [$T(n/4)$], [$T(n/4)$], [$T(n/4)$], [$T(n/4)$]),
    ([$c(n/2)$], [$T(n/4)$], [$T(n/4)$], [$T(n/4)$], [$T(n/4)$]),
    ([$c(n/2)$], [$T(n/4)$], [$T(n/4)$], [$T(n/4)$], [$T(n/4)$])
  )

  #canvas({
    import draw: *
    set-style(
      content: (padding: .2),
      fill: gray.lighten(0%),
      stroke: gray.lighten(70%),
    )

    tree.tree(
      data_first_layer,
      spread: 1,
      grow: 2,
      draw-node: (node, ..) => {
          // circle((), radius: .45, stroke: none)
          content((), node.content)
      },
      draw-edge: (from, to, ..) => {
          line(
          (a: from, number: .6, b: to),
          (a: to, number: .6, b: from),
          mark: (end: ">"),
          )
      },
      name: "tree",
    )
  })

  #canvas({
    import draw: *
    set-style(
      content: (padding: .2),
      fill: gray.lighten(0%),
      stroke: gray.lighten(70%),
    )

    tree.tree(
      data_second_layer,
      spread: 1,
      grow: 2,
      draw-node: (node, ..) => {
          // circle((), radius: .45, stroke: none)
          content((), node.content)
      },
      draw-edge: (from, to, ..) => {
          line(
          (a: from, number: .6, b: to),
          (a: to, number: .6, b: from),
          mark: (end: ">"),
          )
      },
      name: "tree",
    )
  })

  The tree height is $log_2 n$ and there are $4^(log_2 n)$ = $n^2$ leaves. 
  
  The cost of each leaf is $d n^2$ where d is a constant.
  
  For non-leaf nodes, the cost is

  $c n (1 + 2 + 2^2 + ... + 2^(log_2 n - 1)) $

  $= c n sum_(i=0)^(log_2 n - 1) 2^i $

  $= c n (n - 1) $

  In total, the cost is $d n^2 + c n (n - 1) = d n^2 + c n^2 - c n = (c+d) n^2 - c n.$

  For its asymptotic upper bound, we have

  $T(n) = (c+d) n^2 - c n <= (c+d) n^2$

  Therefore, $T(n) = Omicron(n^2)$.

  Using the substitution method, assume $T(n) <= b n^2 - c n $ for some constant b > 0 to show that $T(n) = Omicron(n^2)$.

  $T(n) = 4 T(n / 2) + c n$

  $<= 4 (b (n / 2)^2 - c (n / 2)) + c n$

  $= b n^2 - 2 c n + c n$

  $= b n^2 - c n$

  $<= b n^2$


  For its asymptotic lower bound, we have

  $T(n) = (c+d) n^2 - c n >= (c+d) n^2$

  Therefore, $T(n) = Omega(n^2)$.

  Using the substitution method, assume $T(n) >= b n^2$ for some constant b > 0 to show that $T(n) = Omega(n^2)$.

  $T(n) = 4 T(n / 2) + c n$

  $>= 4 b (n / 2)^2 + c n$

  $= b n^2 + c n$

  $= b n^2 + c n$

  $>= b n^2$

  Therefore, $T(n) = Theta(n^2)$.

3. Find the asymptotic order of the following recurrence relations. Assume that T(n) is constant for n ≤ 2. Make your bounds as tight as possible, and justify your answers.

  a. $ T(n) = 7 T(n/3) + n^2 $

  *Solution:*

  $a = 7, b = 3, f(n) = n^2 $

  $h(m) = m^2/m^(log_3 7) = Omega(m^r) $ where $r = 2-log_3 7 > 0$ (Master method case 3)

  $T(n) = n^(log_3 7) [T(1) + n^(2-log_3 7)] = n^(log_3 7) [1 + n^(2-log_3 7)] = n^(log_3 7) + n^2 $

  Therefore, $T(n) = Theta(n^2)$.


  b. $ T(n) = 4 T(n/2) + n $

  *Solution:*

  $a = 4, b = 2, f(n) = n $

  $h(m) = m/m^2 = Omicron(m^r) $ where $r = -1 < 0$ (Master method case 1)

  $T(n) = n^2 [T(1) + O(1)] = n^2 [1 + Omicron(1)] = n^2 $

  Therefore, $T(n) = Theta(n^2)$.

  c. $ T(n) = 2 T(n/2) + n^3 $

  *Solution:*

  $a = 2, b = 2, f(n) = n^3 $

  $h(m) = m^3/m = m^2 = Omega(m^r) $ where $r = 2 > 0$ (Master method case 3)

  $T(n) = n [T(1) + n^2] = n [1 + n^2] = n + n^3 $

  Therefore, $T(n) = Theta(n^3)$.

  d. $ T(n) = 4 T(n/3) + n $

  *Solution:*:

  $a = 4, b = 3, f(n) = n $

  $h(m) = m/m^(log_3 4) = Omicron(m^r) $ where $r = 1-log_3 4 < 0$ (Master method case 1)

  $T(n) = n^(log_3 4) [T(1) + Omicron(1)] = n^(log_3 4) [1 + Omicron(1)] = n^(log_3 4) $

  Therefore, $T(n) = Theta(n^(log_3 4))$.

4. Please use the Master method to find the tight asymptotic upper bound for the following recursion:

  $ T(n) = 2 T(n / 2) + n log n $.

  *Solution:*

  $a = 2, b = 2, f(n) = n log n $
  
  $h(m) = (m log m)/m = log m = Theta(log m)^i $ where $i = 1$ (Master method case 2)

  $T(n) = n [T(1) + Theta((log^2 n)/2)] = n [1 + Theta((log^2 n))/2] = n + n (log n)^2 $

  Therefore, $T(n) = Theta(n log^2 n)$.

5. Given a sequence of n distinct numbers $a_1, a_2, dots, a_n$, we define a significant inversion to be a pair $i < j$ such that $a_i > 2 a_j$. Give an $Omicron(n log n)$ algorithm to count the number of significant inversions in the given sequence of n distinct numbers $a_1, a_2, dots, a_n$.

  *Solution:*
  
  A standard merge sort algorithm can be used count the number of inversions in the sequence.
  
  To count the number of significant inversions in this case, we can dynamically store elements in a balanced BST which records the size of the left subtree of each node.
  
  1. Initialize a counter to 0.

  2. Initialize an empty BST.

  3. For each element in the sequence, count the number of elements less than $a_i / 2$ in the BST.

  4. Insert the element into the BST.

  5. Return the counter.
  
  #algo(
    title: "FindSignificantInversions",  parameters: ("A",)
  )[
    n = A.length\
    if n <= 1#i#comment[O(1)]\
      return 0#d#comment[O(1)]\
    count = 0#comment[O(1)]\
    BST = new BST()#comment[O(1)]\
    for i = n- 1 to 0#i#comment[O(n)]\
      count += BST.countLessThan(A[i] / 2)#comment[O(n log n)]\
      BST.insert(A[i])#d#comment[O(n log n)]\
    return count#comment[O(1)]
  ]
  A balanced BST without augmenting the subtree size will not be able to count the number of elements less than $a_i / 2$ in $O(log n)$ time. In the worst case, we need to traverse the entire tree to count the number of elements less than $a_i / 2$, which results in $O(n)$. By augmenting the subtree size, we can count the number of elements less than $a_i / 2$ in $O(log n)$ time.
  Since the balanced BST records the size of the left subtree, BST.countLessThan queries the BST in $O(log n)$ time. Also, the insertion of an element into the BST takes $O(log n)$ time for rebalancing. Therefore, the total time complexity of the algorithm is $O(n log n)$.

