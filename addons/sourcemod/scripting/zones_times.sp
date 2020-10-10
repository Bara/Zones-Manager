//Pragma
#pragma semicolon 1
#pragma newdecls required

#include <sourcemod>
#include <zones_manager>

float g_fTime[MAXPLAYERS + 1] = 0.0;

public Plugin myinfo =
{
	name = "Zones Manager - Test Times",
	author = "Bara",
	description = "A simple plugin to test the zones manager plugin and its API interface.",
	version = "1.1.0",
	url = "github.com/Bara"
};

public Action ZonesManager_OnStartTouchZone(int client, int entity, const char[] zone_name, int type)
{
	PrintToChat(client, "StartTouch: Entity: %i - Name: %s - Type: %i", entity, zone_name, type);

	if (g_fTime[client] > 0.0 && StrContains(zone_name, "End", false) != -1)
	{
		PrintToChat(client, "Time: %f", (GetGameTime() - g_fTime[client]));
		g_fTime[client] = 0.0;
	}

	return Plugin_Continue;
}

public Action ZonesManager_OnEndTouchZone(int client, int entity, const char[] zone_name, int type)
{
	PrintToChat(client, "EndTouch: Entity: %i - Name: %s - Type: %i", entity, zone_name, type);

	if (StrContains(zone_name, "Start", false) != -1)
	{
		g_fTime[client] = GetGameTime();
	}

	return Plugin_Continue;
}
