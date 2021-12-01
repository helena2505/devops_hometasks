# Devops task 4. Docker

## Task 1. Cmake with flask
The Docker file for this task is in folder cmake-wih-flask.

Build and run the container
```bash
# cd cmake-with-flask
# docker build -t flask .
# docker run -d -p 5000:5000 -t flask
```
The launch of web app can be tested by entering `localhost:5000/app` in web browser.

Built C++ app is installed in the system so if you run docker in interactive mode (`docker run -it`) you can launch C++ app just by inputing `C` in the command line. Shared library `B` is also installed in the system.

## Task 2. Java web app
The docker compose file is in the root folder. There is also a Dockerfile for building and launching java code in directory DostavimVse. To build and run app:
```bash
# docker-compose build
# docker-compose up
```