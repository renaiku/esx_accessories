ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterServerEvent('esx_accessories:pay')
AddEventHandler('esx_accessories:pay', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	xPlayer.removeMoney(Config.Price)
	TriggerClientEvent('esx:showNotification', _source, _U('you_paid') .. '$' .. Config.Price)

end)

RegisterServerEvent('esx_accessories:save')
AddEventHandler('esx_accessories:save', function(skin, accessory)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		
		store.set('has' .. accessory, true)

		if accessory == 'Ears' then		
			store.set('skin', {
				ears_1 = skin.ears_1,
				ears_2 = skin.ears_2
			})
		elseif accessory == 'Helmet' then	
			store.set('skin', {
				helmet_1 = skin.helmet_1,
				helmet_2 = skin.helmet_2
			})
		elseif accessory == 'Mask' then	
			store.set('skin', {
				mask_1 = skin.mask_1,
				mask_2 = skin.mask_2
			})
		elseif accessory == 'Glasses' then
			store.set('skin', {
				glasses_1 = skin.glasses_1,
				glasses_2 = skin.glasses_2
			})
		end

	end)

end)

ESX.RegisterServerCallback('esx_accessories:get', function(source, cb, accessory)

	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_datastore:getDataStore', 'user_' .. string.lower(accessory), xPlayer.identifier, function(store)
		
		local hasAccessory = (store.get('has' .. accessory) and store.get('has' .. accessory) or false)
		local skin = (store.get('skin') and store.get('skin') or {})

		cb(hasAccessory, skin)

	end)

end)

--===================================================================
--===================================================================

ESX.RegisterServerCallback('esx_accessories:checkMoney', function(source, cb)
	
		local xPlayer = ESX.GetPlayerFromId(source)
	
		if xPlayer.get('money') >= Config.Price then
			cb(true)
		else
			cb(false)
		end
	
	end)