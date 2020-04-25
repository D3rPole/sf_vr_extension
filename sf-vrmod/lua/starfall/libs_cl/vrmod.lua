if not SF.Require("vrmod") then return function() end end

--- VRmod library.
-- @name VRmod
-- @class library
-- @libtbl vr_lib
SF.RegisterLibrary("vr")
g_VR = g_VR or {}


return function(instance)
local vr_lib = instance.Libraries.vr

local vwrap, awrap = instance.Types.Vector.Wrap, instance.Types.Angle.Wrap





--- True if vrmod is active
-- @return table
function vr_lib.active()
    return g_VR.active
end

------------------------------------------------------------------------------
--Return Tracking Data--------------------------------------------------------
------------------------------------------------------------------------------

--- Gets all tracking data.
-- @return table
function vr_lib.trackingData()
    local tbl = {}
    for name, data in pairs(VRMOD_GetPoses()) do
	    tbl[name] = {
		    pos =    vwrap(data.pos),
		    vel =    vwrap(data.vel),
		    ang =    awrap(data.ang),
		    angvel = awrap(data.angvel)
	    }
    end
    return tbl
end

--- Gets HMD tracking data.
-- @return table
function vr_lib.hmdData()
    local tbl = {}
    if VRMOD_GetPoses().hmd != nil then
        data = VRMOD_GetPoses().hmd
        return {
            pos      = vwrap(data.pos),
            vel      = vwrap(data.vel),
            ang      = awrap(data.ang),
            angvel   = awrap(data.angvel)
        }
    else
        return {
            pos      = vwrap(Vector(0,0,0)),
            vel      = vwrap(Vector(0,0,0)),
            ang      = awrap(Angle(0,0,0)),
            angvel   = awrap(Angle(0,0,0))
        }
    end
end

--- Gets left controller tracking data.
-- @return table
function vr_lib.leftData()
    local tbl = {}
    if VRMOD_GetPoses().pose_lefthand != nil then
        data = VRMOD_GetPoses().pose_lefthand
        return {
            pos      = vwrap(data.pos),
            vel      = vwrap(data.vel),
            ang      = awrap(data.ang),
            angvel   = awrap(data.angvel)
        }
    else
        return {
            pos      = vwrap(Vector(0,0,0)),
            vel      = vwrap(Vector(0,0,0)),
            ang      = awrap(Angle(0,0,0)),
            angvel   = awrap(Angle(0,0,0))
        }
    end
end

--- Gets right controller tracking data.
-- @return table
function vr_lib.rightData()
    local tbl = {}
    if VRMOD_GetPoses().pose_righthand != nil then
        data = VRMOD_GetPoses().pose_righthand
        return {
            pos      = vwrap(data.pos),
            vel      = vwrap(data.vel),
            ang      = awrap(data.ang),
            angvel   = awrap(data.angvel)
        }
    else
        return {
            pos      = vwrap(Vector(0,0,0)),
            vel      = vwrap(Vector(0,0,0)),
            ang      = awrap(Angle(0,0,0)),
            angvel   = awrap(Angle(0,0,0))
        }
    end
end

---------------------------------------------------------------------------------------
--Input--------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

--- Gets all actions (controller input).
-- @return table
function vr_lib.actions()
    actions = VRMOD_GetActions()
    if g_VR.active then
        walkDir = actions.vector2_walkdirection
        steer = actions.vector2_steer
        smooth = actions.vector2_smoothturn
    
        wDir = vwrap(Vector(walkDir.x,walkDir.y,0))
        steer = vwrap(Vector(steer.x,steer.y,0))
        smootht = vwrap(Vector(smooth.x,smooth.y,0))
        return {primaryfire     = actions.boolean_primaryfire,
                secondaryfire   = actions.boolean_secondaryfire,
                leftpickup	    = actions.boolean_left_pickup,
                rightpickup     = actions.boolean_right_pickup,
                jump            = actions.boolean_jump,
                walk            = actions.boolean_walk,
                sprint          = actions.boolean_sprint,
                flashlight      = actions.boolean_flashlight,
                use             = actions.boolean_use,
                chat            = actions.boolean_chat,
                undo            = actions.boolean_undo,
                spawnmenu       = actions.boolean_spawnmenu,
                turnright       = actions.boolean_turnright,
                turnleft        = actions.boolean_turnleft,
                changeweapon    = actions.boolean_changeweapon,
                reload          = actions.boolean_reload,
                exit            = actions.boolean_exit,
                turbo           = actions.boolean_turbo,
                forward         = actions.vector1_forward,
                reverse         = actions.vector1_reverse,
                primaryfire_analog = actions.vector1_primaryfire,
                walkdirection   = wDir,
                steerdirection  = steer,
                smoothturn      = smootht,
                righthand_finger= actions.skeleton_righthand.fingerCurls,
                lefthand_finger = actions.skeleton_lefthand.fingerCurls

                }
    else
        return {}
    end
end

--- Triggers left haptic (requires user to be connected to HUD).
-- @param number delay Delay of haptic in seconds
-- @param number duration Duration of haptic in seconds
-- @param number frequency Frequency of haptic in cycles per second
-- @param number amplitude Amplitude of haptic from 0.0 to 1.0
function vr_lib.hapticLeft(delay, duration, frequency, amplitude)
    if instance:isHUDActive() then
        VRMOD_TriggerHaptic("vibration_left", delay, duration, frequency, amplitude)
    end
    return
end

--- Triggers right haptic (requires user to be connected to HUD).
-- @param number delay Delay of haptic in seconds
-- @param number duration Duration of haptic in seconds
-- @param number frequency Frequency of haptic in cycles per second
-- @param number amplitude Amplitude of haptic from 0.0 to 1.0
function vr_lib.hapticRight(delay, duration, frequency, amplitude)
    if instance:isHUDActive() then
        VRMOD_TriggerHaptic("vibration_right", delay, duration, frequency, amplitude)
    end
    return
end

end
