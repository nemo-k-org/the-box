#include <Arduino.h>

void setup() {
    Serial.begin(115200);
}

void loop() {
    Serial.println("The init-project is used only to set up PlatformIO tooling");
}