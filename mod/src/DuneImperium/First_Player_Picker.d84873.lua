function onload()

    button_parameters = {}
    button_parameters.click_function = 'blank'
    button_parameters.function_owner = self
    button_parameters.label = 'First Player'
    button_parameters.position = {0, 4, 0}
    button_parameters.rotation = {0, 180, 0}
    button_parameters.width = 1600
    button_parameters.height = 500
    button_parameters.font_size = 250
    getObjectFromGUID("d84873").createButton(button_parameters)


    self.setInvisibleTo({
        "White", "Blue", "Red", "Yellow", "Green", "Grey", "Black"
    })
    self.interactable = false

    
end

function blank() end