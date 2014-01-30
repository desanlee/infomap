function buildTreb (world, position) {	
	stand1Position = new b2Vec2;
	stand1Position.SetV(position);
	
	a1 = new b2Vec2;
	a1.SetV(position);
	a1.x += 5;
	a1.y -= 2;
	
	a2 = new b2Vec2;
	a2.SetV(position);
	a2.x += 4.5;
	a2.y -= 2;
	
	a3 = new b2Vec2;
	a3.SetV(a2);
	a3.x += 1;
	
	a4 = new b2Vec2;
	a4.SetV(a2);
	a4.x -= 4;
	a4.y += 0.1;
	
	a5 = new b2Vec2;
	a5.SetV(a4);
	a5.x += 0.5;
	a5.y += 0.1
	
	// build stand
	fixIron.shape = new b2PolygonShape;
	fixIron.shape.SetAsArray([
			new b2Vec2(0, 0),
			new b2Vec2(0, -0.1),
			new b2Vec2(3, -0.1),
			new b2Vec2(4.9, -2),
			new b2Vec2(5.1, -2),
			new b2Vec2(4, -0.1),
			new b2Vec2(6, -0.1),
			new b2Vec2(6, 0)
	]);
	sBodyDef.position = stand1Position;
	s1 = world.CreateBody(sBodyDef);
	s1.CreateFixture(fixIron);

	// build arm
	fixWood.shape = new b2PolygonShape;
	fixWood.shape.SetAsArray([
			new b2Vec2(-4.05, -0.01),
			new b2Vec2(1.05, -0.01),
			new b2Vec2(1.05, 0.01),
			new b2Vec2(-3.95, 0.01),
			new b2Vec2(-3.95, 0.15),
			new b2Vec2(-4.05, 0.15)
	]);
	dBodyDef.position = a2;
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
	dBodyDef.position = a3;
	dBodyDef.userData = document.getElementById("crate");
	s3 = world.CreateBody(dBodyDef);
	dBodyDef.userData = 0;
	s3.CreateFixture(fixIron);	
	
	// build hand
	fixWood.shape = new b2PolygonShape;
	fixWood.shape.SetAsArray([
			new b2Vec2(-0.05, -0.01),
			new b2Vec2(0.5, -0.01),
			new b2Vec2(0.5, 0.01),
			new b2Vec2(-0.05, 0.01)
	]);
	dBodyDef.position = a4;
	s4 = world.CreateBody(dBodyDef);
	s4.CreateFixture(fixWood);	
	hand = s4
	
	// build cannon
	fixStone.shape = new b2CircleShape(0.15);
	dBodyDef.position = a5;
	
	s5 = world.CreateBody(dBodyDef);
	s5.CreateFixture(fixStone);
	
	
	//////////////////////////////////////////////////
	var revoluteJointDef = new b2RevoluteJointDef();
	revolutePoint = new b2Vec2;
	
	revolutePoint.SetV(a1);
	revoluteJointDef.Initialize(s1,s2,revolutePoint);
	world.CreateJoint(revoluteJointDef);
	
	revolutePoint.SetV(a3);
	revoluteJointDef.Initialize(s3,s2,revolutePoint);
	world.CreateJoint(revoluteJointDef);
	
	revolutePoint.SetV(a4);
	revoluteJointDef.Initialize(s2,s4,revolutePoint);
	world.CreateJoint(revoluteJointDef);
	
	revolutePoint.SetV(a5);
	revoluteJointDef.Initialize(s5,s4,revolutePoint);
	handPower = world.CreateJoint(revoluteJointDef);

	return s1;
}

function buildTrebOld (world, position) {	
	stand1Position = new b2Vec2;
	stand1Position.SetV(position);
	
	a1 = new b2Vec2;
	a1.SetV(position);
	a1.x += 5;
	a1.y -= 2;
	
	a2 = new b2Vec2;
	a2.SetV(position);
	a2.x += 4.5;
	a2.y -= 2;
	
	a3 = new b2Vec2;
	a3.SetV(a2);
	a3.x += 1;
	
	a4 = new b2Vec2;
	a4.SetV(a2);
	a4.x -= 4;
	a4.y -= 0.1;
	
	
	// build stand
	fixIron.shape = new b2PolygonShape;
	fixIron.shape.SetAsArray([
			new b2Vec2(0, 0),
			new b2Vec2(0, -0.1),
			new b2Vec2(3, -0.1),
			new b2Vec2(4.9, -2),
			new b2Vec2(5.1, -2),
			new b2Vec2(4, -0.1),
			new b2Vec2(6, -0.1),
			new b2Vec2(6, 0)
	]);
	dBodyDef.position = stand1Position;
	s1 = world.CreateBody(dBodyDef);
	s1.CreateFixture(fixIron);

	// build arm
	fixWood.shape = new b2PolygonShape;
	fixWood.shape.SetAsArray([
			new b2Vec2(-4.05, -0.01),
			new b2Vec2(1.05, -0.01),
			new b2Vec2(1.05, 0.01),
			new b2Vec2(-3.95, 0.01),
			new b2Vec2(-3.95, 0.15),
			new b2Vec2(-4.05, 0.15)
	]);
	dBodyDef.position = a2;
	s2 = world.CreateBody(dBodyDef);
	s2.CreateFixture(fixWood);	
	hand = s2;
	
	// build heavy
	fixIron.shape = new b2PolygonShape;
	fixIron.shape.SetAsArray([
			new b2Vec2(-0.05, -0.05),
			new b2Vec2(0.05, -0.05),
			new b2Vec2(0.4, 1),
			new b2Vec2(-0.4, 1)
	]);
	dBodyDef.position = a3;
	s3 = world.CreateBody(dBodyDef);
	s3.CreateFixture(fixIron);	
	
	
	// build cannon
	fixStone.shape = new b2CircleShape(0.15);
	dBodyDef.position = a4;
	s5 = world.CreateBody(dBodyDef);
	s5.CreateFixture(fixStone);
	
	
	//////////////////////////////////////////////////
	var revoluteJointDef = new b2RevoluteJointDef();
	revolutePoint = new b2Vec2;
	
	revolutePoint.SetV(a1);
	revoluteJointDef.Initialize(s1,s2,revolutePoint);
	world.CreateJoint(revoluteJointDef);
	
	revolutePoint.SetV(a3);
	revoluteJointDef.Initialize(s3,s2,revolutePoint);
	world.CreateJoint(revoluteJointDef);
	
	revolutePoint.SetV(a4);
	revoluteJointDef.Initialize(s5,s2,revolutePoint);
	handPower = world.CreateJoint(revoluteJointDef);

	return s1;
}