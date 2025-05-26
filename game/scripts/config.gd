extends Node


class CConfig:
    var high_score: int


const config_file_name: String = "user://scores.cfg"


func load_config() -> CConfig:
    var config_file: ConfigFile = ConfigFile.new()
    var error: Error = config_file.load(config_file_name)

    if error == ERR_FILE_NOT_FOUND:
        @warning_ignore('confusable_local_declaration')
        var config: CConfig = CConfig.new()
        config.high_score = 0
        save_config(config)
        return config

    if error != OK:
        print("Error when reading save file: ", error_string(error))
        return null

    var config: CConfig = CConfig.new()
    config.high_score = config_file.get_value("high_score", "high_score")
    return config


func save_config(config: CConfig) -> void:
    var config_file: ConfigFile = ConfigFile.new()
    config_file.set_value("high_score", "high_score", config.high_score)
    var error: Error = config_file.save(config_file_name)
    if error != OK:
        print("Error when writing save file: ", error_string(error))
