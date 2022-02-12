FROM ubuntu:18.04

RUN apt-get update -y

RUN apt-get install -y git python
RUN apt-get install -y g++
RUN apt-get install -y ccache gawk make wget cmake
RUN apt-get install -y python-pip
RUN apt-get install -y iproute2

RUN pip install future lxml pymavlink MAVProxy pexpect

RUN useradd --create-home pilot

USER pilot

WORKDIR /home/pilot

RUN git clone --recursive  --depth 1 https://github.com/PX4/PX4-Autopilot.git 


USER root
RUN apt-get install -y python3 python3-dev python3-pip
# Avoid ascii errors when reading files in Python
RUN apt-get install -y locales && locale-gen en_US.UTF-8


USER pilot
RUN pip3 install kconfiglib
RUN pip3 install --user pyserial empy toml numpy pandas jinja2 pyyaml pyros-genmsg packaging
RUN pip3 install --user jsonschema
RUN pip3 install --user future
RUN pip3 install lxml pymavlink MAVProxy pexpect

# Avoid ascii errors when reading files in Python
ENV LANG='en_US.UTF-8' LANGUAGE='en_US:en' LC_ALL='en_US.UTF-8'

WORKDIR /home/pilot/PX4-Autopilot
# Build PX4
RUN git tag v1.9.0-rc3
RUN HEADLESS=1 make px4_sitl_default

# CMD to start PX4 SITL
USER root
RUN apt-get install -y ant

# Env Variables
ENV PX4_HOME_LAT 42.3898
ENV PX4_HOME_LON -71.1476
ENV PX4_HOME_ALT 14.2
ENV HOST_IP 192.168.1.211
ENV NUMBER_OF_INSTANCES 1
ENV MAVLINK_TCP_OUT "5760"

WORKDIR /home/pilot
COPY start.sh /home/pilot

USER root
RUN chmod +x /home/pilot/start.sh

USER pilot

CMD /home/pilot/start.sh ${NUMBER_OF_INSTANCES} ${MAVLINK_TCP_OUT}
