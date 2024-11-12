function onLoad(saved_data)
    clockInitialized = false

    if saved_data ~= "" then
        local loaded_data = JSON.decode(saved_data)
        clockInitialized = loaded_data[1]
    end

    if not clockInitialized then
        self.Clock.startStopwatch()
        self.Clock.paused = true
        clockInitialized = true
        updateSave()
    end
end

function updateSave()
    local data_to_save = {
        clockInitialized
    }
    saved_data = JSON.encode(data_to_save)
    self.script_state = saved_data
end

function onPlayerTurn(player, previous_player)
    if previous_player ~= nil then
        if previous_player.color == "Yellow" then
            self.Clock.paused = true
        end
    end
    if player ~= nil then
        if player.color == "Yellow" then
            self.Clock.paused = false
        end
    end
end
