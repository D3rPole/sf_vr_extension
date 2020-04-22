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



------------------------------------------------------------------------------
--Return Tracking Data--------------------------------------------------------
------------------------------------------------------------------------------

--positions as Vectors

--- Gets left controller position.
-- @return vector
function vr_lib.leftPos()
    if g_VR.tracking.pose_lefthand == nil then
        return vwrap(Vector(0,0,0))
    else
        return vwrap(g_VR.tracking.pose_lefthand.pos)
    end
end

--- Gets right controller position.
-- @return vector
function vr_lib.rightPos()
    if g_VR.tracking.pose_righthand == nil then
        return vwrap(Vector(0,0,0))
    else
        return vwrap(g_VR.tracking.pose_righthand.pos)
    end
end

--- Gets headset position.
-- @return vector
function vr_lib.hmdPos()
    if g_VR.tracking.hmd == nil then
        return vwrap(Vector(0,0,0))
    else
        return vwrap(g_VR.tracking.hmd.pos)
    end
end


--rotations as Angles

--- Gets left controller angle.
-- @return angle
function vr_lib.leftAng()
    if g_VR.tracking.pose_lefthand == nil then
        return awrap(Angle(0,0,0))
    else
        return awrap(g_VR.tracking.pose_lefthand.ang)
    end
end

--- Gets right controller angle.
-- @return angle
function vr_lib.rightAng()
    if g_VR.tracking.pose_righthand == nil then
        return awrap(Angle(0,0,0))
    else
        return awrap(g_VR.tracking.pose_righthand.ang)
    end
end

--- Gets headset angle.
-- @return angle
function vr_lib.hmdAng()
    if g_VR.tracking.hmd == nil then
        return awrap(Angle(0,0,0))
    else
        return awrap(g_VR.tracking.hmd.ang)
    end
end

---------------------------------------------------------------------------------------
--Input--------------------------------------------------------------------------------
---------------------------------------------------------------------------------------

--- Gets all actions (controller input).
-- @return table
function vr_lib.input()
    actions = VRMOD_GetActions()
    if actions.vector2_walkdirection != nil then
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
                primaryfire_analg = actions.vector1_primaryfire,
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

end
