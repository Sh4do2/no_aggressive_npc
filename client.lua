Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)  -- Kører løbende

        local playerPed = PlayerPedId()  -- Få spillerens ped

        -- Sæt NPC'ers adfærd til at ignorere spilleren
        SetEveryoneIgnorePlayer(PlayerId(), true)
        SetPoliceIgnorePlayer(PlayerId(), true)

        -- Loop gennem alle NPC'er i nærheden
        for ped in EnumeratePeds() do
            if not IsPedAPlayer(ped) then  -- Sørg for, at det ikke er en spiller
                SetPedFleeAttributes(ped, 0, false)  -- Forhindrer NPC'er i at stikke af
                SetPedCombatAttributes(ped, 46, false)  -- Deaktiverer aggression
                SetPedCanBeTargetted(ped, false)  -- NPC'er kan ikke målrette spilleren
                SetPedCanRagdoll(ped, true)  -- Tillader normal ragdoll-effekt

                -- Fjern våben fra NPC'er
                RemoveAllPedWeapons(ped, true)

                -- Sæt NPC'ers forhold til spilleren som venlig
                SetPedRelationshipGroupHash(ped, GetHashKey("PLAYER"))
            end
        end
    end
end)

-- Funktion til at iterere gennem alle NPC'er
function EnumeratePeds()
    return coroutine.wrap(function()
        local handle, ped = FindFirstPed()
        local success
        repeat
            coroutine.yield(ped)
            success, ped = FindNextPed(handle)
        until not success
        EndFindPed(handle)
    end)
end
