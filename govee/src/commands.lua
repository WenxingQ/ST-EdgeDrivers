local caps = require('st.capabilities')
local utils = require('st.utils')
local log = require('log')
local goveeapi = require('goveeapi')

local command_handler = {}

----------------
-- Switch command
function command_handler.on_off(_, device, command)
  local on_off = command.command

  local success, msg = goveeapi.send_device_command(device, 'turn', on_off)

  if success then
    if on_off == 'off' then
      return device:emit_event(caps.switch.switch.off())
    end
    return device:emit_event(caps.switch.switch.on())
  else
    log.error("Failed to turn switch on or off: " .. msg)
  end
end

-----------------------
-- Switch level command

-- function command_handler.set_level(_, device, command)
--   local lvl = command.args.level

--   local success, msg = goveeapi.send_device_command(device, 'mode', lvl)

--   if success then
--     if lvl == 0 then
--       device:emit_event(caps.switch.switch.off())
--     else
--       device:emit_event(caps.switch.switch.on())
--     end
--     device:emit_event(caps.switchLevel.level(lvl))
--     return
--   else
--     log.error("Failed to set mode: " .. msg)
--   end
-- end

return command_handler
