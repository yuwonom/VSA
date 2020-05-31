# VSA
VSA is a mobile application as a visualisation and monitoring tool for Vehicle Situational Awareness research project.

---
## Server Scripts

- **VSA.py**: Base library.
- **broker.py**: Store MQTT broker sensitive information, including broker IP address, port, access username, and password.
- **request_handler.py**: The main server script to handle communication and message transactions among clients.
- **request_simulator.py**: The simulator to mock client message request.
- **scalability_tester.py**: Placeholder script to perform scalability test by mocking the presence of clients in large scale.
- **traffic_listener.py**: Listen and update traffic events from QLD traffic API. See [here](https://qldtraffic.qld.gov.au/media/more/qldtraffic-website-api-specification-V1-2.pdf?lang=en-AU) for API documentation.

---
## Project Setup

To have the full ecosystem working, you need to:
1. Run the server script
2. Run the app

#### Running the server script
- Open `servers/broker.py` and fill the MQTT broker information
- To add your intersections, open `request_handler.py` and search `intersections` under `#global variables` section. Add your intersections using the following format `vsa.Intersection("$ID", $LAT, $LNG, $RAD)`. Replace `$ID` with the intersection id, `$LAT` and `$LNG` with intersection center coordinate, and `$RAD` with the intersection radius.
- In a terminal, run `python3 servers/request_handler.py`.

#### Running the app
- Go to `Src` folder.
- Run `flutter packages get`.
- Run `flutter run`.
- Once the app runs, navigate to the settings page by tapping a _gear_ icon on the top right corner. Scroll down to **Broker** section and fill in the correct information.