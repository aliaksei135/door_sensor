-- Pins
LED_PIN = 8
ERROR_PIN = 5
SWITCH_PIN = 7

--Load secrets
dofile("secrets.lua")

--WiFi Setup
station_cfg = {}
station_cfg.ssid = ssid
station_cfg.pwd = pwd
station_cfg.save = true


--Callbacks
function onDoorOpen()
    gpio.trig(SWITCH_PIN)
    print("Door Open Triggered")
    tmr.alarm(0,3000,tmr.ALARM_SINGLE,sendDoorOpen)
    gpio.write(LED_PIN, gpio.HIGH)
end

function onDoorClose()
    gpio.trig(SWITCH_PIN)
    print("Door Close Triggered")
    tmr.alarm(1,3000, tmr.ALARM_SINGLE, sendDoorClosed)
    gpio.write(LED_PIN, gpio.HIGH)
end

function sendDoorOpen()
    tmr.delay(500)
    if(gpio.read(SWITCH_PIN) == gpio.HIGH) then
        -- Confirmed door opening
        postUpdate(true)
        print("Door opened")
        gpio.write(LED_PIN, gpio.LOW)
        gpio.trig(SWITCH_PIN, "low",onDoorClose)
    else
        print("Cancelled")
        gpio.write(LED_PIN, gpio.LOW)
        gpio.trig(SWITCH_PIN, "high",onDoorOpen)
    end
end

function sendDoorClosed()
    tmr.delay(500)
    if(gpio.read(SWITCH_PIN) == gpio.LOW) then
        -- Confirmed door close
        postUpdate(false)
        print("Door Closed")
        gpio.write(LED_PIN, gpio.LOW)
        gpio.trig(SWITCH_PIN, "high",onDoorOpen)
    else
        print("Cancelled")
        gpio.write(LED_PIN, gpio.LOW)
        gpio.trig(SWITCH_PIN, "low",onDoorClose)
    end
end

function postUpdate(opened)
    if(opened) then
        status = "Door%20Opened"
    else
        status = "Door%20Closed"
    end
    print("Posting Update")
    conn = tls.createConnection(net.TCP, 1)
    conn:on("receive", function(conn, payload) print(payload) end )
    conn:on("connection", function(cn, ans)
                cn:send("GET /_ah/api/messaging/v1/"
                .."sendPush?deviceId=group.all&text=%20&title="..status
                .."&apikey="..apiKey
                .." HTTP/1.1\r\n"
                .."Host: joinjoaomgcd.appspot.com\r\n"
                .."Connection: close\r\n"
                .."Accept: */*\r\n\r\n")
                print("Update Sent")
            end)
    conn:connect(443,"joinjoaomgcd.appspot.com")
end

function checkWiFi()
    if(wifi.sta.getip() == nil) then
        gpio.write(ERROR_PIN, gpio.HIGH)
        print("WiFi not connected")
    else
        gpio.write(ERROR_PIN, gpio.LOW)
    end
end

-- Set Pins
gpio.mode(LED_PIN,gpio.OUTPUT)
gpio.mode(ERROR_PIN, gpio.OUTPUT)
gpio.write(ERROR_PIN, gpio.LOW)
gpio.mode(SWITCH_PIN, gpio.INT)
gpio.trig(SWITCH_PIN, "high",onDoorOpen)


-- Set WiFi
wifi.setmode(wifi.STATION)
wifi.sta.config(station_cfg)
wifi.sta.autoconnect(1)
print("WiFi status ".. wifi.sta.status())
gpio.write(LED_PIN, gpio.HIGH)
tmr.delay(3000000) -- 3 sec init led
gpio.write(LED_PIN, gpio.LOW)
tmr.alarm(6,3000,tmr.ALARM_AUTO,checkWiFi)
