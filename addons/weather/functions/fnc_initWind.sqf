/*
 * Author: Ruthberg
 *
 * Inits the wind variables on mission start
 *
 * Argument:
 * None
 *
 * Return value:
 * None
 */
#include "script_component.hpp"

private ["_j", "_i", "_directionFound", "_month", "_windDirectionProbabilities"];
_month = date select 1;
_windDirectionProbabilities = GVAR(WindDirectionProbabilities) select (_month - 1);

ACE_wind = [0, 0, 0];
 
GVAR(wind_direction_reference) = random 360;
_directionFound = false;
for "_j" from 0 to 10 do {
     _random = random 1;
    for "_i" from 0 to 7 do {
        if (_random < (_windDirectionProbabilities select _i)) exitWith {
            _directionFound = true;
            GVAR(wind_direction_reference) = 45 * _i;
        };
    };
    if (_directionFound) exitWith {};
};
GVAR(wind_mean_dir) = GVAR(wind_direction_reference);
GVAR(wind_direction_reference) = GVAR(wind_direction_reference) + (random 22.5) - (random 22.5);
GVAR(wind_direction_reference) = (360 + GVAR(wind_direction_reference)) % 360;

GVAR(min_wind_speed) = GVAR(WindSpeedMin) select (_month - 1);
GVAR(min_wind_speed) = (GVAR(min_wind_speed) select 0) + (random (GVAR(min_wind_speed) select 1)) - (random (GVAR(min_wind_speed) select 1));
GVAR(min_wind_speed) = 0 max GVAR(min_wind_speed);
GVAR(mean_wind_speed) = GVAR(WindSpeedMean) select (_month - 1);
GVAR(max_wind_speed) = GVAR(WindSpeedMax) select (_month - 1);
GVAR(max_wind_speed) = (GVAR(max_wind_speed) select 0) + (random (GVAR(max_wind_speed) select 1)) - (random (GVAR(max_wind_speed) select 1));
GVAR(max_wind_speed) = 0 max GVAR(max_wind_speed);

GVAR(current_wind_direction) = GVAR(wind_direction_reference);
GVAR(current_wind_speed) = GVAR(min_wind_speed) + (GVAR(max_wind_speed) - GVAR(min_wind_speed)) * (random 1);

GVAR(wind_period_count) = 0;
GVAR(wind_next_period) = -1;

GVAR(wind_speed_debug_output) = [];
