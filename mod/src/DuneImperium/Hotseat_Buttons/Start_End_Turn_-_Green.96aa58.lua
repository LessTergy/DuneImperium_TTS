-- Static constants
thisColor = "Green"
offseat = "White" -- An unseated color; Teal and Brown are usually safe
confirmForce = false

--Runs on load, creates button and makes sure the lockout is off
function onload()
    self.createButton({
        label = "Color Changer",
        click_function = "changeColor",
        function_owner = self,
        position = { 0, 0.25, 0 },
        height = 1400,
        width = 1400
    })
    lockout = false
    self.setColorTint(thisColor)
end

--Function run when button is pressed
function changeColor(o, clicked_color, alt_click)
    currentColor = Player.getPlayers()[1].color
    desc = self.getDescription()

    -- Button animation
    if lockout == false then
        self.AssetBundle.playTriggerEffect(0) --triggers animation/sound
        lockout = true --locks out the button
        startLockoutTimer() --Starts up a timer to remove lockout
    end

    if alt_click then
        -- Not a left-click, so change the offseat player for this button
        broadcastToAll("Offseat for " .. thisColor .. " button changed to " .. clicked_color, thisColor)
        offseat = clicked_color
    else
        -- Left-click, perform the player swap
        if desc == nil or desc == '' then
            desc = thisColor .. " Seat"
        end

        if currentColor == offseat then
            Player[currentColor].changeColor(thisColor)
            broadcastToAll("Now Playing: " .. desc, thisColor)
        elseif currentColor == thisColor then
            Player[currentColor].changeColor(offseat)
            broadcastToAll(desc .. " ended their turn", thisColor)
        else
            if confirmForce then
                Player[currentColor].changeColor(thisColor)
                broadcastToAll("Now Playing: " .. desc .. "     (Switched from " .. currentColor .. " Seat)", thisColor)
                confirmForce = false
            else
                broadcastToAll(
                    currentColor ..
                    " is still playing! Please end their turn first, or click again to force a turn change.",
                    "Grey")
                confirmForce = true
            end
        end
    end
end

-- Original button timer functions

--Starts a timer that, when it ends, will unlock the button
function startLockoutTimer()
    Timer.create({ identifier = self.getGUID(), function_name = 'unlockLockout', delay = 0.5 })
end

--Unlocks button
function unlockLockout()
    lockout = false
end

--Ends the timer if the object is destroyed before the timer ends, to prevent an error
function onDestroy()
    Timer.destroy(self.getGUID())
end
