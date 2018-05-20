//argument0 is the actor performing the action
//argument1 is the button to be performed

actor = argument0;
button = argument1;

switch(button.title)
{
	//default actions --------------------------------------------
	case "END TURN":
		actor.state = "begin action";
		actor.readiedAction = "END TURN";
		actor.targetingType = "none";
		
		with(instance_create_depth(room_width/2, room_height, -2, oConfirmButton))
		{
			title = other.button.title;
			text = other.button.text;
			hotKey = other.button.hotKey;
		}
		
		wipe_nodes();
		wipe_buttons();
		
		
	break;
	
	//cleric spells --------------------------------------------
	case "HEALING WORD":
		actor.state = "begin action";
		actor.readiedAction = "Healing Word";
		actor.targetingType = "visible allies";
		actor.actionRange = 640;
		
		with(instance_create_depth(room_width/2, room_height, -2, oConfirmBox))
		{
			title = other.button.title;
			text = other.button.text;
		}
		
		wipe_nodes();
		wipe_buttons();
	break;
	
	case "GUIDING BOLT":
		actor.state = "begin action";
		actor.readiedAction = "Guiding Bolt";
		actor.targetingType = "visible enemies";
		actor.actionRange = 640;
		
		with(instance_create_depth(room_width/2, room_height, -2, oConfirmBox))
		{
			title = other.button.title;
			text = other.button.text;
		}
		
		wipe_nodes();
		wipe_buttons();
	break;
	
	case "BLESS":
		actor.state = "begin action";
		actor.readiedAction = "Bless";
		actor.targetingType = "visible allies";
		actor.actionRange = 640;
		
		with(instance_create_depth(room_width/2, room_height, -2, oConfirmButton))
		{
			title = other.button.title;
			text = other.button.text;
		}
		
		wipe_nodes();
		wipe_buttons();
	break;
	
	
	//wizard spells---------------------------------------
	case "ACID ORB":
		actor.state = "begin action";
		actor.readiedAction = "Acid Orb";
		actor.targetingType = "visible enemies";
		actor.actionRange = 640;
		
		with(instance_create_depth(room_width/2, room_height, -2, oConfirmBox))
		{
			title = other.button.title;
			text = other.button.text;
		}
		
		wipe_nodes();
		wipe_buttons();
	break;
	
	case "BURNING HANDS":
		actor.state = "begin action";
		actor.readiedAction = "Burning Hands";
		actor.targetingType = "cone";
		actor.actionRange = 96;
		
		with(instance_create_depth(room_width/2, room_height, -2, oConfirmBox))
		{
			title = other.button.title;
			text = other.button.text;
		}
		
		wipe_nodes();
		wipe_buttons();
	break;
	
	case "MAGIC MISSILES":
		actor.state = "begin action";
		actor.readiedAction = "Magic Missiles";
		actor.targetingType = "visible enemies";
		actor.actionRange = 640;
		
		with(instance_create_depth(room_width/2, room_height, -2, oConfirmButton))
		{
			title = other.button.title;
			text = other.button.text;
			
			hotKey = other.button.hotKey;
		}
		
		wipe_nodes();
		wipe_buttons();
	break;
	
	
}





















