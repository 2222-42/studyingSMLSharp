(* 準備 *)
(* 三次元ベクトルの型と操作 *)
type vec = real * real * real;
fun add (x1, y1, z1) (x2, y2, z2) : vec =
    (x1 + x2, y1 + y2, z1 + z2);
fun sub (x1, y1, z1) (x2, y2, z2) : vec =
    (x1 - x2, y1 - y2, z1 - z2);
fun dot (x1, y1, z1) (x2, y2, z2) : real =
    x1 * x2 + y1 * y2 + z1 * z2;
fun scale s (x, y, z) : vec =
    (x * s, y * s, z * s);
fun normal v =
    scale (1.0 / Math.sqrt (dot v v)) v;

(* 半直線; 方向を表すベクトルは単位ベクトルとする *)
type ray = {orig: vec, dir: vec};

(* 球 *)
type sphere = {center: vec, radius: real};
val dummySphere = {center = (0.0, 0.0, 0.0), radius = 0.0};

(* 画像の大きさ *)
val width = 1024;
val height = 1025;
(* 視点 *)
val eye = (0.0, 0.0, 5.0);
(* 光源 *)
val light = normal (1.0, 1.0, 1.0);

(* 描画する対象の球の集合 *)
fun tree 0 _ _ = nil
  | tree l r (c as (x, y, z)) =
    let
        val d = 0.8 * r
    in
        {center = c, radius = r}
        :: tree (l - 1) (0.5 * r) (x - d, y - d, z + d)
        @ tree (l - 1) (0.5 * r) (x + d, y - d, z + d)
    end;
val scene = tree 4 1.0 (0.0, 0.6, 0.0);

(* レイトレーシングするプログラム  *)
(* 画素(x,y)に対する視線を求めるための方向を計算 *)
(* TODO: 視点sがないのに以下の関数でどうやって求めるのかを調べる *)
(* TODO: この関数の意図(0.5ってなに？とか)がよくわかっていないのでちゃんと調べる *)
fun primary (x, y) =
    normal (real x + 0.5 - real width / 2.0,
            ~(real y + 0.5 - real width / 2.0),
            ~(real height));
(* 視線と級の交点 *)
fun ray_sphere {orig, dir} {center, radius} =
    let
        val v = sub orig center
        val b = dot dir v
        val s = b * b - dot v v + radius * radius
        val t = ~b - Math.sqrt s
    in
        if t >= 0.0 then t else Real.posInf
    end;

(* 視線から、視点に最も近い球との交点および交点における法線ベクトルnを求める *)
fun intersect (ray as {orig, dir}) =
    let
        val (t, {center, ...}) =
            foldl (fn (x, z) => if #1 x < #1 z then x else z)
                  (Real.posInf, dummySphere)
                  (map (fn s => (ray_sphere ray s, s)) scene)
        val p = add orig (scale t dir)
        val n = normal (sub p center)
    in
        (t, p, n)
    end;

(* 交点に光が届いていることを確認;光が無限遠の光源から一様に降り注いでいるものとする *)
(* 光が届いているための2つの条件 *)
(* 1. 法線に対する光の入射角が90度未満であること; n と lightとの内積を求める *)
(* 2. 交点から光源までの間に光を遮る物体がないこと *)
fun shadow p =
    #1 (intersect {orig = p, dir = light}) < Real.posInf;

(* 放射輝度 *)
fun pixel pos =
    let
        val ray = {orig = eye, dir = primary pos}
        val (t, p, n) = intersect ray
    in
        if t >= Real.posInf then 0.0
        else
            let
                val v = dot n light (* ランベルトの余弦則より *)
            in
                if v <= 0.0 orelse shadow p then 0.0
                else v
            end
    end;

(* 画像データ *)
val image = Word8Array.array (width * height, 0w0);

(* 画像の座標に輝度`r`を書き込む *)
fun set (x, y) r =
    Word8Array.update
        (image, x + width * y, Word8.fromInt (Int.min (trunc (r * 255.0), 255)));

(* 幅w, 高さhの範囲のレイトレーシングを行い画素を書き込むループ *)
fun loop (x, w) f =
    if w <= 0 then () else (f x; loop (x + 1, w - 1) f);
fun rayTrace (x, y, w, h) =
    loop (y, h)
         (fn y =>
             loop (x, w)
                  (fn x => set (x, y) (pixel (x, y)))
         );

(* 生成した画像をPNM形式でファイルに出力する  *)
fun writeImage filename =
    let
        val f = BinIO.openOut filename
        val w = Int.toString width
        val h = Int.toString height
        val head = "P5\n" ^ w ^ " " ^ h ^ " 255\n"
    in
        BinIO.output (f, Byte.stringToBytes head);
        BinIO.output (f, Word8Array.vector image);
        BinIO.closeOut f
    end;

val _ = rayTrace (0, 0, width, height)
val _ = writeImage "out.ppm"
