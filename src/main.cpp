/**
 * @file       main.cpp
 * @author     Volodymyr Shymanskyy
 * @license    This project is released under the MIT License (MIT)
 * @copyright  Copyright (c) 2015 Volodymyr Shymanskyy
 * @date       Mar 2015
 * @brief
 */

//#define BLYNK_DEBUG
#define BLYNK_PRINT stdout
#ifdef RASPBERRY
  #include <BlynkApiWiringPi.h>
#else
  #include <BlynkApiLinux.h>
#endif
#include <BlynkSocket.h>
#include <BlynkOptionsParser.h>

static BlynkTransportSocket _blynkTransport;
BlynkSocket Blynk(_blynkTransport);

static const char *auth, *serv;
static uint16_t port;

#include <BlynkWidgets.h>

BlynkTimer tmr;

BLYNK_WRITE(V1) // V1 Temperature
{
    for (auto i = param.begin(); i < param.end(); ++i) {
        printf("* %s\n", i.asString());
    }
    printf("Got a value: %s\n", param[0].asStr());
}

BLYNK_WRITE(V3) // V3 Is Work Timer
{
    TimeInputParam t(param);
    if (t.hasStartTime())
    {
        printf("Start: %d:%d:%d\n",
                    t.getStartHour(),
                    t.getStartMinute(),
                    t.getStartSecond());
    }
    else if (t.isStartSunrise())
    {
        printf("Start at sunrise\n");
    }
    else if (t.isStartSunset())
    {
        printf("Start at sunset\n");
    }
    else
    {
        printf("Start else\n");
    }

    // Process stop time

    if (t.hasStopTime())
    {
        printf("Stop: %d:%d:%d\n",
                    t.getStopHour(),
                    t.getStopMinute(),
                    t.getStopSecond());
    }
    else if (t.isStopSunrise())
    {
        printf("Stop at sunrise\n");
    }
    else if (t.isStopSunset())
    {
        printf("Stop at sunset\n");
    }
    else
    {
        printf("Stop else\n");
        // Do nothing: no stop time was set
    }

    // Process timezone
    // Timezone is already added to start/stop time

    printf("Time zone: %s\n", t.getTZ());

    // Process weekdays (1. Mon, 2. Tue, 3. Wed, ...)

    for (int i = 1; i <= 7; i++) {
        if (t.isWeekdaySelected(i)) {
            printf("Day %d is selected\n", i);
        }
    }

    printf("\n");
}

BLYNK_WRITE(V2) // Heat Or Cold
{
    
}

void setup()
{
    Blynk.begin(auth, serv, port);
    tmr.setInterval(1000, [](){
      Blynk.virtualWrite(V0, BlynkMillis()/1000);
    });
}

void loop()
{
    Blynk.run();
    tmr.run();
}


int main(int argc, char* argv[])
{
    parse_options(argc, argv, auth, serv, port);

    setup();
    while(true) {
        loop();
    }

    return 0;
}

