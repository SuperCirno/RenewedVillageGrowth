/*
 * This file is part of Renewed Village Growth, a GameScript for OpenTTD.
 * Credits keoz (Renewed City Growth), Sylf (City Growth Limiter)
 *
 * It's free software: you can redistribute it and/or modify it under
 * the terms of the GNU General Public License as published by the
 * Free Software Foundation, version 2 of the License.
 *
 */


require("version.nut");

class MainClass extends GSInfo
	{
	function GetAuthor()		{ return "Firrel"; }
	function GetName()			{ return "Renewed Village Growth"; }
	function GetShortName() 	{ return "REVI"; }
	function GetDescription()	{ return "A combination of Renewed City Growth GS and City Growth Limiter GS. Towns require various cargo delivery to grow. Town growth is limited by percentage of transported PAX/mail. Supporting Baseset, FIRS, ECS, YETI, NAIS industries. See the readme.txt for detailed description."; }
	function GetURL()			{ return "https://www.tt-forums.net/viewtopic.php?f=65&t=87052"; }
	function GetVersion()		{ return SELF_VERSION; }
	function GetDate()			{ return "2020-05-17"; }
	function GetAPIVersion()	{ return "1.10"; }
	function MinVersionToLoad()	{ return 1; }
	function CreateInstance()	{ return "MainClass"; }
	function GetSettings() {

		AddSetting({ name = "town_info_mode",
				description = "Town info display mode",
				easy_value = 1,
				medium_value = 1,
				hard_value = 1,
				custom_value = 1,
				flags = CONFIG_INGAME, min_value = 1, max_value = 3 });
		AddLabels("town_info_mode", { 
					_1 = "Automatic",
					_2 = "Cargo information",
					_3 = "Limiter information" });
	
		AddSetting({ name = "industry_NewGRF",
				description = "Which industry set is being used?",
				easy_value = 1,
				medium_value = 1,
				hard_value = 1,
				custom_value = 1,
				flags = CONFIG_NONE, min_value = 1, max_value = 18 });
		AddLabels("industry_NewGRF", { 
					_1 = "Baseset: Temperate",
					_2 = "Baseset: Arctic",
					_3 = "Baseset: Tropical",
					_4 = "Baseset: Toyland",
					_5 = "FIRS 1.3.0: Firs economy",
					_6 = "FIRS 1.3.0: Temperate basic",
					_7 = "FIRS 1.3.0: Arctic basic",
					_8 = "FIRS 1.3.0: Tropic Basic",
					_9 = "FIRS 1.3.0: Hearth of Darkness",
					_10 = "ECS 1.2: Any Vectors",
					_11 = "YETI 0.1.6",
					_12 = "FIRS 3.0.12: Temperate Basic",
					_13 = "FIRS 3.0.12: Arctic Basic",
					_14 = "FIRS 3.0.12: Tropic Basic",
					_15 = "FIRS 3.0.12: Steeltown",
					_16 = "FIRS 3.0.12: In A Hot Country",
					_17 = "FIRS 3.0.12: Extreme",
					_18 = "NARS 1.0.6: North America" });

		AddSetting({ name = "goal_scale_factor",
				description = "Difficulty level (easy = 60, normal = 100, hard = 140)",
				easy_value = 60,
				medium_value = 100,
				hard_value = 140,
				custom_value = 100,
				flags = CONFIG_INGAME, min_value = 1, max_value = 1000, step_size = 20 });

		AddSetting({ name = "merge_cat_2_3",
				description = "Merge categories 2 (food) and 3 (goods) into one (see readme.txt)",
				easy_value = 0,
				medium_value = 0,
				hard_value = 0,
				custom_value = 0,
				flags = CONFIG_BOOLEAN });

		AddSetting({ name = "merge_cat_4_5",
				description = "Merge categories 4 (raw ind.) and 5 (trans. ind.) into one (see readme.txt)",
				easy_value = 0,
				medium_value = 0,
				hard_value = 0,
				custom_value = 0,
				flags = CONFIG_BOOLEAN });

		AddSetting({ name = "use_town_sign",
				description = "Show growth rate text under town names",
				easy_value = 1,
				medium_value = 1,
				hard_value = 1,
				custom_value = 1,
				flags = CONFIG_BOOLEAN });
				
		AddSetting({ name = "eternal_love",
				description = "Eternal love from towns",
				easy_value = 0,
				medium_value = 0,
				hard_value = 0,
				custom_value = 0,
				flags = CONFIG_INGAME, min_value = 0, max_value = 3 });
		AddLabels("eternal_love", { _0 = "Off",
					_1 = "Outstanding",
					_2 = "Good",
					_3 = "Poor" });

		AddSetting({
			name = "min_transport_pax",
			description = "Limit Growth: Minimun Percentage of Passengers Transported",
			easy_value = 65,
			medium_value = 65,
			hard_value = 65,
			custom_value = 65,
			flags = CONFIG_INGAME,
			min_value = 0,
			max_value = 90,
			step_size = 5});
			
		AddSetting({
			name = "min_transport_mail",
			description = "Limit Growth: Minimun Percentage of Mail Transported",
			easy_value = 65,
			medium_value = 65,
			hard_value = 65,
			custom_value = 65,
			flags = CONFIG_INGAME,
			min_value = 0,
			max_value = 90,
			step_size = 5});
			
		AddSetting({
			name = "town_size_threshold",
			description = "Limit Growth: Minimum size of town before the limit rules kicks in",
			easy_value = 350,
			medium_value = 350,
			hard_value = 350,
			custom_value = 350,
			flags = CONFIG_INGAME, min_value = 0,
			max_value = 3000,
			step_size = 25});

		AddSetting({ name = "town_growth_factor",
				description = "Expert: town growth factor",
				easy_value = 100,
				medium_value = 100,
				hard_value = 100,
				custom_value = 100,
				flags = CONFIG_INGAME, min_value = 20, max_value = 1000, step_size = 20 });

		AddSetting({ name = "supply_impacting_part",
				description = "Expert: minimum supply percentage for TGR growth",
				easy_value = 50,
				medium_value = 50,
				hard_value = 50,
				custom_value = 50,
				flags = CONFIG_INGAME, min_value = 0, max_value = 100, step_size = 5 });

		AddSetting({ name = "exponentiality_factor",
				description = "Expert: TGR growth exponentiality factor",
				easy_value = 3,
				medium_value = 3,
				hard_value = 3,
				custom_value = 3,
				flags = CONFIG_INGAME, min_value = 1, max_value = 5 });

		AddSetting({ name = "lowest_town_growth_rate",
				description = "Expert: slowest TGR if requirements are not met",
				easy_value = 880,
				medium_value = 880,
				hard_value = 880,
				custom_value = 880,
				flags = CONFIG_INGAME, min_value = 10, max_value = 880, step_size = 10 });
				
		AddSetting({ name = "log_level",
				description = "Debug: Log level (higher = print more)",
				easy_value = 1,
				medium_value = 1,
				hard_value = 1,
				custom_value = 1,
				flags = CONFIG_INGAME, min_value = 1, max_value = 3 });
		AddLabels("log_level", { _1 = "1: Info", _2 = "2: Cargo", _3 = "3: Debug" });
	}
}

RegisterGS(MainClass());
