structure Graph =
struct
    open Draw
    fun tick (min, max) =
        let
            val w = (max - min) / 2.0
            val e = Math.pow (10.0, Real.realFloor (Math.log10 w))
            val s = w / e
            val step = if s >= 15.0 then 5.0 * e
                       else if s >= 2.0 then 2.0 * e
                       else e
        in
            {min = Real.realFloor (min / step) * step, step = step}
        end;
    fun tickLabel r = Real.fmt (StringCvt.GEN (SOME 4)) r;
    fun ticks max min step scale offset =
        List.tabulate
            (trunc ((max - min) / step + 1.00001),
             fn i => (step * real i * scale + offset, tickLabel (step * real i + min)))
    fun drawAxes points =
        let
            val xmax = foldl Real.max Real.negInf (map #x points)
            val xmin = foldl Real.min Real.posInf (map #x points)
            val ymax = foldl Real.max Real.negInf (map #y points)
            val ymin = foldl Real.min Real.posInf (map #y points)
            val {min = xmin, step = xstep} = tick (xmin, xmax)
            val {min = ymin, step = ystep} = tick (ymin, ymax)
            val xscale = 0.8 / (xmax - xmin)
            val yscale = ~0.8 / (ymax - ymin)
            val xoffset = 0.1 + 0.025
            val yoffset = 0.9 - 0.025
            val xs = ticks xmax xmin xstep xscale xoffset
            val ys = ticks ymax ymin ystep yscale yoffset
            val xt = map (fn (x, _) => LINES [(x, 0.9), (x, 0.93)]) xs
            val yt = map (fn (y, _) => LINES [(0.07, y), (0.1, y)]) ys
            val xl = map (fn (x, s) => TEXT (x, 0.96, s)) xs
            val yl = map (fn (y, s) => MOVE (0.04, y,
                                             ROTATE (270.0, TEXT (0.0, 0.0, s)))) ys

        in
            {xpos = fn x => (x - xmin) * xscale + xoffset,
             ypos = fn y => (y - ymin) * yscale + yoffset,
             obj = [STROKE (COMBINE [RECT (0.1, 0.05, 0.85, 0.85),
                                      COMBINE xt, COMBINE yt]),
                    FILL (COMBINE [COMBINE xl, COMBINE yl])]
            }
        end;

    fun plot points =
        let
            val {xpos, ypos, obj} = drawAxes points
            val ps = map (fn {x, y} => CIRCLE (xpos x, ypos y, 0.01))
                         points
        in
            STROKE (COMBINE ps) :: obj
        end;

    (* TODO: implement *)

    fun ticksHistogram max min step scale offset =
        List.tabulate
            (
              trunc ((max - min) / step + 1.00001),
             fn i => (step * real i * scale + offset, tickLabel (step * real i + min)))
    fun drawAxesForHistogram points =
        let
            val xmax = foldl Real.max Real.negInf (map #x points)
            val xmin = foldl Real.min Real.posInf (map #x points)
            val xscale = 0.8 / (xmax - xmin)
            val xoffset = 0.1 + 0.025
            val {min = xmin, step = xstep} = tick (xmin, xmax)
            val xs = ticks xmax xmin xstep xscale xoffset

            val histogram =
                List.tabulate
                    (
                      10,
                      fn i => foldl (fn ({x=v}, c) =>
                                        if real i * xstep <= v andalso v < (real i + 1.0) * xstep
                                        then c + 1.0
                                        else c) 0.0 points

                    )
            val ymax = (*foldl Real.max Real.negInf (ticks (xmax, xmin))*)
            (*foldl Real.max Real.negInf (tick (xmin, xmax))*)  (* y が渡されていないから最大値はどうやって計測する？ -> xから計測するしかなくね？ *)
            (* -> pointsから計測するしかない -> ticks みたいなのが欲しい *)
            (* -> cfhttps://github.com/lambdataro/misc-smlsharp-codes/blob/02eed674f4d43be12b45b2bd88b599484e6f1c69/mlpractice-exersises/dbplot/Graph.sml#L75*)
                foldl Real.max Real.negInf histogram;
            val ymin = 0.0
            val {min = ymin, step = ystep} = tick (ymin, ymax)
            val yscale = ~0.8 / (ymax - ymin)
            val yoffset = 0.9 - 0.025
            val ys = ticks ymax ymin ystep yscale yoffset
            val xt = map (fn (x, _) => LINES [(x, 0.9), (x, 0.93)]) xs
            val yt = map (fn (y, _) => LINES [(0.07, y), (0.1, y)]) ys
            val xl = map (fn (x, s) => TEXT (x, 0.96, s)) xs
            val yl = map (fn (y, s) => MOVE (0.04, y,
                                             ROTATE (270.0, TEXT (0.0, 0.0, s)))) ys
        in
            {xpos = fn x => (x - xmin) * xscale + xoffset,
             ypos = fn y => (y - ymin) * yscale + yoffset,
             obj = [STROKE (COMBINE [RECT (0.1, 0.05, 0.85, 0.85),
                                      COMBINE xt, COMBINE yt]),
                    FILL (COMBINE [COMBINE xl, COMBINE yl])
                   ],
             histogram = histogram,
             xstep = xstep
            }
        end;
    fun histogram points =
        let
            val {xpos, ypos, obj, histogram, xstep} = drawAxesForHistogram points
            fun bar x height = RECT (xpos x - 0.01, ypos height, 0.02, ypos 0.0 - ypos height)
            val histogramObjs =
                List.tabulate
                    (10, fn i => bar (real i * xstep) (List.nth (histogram, i)))
        in
            obj @ [STROKE (COMBINE histogramObjs)]
        end;
end
