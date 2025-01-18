local RestartRequired = false
function ExtractKeymapping()
    local SMKConf = GetSHA256("smk.conf")
    local DKeymap = GetSHA256("DefaultKeyMapping.xml")
    
    local CFSMKConf = GetSHA256("ConfigFile\\smk.conf")
    local CFDKeymap = GetSHA256("ConfigFile\\DefaultKeyMapping.xml")
	
    if SMKConf ~= "54490d6cd15e9242dfa1e0c279f30f87e31ed25bf5941b47c3e18a8c4bee2bd4" then
        print("SMKConf hash mismatch, downloading smk.conf...")
        local success = DownloadFile("https://raw.githubusercontent.com/VisionAPI64/EmulatorFiles/main/smk.conf", "smk.conf")
        if success then
            print("smk.conf downloaded successfully.")
			RestartRequired = true
        else
            print("Failed to download smk.conf.")
        end
    end

    if DKeymap ~= "12888abbb957c16e21d2a84ffc524c5beb49ea7aff68fd037abd9f8213ecf3ab" then
        print("DKeymap hash mismatch, downloading DefaultKeyMapping.xml...")
        local success = DownloadFile("https://raw.githubusercontent.com/VisionAPI64/EmulatorFiles/main/DefaultKeyMapping.xml", "DefaultKeyMapping.xml")
        if success then
            print("DefaultKeyMapping.xml downloaded successfully.")
			RestartRequired = true
        else
            print("Failed to download DefaultKeyMapping.xml.")
        end
    end

    if CFSMKConf ~= "54490d6cd15e9242dfa1e0c279f30f87e31ed25bf5941b47c3e18a8c4bee2bd4" then
        print("CFSMKConf hash mismatch, downloading ConfigFile\\smk.conf...")
        local success = DownloadFile("https://raw.githubusercontent.com/VisionAPI64/EmulatorFiles/main/smk.conf", "ConfigFile\\smk.conf")
        if success then
            print("ConfigFile\\smk.conf downloaded successfully.")
			RestartRequired = true
        else
            print("Failed to download ConfigFile\\smk.conf.")
        end
    end

    if CFDKeymap ~= "12888abbb957c16e21d2a84ffc524c5beb49ea7aff68fd037abd9f8213ecf3ab" then
        print("CFDKeymap hash mismatch, downloading ConfigFile\\DefaultKeyMapping.xml...")
        local success = DownloadFile("https://raw.githubusercontent.com/VisionAPI64/EmulatorFiles/main/DefaultKeyMapping.xml", "ConfigFile\\DefaultKeyMapping.xml")
        if success then
            print("ConfigFile\\DefaultKeyMapping.xml downloaded successfully.")
			RestartRequired = true
        else
            print("Failed to download ConfigFile\\DefaultKeyMapping.xml.")
        end
    end
	if RestartRequired then
		local appDataPath = GetAndroidTBoxPath()
		local success = DownloadFile("https://raw.githubusercontent.com/VisionAPI64/EmulatorFiles/main/TVM_100.xml", appDataPath)
		 if success then
            print("TVM_100.xml downloaded successfully.")
			
        else
            print("Failed to download TVM_100.xml")
        end
	end
end

function RegistryKeymap()
	if ChangeRegistry(2, "SOFTWARE\\Tencent\\MobileGamePC", "com.tencent.ig_ContentScale", 2, "dword") then
		print("Registry changed")
		RestartRequired = true
	end
	
	if ChangeRegistry(2, "SOFTWARE\\Tencent\\MobileGamePC", "com.tencent.ig_FPSLevel", 120, "dword") then
		print("Registry changed")
		RestartRequired = true
	end
	
	if ChangeRegistry(2, "SOFTWARE\\Tencent\\MobileGamePC", "com.tencent.ig_RenderQuality", 2, "dword") then
		print("Registry changed")
		RestartRequired = true
	end
	
	if ChangeRegistry(2, "SOFTWARE\\Tencent\\MobileGamePC", "RootEnabled", 0, "dword") then
		print("Registry changed")
		RestartRequired = true
	end
	
	if ChangeRegistry(2, "SOFTWARE\\Tencent\\MobileGamePC", "VMDeviceManufacturer", "Samsung", "string") then
		print("Registry changed")
		RestartRequired = true
	end
	
	if ChangeRegistry(2, "SOFTWARE\\Tencent\\MobileGamePC", "VMDeviceModel", "SM-X910", "string") then
		print("Registry changed")
		RestartRequired = true
	end
end
ExtractKeymapping()
GlobalLikeMouseMovement()
RegistryKeymap()

if RestartRequired then
	RestartSelf()
end

