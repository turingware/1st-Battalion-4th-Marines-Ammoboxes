/*
fn_crate
grab mar crate config data and apply it
fight9

params:
_this: object - the crate
*/

#include "\Marine_Ammoboxes\script_macros.hpp"

private ["_crate","_cfg"];
// params
_crate = param [0,objNull,[[],objNull]];

// check
if (isNull _crate) exitWith {false};

// damage
_crate allowDamage false;

// config
_cfg = configFile >> "CfgVehicles" >> typeOf _crate;

// manager
if ([_cfg,"mar_MANAGER",0] call BIS_fnc_returnConfigEntry > 0) then {
	_LOM = ["init",[_crate]] call mar_fnc_manager;
};

// loadouts
{
	_crate addAction [
		("<t color=""#DB3503"">" + (_x select 0) + "</t>"),
		mar_LOADOUT_ROOT + (_x select 1),
		[],
		3,
		true,
		true,
		"",
		"_this distance _target < 10 && vehicle player == player"
	];
} forEach ([_cfg,"mar_LOADOUTS",[]] call BIS_fnc_returnConfigEntry);

true