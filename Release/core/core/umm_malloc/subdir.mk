################################################################################
# Automatically-generated file. Do not edit!
################################################################################

# Add inputs and outputs from these tool invocations to the build variables 
C_SRCS += \
D:\Arduino\sloeber\arduinoPlugin\packages\esp8266\hardware\esp8266\2.4.1\cores\esp8266\umm_malloc\umm_malloc.c 

C_DEPS += \
.\core\core\umm_malloc\umm_malloc.c.d 

AR_OBJ += \
.\core\core\umm_malloc\umm_malloc.c.o 


# Each subdirectory must supply rules for building sources it contributes
core\core\umm_malloc\umm_malloc.c.o: D:\Arduino\sloeber\arduinoPlugin\packages\esp8266\hardware\esp8266\2.4.1\cores\esp8266\umm_malloc\umm_malloc.c
	@echo 'Building file: $<'
	@echo 'Starting C compile'
	"D:\Arduino\sloeber\/arduinoPlugin/packages/esp8266/tools/xtensa-lx106-elf-gcc/1.20.0-26-gb404fb9-2/bin/xtensa-lx106-elf-gcc" -D__ets__ -DICACHE_FLASH -U__STRICT_ANSI__ "-ID:\Arduino\sloeber\/arduinoPlugin/packages/esp8266/hardware/esp8266/2.4.1/tools/sdk/include" "-ID:\Arduino\sloeber\/arduinoPlugin/packages/esp8266/hardware/esp8266/2.4.1/tools/sdk/lwip2/include" "-ID:\Arduino\sloeber\/arduinoPlugin/packages/esp8266/hardware/esp8266/2.4.1/tools/sdk/libc/xtensa-lx106-elf/include" "-ID:\Arduino\workspace\door_sensor/Release/core" -c -Wall -Wextra -Os -g -Wpointer-arith -Wno-implicit-function-declaration -Wl,-EL -fno-inline-functions -nostdlib -mlongcalls -mtext-section-literals -falign-functions=4 -std=gnu99 -ffunction-sections -fdata-sections -DF_CPU=80000000L -DLWIP_OPEN_SRC -DTCP_MSS=1460 -DDEBUG_ESP_PORT=Serial -DDEBUG_ESP_SSL -DDEBUG_ESP_TLS_MEM -DDEBUG_ESP_HTTP_CLIENT -DDEBUG_ESP_HTTP_SERVER -DDEBUG_ESP_CORE -DDEBUG_ESP_WIFI -DDEBUG_ESP_HTTP_UPDATE -DDEBUG_ESP_UPDATER -DDEBUG_ESP_OTA -DDEBUG_ESP_OOM -include "umm_malloc/umm_malloc_cfg.h" -DARDUINO=10802 -DARDUINO_ESP8266_NODEMCU -DARDUINO_ARCH_ESP8266 "-DARDUINO_BOARD=\"ESP8266_NODEMCU\""  -DESP8266  -I"D:\Arduino\sloeber\arduinoPlugin\packages\esp8266\hardware\esp8266\2.4.1\cores\esp8266" -I"D:\Arduino\sloeber\arduinoPlugin\packages\esp8266\hardware\esp8266\2.4.1\variants\nodemcu" -I"D:\Arduino\sloeber\arduinoPlugin\packages\esp8266\hardware\esp8266\2.4.1\libraries\ESP8266WiFi" -I"D:\Arduino\sloeber\arduinoPlugin\packages\esp8266\hardware\esp8266\2.4.1\libraries\ESP8266WiFi\src" -I"D:\Arduino\sloeber\arduinoPlugin\packages\esp8266\hardware\esp8266\2.4.1\libraries\SPI" -I"D:\Arduino\libraries\PushBullet" -I"D:\Arduino\libraries\PushBullet\src" -MMD -MP -MF"$(@:%.o=%.d)" -MT"$@" -D__IN_ECLIPSE__=1 "$<"  -o  "$@"
	@echo 'Finished building: $<'
	@echo ' '


