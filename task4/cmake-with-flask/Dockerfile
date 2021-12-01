FROM ubuntu:focal

# Install packages
RUN export DEBIAN_FRONTEND=noninteractive && \
    apt-get update && \
    apt-get install -y build-essential \
    cmake \
    python3.10 \
    python3-pip && \
    pip install Flask

# Making a user
RUN useradd -m techproguser

COPY . /home/techproguser/cproject

# Build & install cmake poject
RUN cd /home/techproguser/cproject && \
    cmake . && \
    make && \
    cp lib/*.so /usr/lib && \
    cp B/*.h /usr/include && \
    cp C/*.h /usr/include && \
    cp bin/C /usr/bin

# flask app source
ENV FLASK_APP /home/techproguser/cproject/app.py

# user
USER techproguser

# Running flask app
CMD flask run --host=0.0.0.0 --port=5000
