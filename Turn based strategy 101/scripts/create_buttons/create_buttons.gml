//argument0 is the actor whose buttons we are creating

actor = argument0;

buttonList = ds_list_create();

if(actor.canAct)
{
	if(actor.firstLevelSlot > 0)
	{
		for(ii =0; ii < ds_list_size(actor.firstLevelSpellList); ii+=1)
		{
			ds_list_add(buttonList, ds_list_find_value(actor.firstLevelSpellList, ii));
		}
	}
}


for(ii=0; ii < ds_list_size(actor.defaultActions); ii+=1)
{
	ds_list_add(buttonList, ds_list_find_value(actor.defaultActions, ii));
}

buttonY = room_height - 48;
buttonX = room_width/2 - ((ds_list_size(buttonList) -1) * 48);

for(ii=0; ii < ds_list_size(buttonList); ii+=1)
{
	button = ds_list_find_value(buttonList, ii);
	
	switch(button)
	{
		//Default actions----------------------------------------
		case "end turn":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -2, oButton))
			{
				
				sprite_index = sButtonEndTurn;
				title = "END TURN";
				text = "Finish turn of current character";
				hotKey = "X";
			}
		break;
		
		//cleric spells-----------------------------------------------
		case "Bless":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -2, oButton))
			{
				
				//sprite_index = sButtonEndTurn;
				title = "BLESS";
				text = "Give all party members a small bonus to attack and save rolls\n1d4 bonus (5 rounds)";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
		break;

		case "Guiding Bolt":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -2, oButton))
			{
				
				//sprite_index = sButtonEndTurn;
				title = "GUIDING BOLT";
				text = "Right-Click an enemy to fire an illuminating bolt!\n4d6 RADIANT damage\nbonus on next attack target!";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
		break;


		case "Healing Word":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -2, oButton))
			{
				
				//sprite_index = sButtonEndTurn;
				title = "HEALING WORD";
				text = "Right-Click an ally in range to heal them\n1d8" + string(other.actor.wisMod) + " HEALING";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
		break;
		
		//wizard spells-------------------------------------------------
		case "Acid Orb":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -2, oButton))
			{
				
				//sprite_index = sButtonEndTurn;
				title = "ACID ORB";
				text = "Right-click an enemy to fire an orb of deadly acid!\n3d10 ACID damage\nongoing burn";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
		break;
		
		case "Buring Hands":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -2, oButton))
			{
				
				//sprite_index = sButtonEndTurn;
				title = "BURNING HANDS";
				text = "Right-Click a square in range to emit a cone of flames!\n3d6 FIRE damage (AOE)";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
		break;
		
		case "Magic Missiles":
			with(instance_create_depth(buttonX + (ii * 96), buttonY, -2, oButton))
			{
				
				//sprite_index = sButtonEndTurn;
				title = "MAGIC MISSILES";
				text = "Fire a magic missile at each visible enemy\n1d4+1 FORCE damage\ncannot miss!";
				hotKey = string(other.ii + 1);
				
				spell = true;
				spellSlot = string(other.actor.firstLevelSlot);
			}
		break;
	}
}

ds_list_destroy(buttonList);











