import hype.*;
import hype.extended.colorist.HColorField;
import hype.extended.layout.HGridLayout;
import hype.extended.behavior.HOscillator;
import hype.interfaces.HCallback; // this needs to move into core/HYPE, it's used too much

HColorField   colorField;

HDrawablePool pool;
int           poolCols  = 9;
int           poolRows  = 7;
int           poolDepth = 9;

void setup() {
	size(640,640,P3D);
	H.init(this).background(#242424).use3D(true);

	colorField = new HColorField(width,height)
		.addPoint(-300,      0, #FF0066, 0.6)
		.addPoint(width-300, 0, #3300FF, 0.6)
		.fillOnly()
		// .strokeOnly()
		// .fillAndStroke()
	;

	pool = new HDrawablePool(poolCols*poolRows*poolDepth);
	pool.autoAddToStage()
		.add ( new HSphere() )
		.layout (new HGridLayout().startX(-600).startY(-450).startZ(-600).spacing(150, 150, 150).rows(poolRows).cols(poolCols))
		.onCreate (
			new HCallback() {
				public void run(Object obj) {
					int i = pool.currentIndex();

					HSphere d = (HSphere) obj;
					d.size(40).strokeWeight(0).noStroke().fill(0).anchorAt(H.CENTER);

					new HOscillator().target(d).property(H.SCALE).range(0.25, 2.5).speed(0.25).freq(10).currentStep(i*3);
				}
			}
		)
		.requestAll()
	;
}

void draw() {
	for (HDrawable d : pool) {
		d.fill(0);
		colorField.applyColor(d);
	}

	lights();
	sphereDetail(10);

	pushMatrix();
		translate(width/2, height/2, -800);
		rotateY( radians(frameCount/2) );
		H.drawStage();
	popMatrix();
}
