StripLen = 2.5
StripCount = 10
StripStep = StripLen / StripCount

function buildTreb (world, position) {	
	
	stand1Position = new b2Vec2;
	stand1Position.SetV(position);
	
	a1 = new b2Vec2;
	a1.SetV(position);
	a1.x += 3;
	a1.y -= 3;
	
	a2 = new b2Vec2;
	a2.SetV(a1);
	a2.x += 0.5;
	a2.y -= 0.5;
	
	a3 = new b2Vec2;
	a3.SetV(a1);
	a3.x -= 2.8;
	a3.y += 2.7;
	
	a4 = new b2Vec2;
	a4.SetV(a3);
	a4.x += StripLen;
	
	
	// build stand
	fixIron.shape = new b2PolygonShape;
	fixIron.shape.SetAsArray([
			new b2Vec2(0, 0),
			new b2Vec2(0, -0.2),
			new b2Vec2(2.9, -0.2),
			new b2Vec2(2.9, -3.1),
			new b2Vec2(3.1, -3.1),
			new b2Vec2(3.1, -0.2),
			new b2Vec2(6, -0.2),
			new b2Vec2(6, 0)
	]);
	sBodyDef.position = stand1Position;
	s1 = world.CreateBody(sBodyDef);
	s1.CreateFixture(fixIron);

	// build arm
	fixWood.shape = new b2PolygonShape;
	fixWood.shape.SetAsArray([
			new b2Vec2(-2.8, 2.8),
			new b2Vec2(-2.8, 2.7),
			new b2Vec2(0.5, -0.5),
			new b2Vec2(0.5, -0.4)
	]);
	dBodyDef.position = a1;
	s2 = world.CreateBody(dBodyDef);
	s2.CreateFixture(fixWood);	
	
	// build heavy
	fixIron.shape = new b2PolygonShape;
	fixIron.shape.SetAsArray([
			new b2Vec2(-0.05, -0.05),
			new b2Vec2(0.05, -0.05),
			new b2Vec2(0.4, 1),
			new b2Vec2(-0.4, 1)
	]);
	dBodyDef.position = a2;
	s3 = world.CreateBody(dBodyDef);
	s3.CreateFixture(fixIron);	
	
	// build hand
	aa = new b2Vec2;
	aa.SetV(a3);
	
	for(i = 0; i < StripCount; i++){
		fixWood.shape = new b2PolygonShape;
		fixWood.shape.SetAsArray([
				new b2Vec2(i * StripStep, -0.01),
				new b2Vec2((1+i) * StripStep, -0.01),
				new b2Vec2((1+i) * StripStep, 0.01),
				new b2Vec2(i * StripStep, 0.01)
		]);
		
		dBodyDef.position = a3;
		s4 = world.CreateBody(dBodyDef);
		s4.CreateFixture(fixWood);
		
		var tmpJ = new b2RevoluteJointDef();
		if(i == 0) {
			tmpJ.Initialize(s2,s4,a3);
			world.CreateJoint(tmpJ);
		}
		else {
			tmpJ.Initialize(slast,s4,aa);
			world.CreateJoint(tmpJ);
		}
		
		aa.x += StripStep;
		slast = s4
		strend = s4
	}
		
	
	// build cannon
	fixStone.shape = new b2CircleShape(0.15);
	dBodyDef.position = a4;
	var objid = 119;
	s5 = world.CreateBody(dBodyDef);
	s5.SetUserData(objid);
	s5.CreateFixture(fixStone);
	hand = s5
	
	//////////////////////////////////////////////////
	var revoluteJointDef = new b2RevoluteJointDef();
	revolutePoint = new b2Vec2;
	
	revolutePoint.SetV(a1);
	revoluteJointDef.Initialize(s1,s2,revolutePoint);
	world.CreateJoint(revoluteJointDef);
	
	revolutePoint.SetV(a2);
	revoluteJointDef.Initialize(s3,s2,revolutePoint);
	world.CreateJoint(revoluteJointDef);
	
	revolutePoint.SetV(a4);
	revoluteJointDef.Initialize(strend,s5,revolutePoint);
	handPower = world.CreateJoint(revoluteJointDef);

	return s1;
}
