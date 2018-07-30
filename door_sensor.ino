#include "Arduino.h"
#include "ESP8266Wifi.h"
#include "Credentials.h"
#include "PushBullet.h"

//WiFi settings for ESP8266
#define PORT 443
WiFiClientSecure client;

PushBullet push = PushBullet(pushbulletApiKey, &client, PORT);

const int switchPin = D2;
const int ledPin = D8;

int durationOpen;
bool currentState;

//The setup function is called once at startup of the sketch
void setup()
{
	pinMode(switchPin, INPUT);
	pinMode(ledPin, OUTPUT);
	digitalWrite(switchPin, HIGH);
	connectWifi();
	digitalWrite(LED_BUILTIN, HIGH);
	delay(3000);
	digitalWrite(LED_BUILTIN, LOW);
}

// The loop function is called in an endless loop
void loop()
{
	durationOpen = pulseInLong(switchPin, LOW);

	if(durationOpen >= 4000){
		//Door open for a non-accidental amount of time
		digitalWrite(ledPin, HIGH);
		if(!currentState){
			sendToPushbullet(true);
		}
	}
	else
	{
		digitalWrite(ledPin, LOW);
		if(currentState){
			sendToPushbullet(false);
		}
	}
}

void sendToPushbullet(bool isOpen)
{
	push.sendNotePush(isOpen?"Door Opened":"Door Closed", "");
	delay(1000);
}

// connect to wifi – returns true if successful or false if not
boolean connectWifi()
{
  boolean state = true;
  int i = 0;
  WiFi.begin(wifiSsid, wifiPwd);
  Serial.println("");
  Serial.println("Connecting to WiFi");

  // Wait for connection
  Serial.print("Connecting");
  while (WiFi.status() != WL_CONNECTED) {
    delay(500);
    Serial.print(".");
    if (i > 10) {
      state = false;
      break;
    }
    i++;
  }
  if (state) {
    Serial.println("");
    Serial.print("Connected to ");
    Serial.println(wifiSsid);
    Serial.print("IP address: ");
    Serial.println(WiFi.localIP());
  }
  else {
    Serial.println("");
    Serial.println("Connection failed.");
  }
  return state;
}
