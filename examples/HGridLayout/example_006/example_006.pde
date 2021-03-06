HDrawablePool pool;
HOscillator h;
int tick = 0;
float scale = 0;
float r = 0;

void setup() {
	size(640,640, P3D);
	H.init(this).background(#202020).use3D(true);
	smooth();
	lights();

	h = new HOscillator()
		.range(0.2, 2.5)
		.speed(10)
		.freq(2)
	;

	pool = new HDrawablePool(125);
	pool.autoAddToStage()
		.add (
			new HBox()
				.depth(25)
				.width(25)
				.height(25)
		)

		.layout (
			new HGridLayout()
			.startX(180)
			.startY(180)
			.startZ(-140)
			.spacing(70, 70, 70)
			.cols(5)
			.rows(5)
		)

		.requestAll()
	;
}

void draw() {
	translate(width/2, height/2);
	rotateY(radians(r));
	translate(-width/2, -height/2);

	int i = 0;

	for (HDrawable d : pool) {

		h.currentStep(tick + i * 3);

		HBox b = (HBox) d;

		h.nextRaw();
		scale = h.curr();

		b.width(25 * scale);
		b.height(25 * scale);
		b.depth(25 * scale);

		i++;
	}

	H.drawStage();

	tick++;

	r+= 0.3;

}