         var   b2Vec2 = Box2D.Common.Math.b2Vec2
            ,  b2AABB = Box2D.Collision.b2AABB
         	,	b2BodyDef = Box2D.Dynamics.b2BodyDef
         	,	b2Body = Box2D.Dynamics.b2Body
         	,	b2FixtureDef = Box2D.Dynamics.b2FixtureDef
         	,	b2Fixture = Box2D.Dynamics.b2Fixture
         	,	b2World = Box2D.Dynamics.b2World
         	,	b2MassData = Box2D.Collision.Shapes.b2MassData
         	,	b2PolygonShape = Box2D.Collision.Shapes.b2PolygonShape
         	,	b2CircleShape = Box2D.Collision.Shapes.b2CircleShape
         	,	b2DebugDraw = Box2D.Dynamics.b2DebugDraw
            ,   b2MouseJointDef =  Box2D.Dynamics.Joints.b2MouseJointDef
			,   b2DistanceJointDef =  Box2D.Dynamics.Joints.b2DistanceJointDef
			,	b2RevoluteJointDef =  Box2D.Dynamics.Joints.b2RevoluteJointDef
			,   b2WeldJointDef =  Box2D.Dynamics.Joints.b2WeldJointDef
            ;
		//define fixtures of weed, stone, cannon      
         var fixDef = new b2FixtureDef;
         fixDef.density = 3.0;	fixDef.friction = 18;	fixDef.restitution = 0.2;

		 var fixAir = new b2FixtureDef;
         fixAir.density = 0.01;	fixAir.friction = 6.5;	fixAir.restitution = 0.2;		 
		 
		 var fixSoap = new b2FixtureDef;
         fixSoap.density = 0.1;	fixSoap.friction = 0.1;	fixSoap.restitution = 0;
		 
		 var fixWood = new b2FixtureDef;
         fixWood.density = 0.01;	fixWood.friction = 0.1;	fixWood.restitution = 0;
		 
		 var fixStone = new b2FixtureDef;
         fixStone.density = 1.0;	fixStone.friction = 6;	fixStone.restitution = 0.2;
		 
		 var fixIron = new b2FixtureDef;
         fixIron.density = 8.8;	fixIron.friction = 6;	fixIron.restitution = 0.2;
		 
		//define static and dynamic body
		 var bodyDef = new b2BodyDef;
		 bodyDef.type = b2Body.b2_staticBody;
		 
		 var sBodyDef = new b2BodyDef;
		 sBodyDef.type = b2Body.b2_staticBody;
		 
		 var dBodyDef = new b2BodyDef;
		 dBodyDef.type = b2Body.b2_dynamicBody;
		 //dBodyDef.type = b2Body.b2_staticBody;
		 
		 //define bodys which can be controlled
		 var crossCtl = new b2Body;
		 var rockerCtl = new b2Body;
		 var hand = new b2Body;
		 var strend = new b2Body;
		 var handPower = new b2Body;
		 var powerReleased = false;
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 
		 